%% Part 4 – Basic Equalizer

clear; close all;

%% 1) Load one of the anechoic recordings just to get fs
[in_bass, fs]  = audioread('Part4_recordings/bassoon.flac');
[in_cell, ~]   = audioread('Part4_recordings/cello.flac');
[in_flut, ~]   = audioread('Part4_recordings/flute.flac');
[in_trum, ~]   = audioread('Part4_recordings/trumpet.flac');

% Align lengths by zero-padding shorter signals
Lmax = max([numel(in_bass), numel(in_cell), numel(in_flut), numel(in_trum)]);
in_bass(end+1:Lmax) = 0;
in_cell(end+1:Lmax)  = 0;
in_flut(end+1:Lmax)  = 0;
in_trum(end+1:Lmax)  = 0;

%% 2) Gaussian LPF ve HPF tasarımı
N = round(0.01 * fs);                  % filtre uzunluğu yaklaşık 0.01 saniye
n = -floor(N/2):floor(N/2);

% --- LPF ---
fc_lp = 400;  % low-pass cut-off frekansı (Hz)
sigma_lp = fs / (2*pi*fc_lp);  % zaman domeninde sigma hesapla
h_lpf = exp(-n.^2 / (2*sigma_lp^2));
h_lpf = h_lpf / sum(h_lpf);  % normalize et

% --- HPF (spekral tersleme) ---
fc_hp = 400;  % high-pass cut-off frekansı (Hz)
sigma_hp = fs / (2*pi*fc_hp);
h_g = exp(-n.^2 / (2*sigma_hp^2));
h_g = h_g / sum(h_g);
h_hpf = -h_g;
h_hpf(floor(end/2)+1) = h_hpf(floor(end/2)+1) + 1;  % delta ekle

% DTFT hesapla
w = linspace(0, pi, 1024);
H_lpf = DTFT(h_lpf, n, w);
H_hpf = DTFT(h_hpf, n, w);

% Frekans yanıtını çiz
figure;
subplot(2,1,1);
plot(w/pi*(fs/2), abs(H_lpf)); title('Gaussian LPF |H(f)|'); xlabel('Hz'); grid on;
subplot(2,1,2);
plot(w/pi*(fs/2), abs(H_hpf)); title('Gaussian HPF |H(f)|'); xlabel('Hz'); grid on;

%% 4) Inspect each anechoic instrument in the frequency domain
max_len = min(fs * 1, Lmax);
files = dir('Part4_recordings/*.flac');
for k = 1:numel(files)
    [x,~] = audioread(fullfile(files(k).folder, files(k).name), [1, max_len]);
    n_x   = 0:length(x)-1;
    X     = DTFT(x, n_x, w);

    figure;
    plot(w/pi*(fs/2), 20*log10(abs(X)+1e-6));
    title( ['DTFT Magnitude: ', files(k).name] );
    xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
end

%% 5) Blend ‘orchestra’ through LPF & HPF via ConvFUNC_M
orch   = in_bass + in_cell + in_flut + in_trum;
t_orch = (0:Lmax-1)/fs;

% Downsample to speed up convolution
ds_factor = 2;
orch_ds = downsample(orch, ds_factor);
h_lpf_ds = downsample(h_lpf, ds_factor);
h_hpf_ds = downsample(h_hpf, ds_factor);

% Convolution
y_lp_full = ConvFUNC_M(orch_ds, h_lpf_ds).';
y_hp_full = ConvFUNC_M(orch_ds, h_hpf_ds).';

% trim to 'same' length
ds_Lmax = length(orch_ds);
mid = floor(length(h_lpf_ds)/2);
y_lp = y_lp_full(mid+1 : mid+ds_Lmax);
y_hp = y_hp_full(mid+1 : mid+ds_Lmax);

% Normalize
maxVal = max([max(abs(y_lp)), max(abs(y_hp)), max(abs(orch_ds))]);
y_lp = y_lp / maxVal * 0.99;
y_hp = y_hp / maxVal * 0.99;
orch_ds = orch_ds / maxVal * 0.99;

% Write files (commented out for speed)
 soundsc(orch_ds, fs/ds_factor); disp('Playing: original orchestra'); pause(length(orch_ds)/(fs/ds_factor) + 1);
 soundsc(y_lp,  fs/ds_factor);   disp('Playing: after Gaussian LPF'); pause(length(y_lp)/(fs/ds_factor) + 1);
 soundsc(y_hp,  fs/ds_factor);   disp('Playing: after Gaussian HPF');

% audiowrite('orchestra_LPF.flac', y_lp, fs/ds_factor);
% audiowrite('orchestra_HPF.flac', y_hp, fs/ds_factor);

%% 6) 3×1 subplot: original / LPF output / HPF output
figure;
t = (0:ds_Lmax-1)/(fs/ds_factor);
subplot(3,1,1);
plot(t, orch_ds);
title('Original Orchestra'); xlabel('Time (s)'); ylabel('Amp');

subplot(3,1,2);
plot(t, y_lp);
title('After Gaussian LPF'); xlabel('Time (s)'); ylabel('Amp');

subplot(3,1,3);
plot(t, y_hp);
title('After Gaussian HPF'); xlabel('Time (s)'); ylabel('Amp');
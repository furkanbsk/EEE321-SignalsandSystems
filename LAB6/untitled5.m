
clear; close all;

[in_bass, fs] = audioread('Part4_recordings/bassoon.flac');
[in_cell, ~]  = audioread('Part4_recordings/cello.flac');
[in_flut, ~]  = audioread('Part4_recordings/flute.flac');
[in_trum, ~]  = audioread('Part4_recordings/trumpet.flac');

L = max([length(in_bass), length(in_cell), length(in_flut), length(in_trum)]);
in_bass(end+1:L) = 0;
in_cell(end+1:L) = 0;
in_flut(end+1:L) = 0;
in_trum(end+1:L) = 0;

% Create orchestra
orch = in_bass + in_cell + in_flut + in_trum;
t = (0:L-1)/fs;

%Design Gaussian LPF and HPF
N = round(0.01 * fs);                  % Filter length
n = -floor(N/2):floor(N/2);           % Time index

sigma_lpf = 0.4 * N;
h_lpf = exp(-(n.^2)/(2*sigma_lpf^2));
h_lpf = h_lpf / sum(h_lpf);

sigma_hpf = 0.02 * N;
h_g = exp(-(n.^2)/(2*sigma_hpf^2));
h_g = h_g / sum(h_g);
h_hpf = -h_g; h_hpf((end+1)/2) = h_hpf((end+1)/2) + 1;

%Plot frequency responses
w = linspace(0, pi, 1024);
H_lpf = DTFT(h_lpf, n, w);
H_hpf = DTFT(h_hpf, n, w);

figure;
subplot(2,1,1);
plot(w/pi*(fs/2), abs(H_lpf), 'LineWidth', 1.5);
title('Magnitude Response - LPF'); xlabel('Frequency (Hz)'); ylabel('|H_{LPF}(f)|'); grid on;

subplot(2,1,2);
plot(w/pi*(fs/2), abs(H_hpf), 'LineWidth', 1.5);
title('Magnitude Response - HPF'); xlabel('Frequency (Hz)'); ylabel('|H_{HPF}(f)|'); grid on;

max_len = fs;
w = linspace(0, pi, 1024);
files = dir('Part4_recordings/*.flac');

for k = 1:numel(files)
    [x, ~] = audioread(fullfile(files(k).folder, files(k).name), [1 max_len]);
    n_x = 0:length(x)-1;
    X = DTFT(x, n_x, w);

    figure;
    plot(w/pi*(fs/2), 20*log10(abs(X) + 1e-6), 'LineWidth', 1.2);
    title(['DTFT of ', files(k).name]);
    xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on;
end

% Convolve using ConvFUNC_M
y_lp = ConvFUNC_M(orch, h_lpf)';
y_hp = ConvFUNC_M(orch, h_hpf)';

y_lp = y_lp(N:end-N+1);
y_hp = y_hp(N:end-N+1);
orch = orch(1:length(y_lp));
t = t(1:length(y_lp));

% Normalize
max_val = max([max(abs(y_lp)), max(abs(y_hp)), max(abs(orch))]);
y_lp = y_lp / max_val * 0.99;
y_hp = y_hp / max_val * 0.99;
orch = orch / max_val * 0.99;

soundsc(orch, fs); disp('Playing: Original'); pause(length(orch)/fs + 1);
soundsc(y_lp, fs);  disp('Playing: LPF');     pause(length(y_lp)/fs + 1);
soundsc(y_hp, fs);  disp('Playing: HPF');     pause(length(y_hp)/fs + 1);

audiowrite('orchestra_LPF.flac', y_lp, fs);
audiowrite('orchestra_HPF.flac', y_hp, fs);

figure;
subplot(3,1,1);
plot(t, orch, 'LineWidth', 1.1); title('Original Orchestra'); ylabel('Amplitude'); grid on;
subplot(3,1,2);
plot(t, y_lp, 'LineWidth', 1.1); title('After LPF'); ylabel('Amplitude'); grid on;
subplot(3,1,3);
plot(t, y_hp, 'LineWidth', 1.1); title('After HPF'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;
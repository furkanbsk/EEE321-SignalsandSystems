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
%% 2) Build Gaussian LPF & HPF from h_GMAV:
%   – use the same window‐length N as in Part 3
N     = round(0.01*fs);            
n     = -floor(N/2):floor(N/2);    
sigma = [];                        

% LPF impulse response
sigma = 0.4;
h_lpf = exp(-(n.^2)/(2*sigma^2));
h_lpf = h_lpf / sum(h_lpf);

% HPF via spectral inversion of Gaussian
sigma = 0.02;
h_g   = exp(-(n.^2)/(2*sigma^2));
h_g   = h_g / sum(h_g);
% invert and add delta to center tap
h_hpf = -h_g;
h_hpf(floor(end/2)+1) = h_hpf(floor(end/2)+1) + 1;

%% 3) Frequency responses via your DTFT()
w = linspace(0, pi, 2048);
H_lpf = DTFT(h_lpf, n, w);
H_hpf = DTFT(h_hpf, n, w);

figure;
subplot(2,1,1);
plot(w/pi*(fs/2), abs(H_lpf));
title('Gaussian LPF Magnitude Response'); 
xlabel('Frequency (Hz)'); ylabel('|H_{LPF}(f)|');

subplot(2,1,2);
plot(w/pi*(fs/2), abs(H_hpf));
title('Gaussian HPF Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('|H_{HPF}(f)|');


%% 4) Inspect each anechoic instrument in the frequency domain
files = dir('Part4_recordings/*.flac');
for k = 1:numel(files)
    [x,fs] = audioread(fullfile(files(k).folder, files(k).name));
    n_x     = 0:length(x)-1;
    X       = DTFT(x, n_x, w);
    
    figure;
    plot(w/pi*(fs/2), 20*log10(abs(X)));
    title( ['DTFT Magnitude: ', files(k).name] );
    xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
    % listen: sound(x,fs);
    % → comment in your report which freq-bands are strong/weak for each.
end


%% 5) Blend ‘orchestra’ through LPF & HPF
orch = in_bass + in_cell + in_flut + in_trum;
t_orch = (0:Lmax-1)/fs;
y_lp = conv(orch, h_lpf, 'same');
y_hp = conv(orch, h_hpf, 'same');

%% 6) 3×1 subplot: original / LPF output / HPF output
figure;
subplot(3,1,1);
plot(t_orch, orch);
title('Original Orchestra'); xlabel('Time (s)'); ylabel('Amp');

subplot(3,1,2);
plot(t_orch, y_lp);
title('After Gaussian LPF'); xlabel('Time (s)'); ylabel('Amp');

subplot(3,1,3);
plot(t_orch, y_hp);
title('After Gaussian HPF'); xlabel('Time (s)'); ylabel('Amp');

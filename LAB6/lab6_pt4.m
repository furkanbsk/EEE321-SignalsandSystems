%% Part 4: Basic Equalizer Design
clearvars; close all;

% ——————————————
% 1) Build LPF & HPF impulse responses
% ——————————————
fs = 48000;                    % sampling rate (adjust if different)
sigma_lp = 0.4;                % for LPF
sigma_hp = 0.02;               % for HPF
Nwin = round(0.01*fs);         % window length in samples

n = -floor(Nwin/2):floor(Nwin/2);
h_lp = (1/(sigma_lp*sqrt(2*pi))) * exp(-n.^2/(2*sigma_lp^2));
h_lp = h_lp / sum(h_lp);      % normalize energy

% highpass = delta[n] – lowpass[n]
h_hp = [zeros(1,floor(length(h_lp)/2)), 1, zeros(1,floor(length(h_lp)/2))] - h_lp;

% ——————————————
% 2) Plot frequency responses
% ——————————————
w = linspace(0,pi,2048);
Hlp = DTFT(h_lp, n, w);
Hhp = DTFT(h_hp, n, w);

figure;
subplot(2,1,1);
plot(w*(fs/(2*pi)), abs(Hlp));
title('Gaussian‐LPF Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('|H_{LP}(f)|');
grid on;

subplot(2,1,2);
plot(w*(fs/(2*pi)), abs(Hhp));
title('Gaussian‐HPF Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('|H_{HP}(f)|');
grid on;


% ——————————————
% 3) Frequency‐domain analysis of individual instruments
% ——————————————
instruments = {'bassoon.flac','cello.flac','flute.flac','trumped.flac'};
for k = 1:3
    [x, fs2] = audioread(fullfile('Part4_recordings',instruments{k}));
    t = (0:length(x)-1)/fs2;
    X = DTFT(x.', 0:length(x)-1, w);
    
    figure;
    plot(w*(fs2/(2*pi)), 20*log10(abs(X)));
    title(['Spectrum of ', instruments{k}]);
    xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
    grid on;
end

% ——————————————
% 4) Blend into “orchestra” and filter
% ——————————————
[orch, fs3] = audioread(fullfile('Part4_recordings','orchestra.flac'));
y_lp = conv(orch, h_lp, 'same');
y_hp = conv(orch, h_hp, 'same');

t3 = (0:length(orch)-1)/fs3;
figure;
subplot(3,1,1);
plot(t3, orch);
title('Original Orchestra');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t3, y_lp);
title('Orchestra through LPF');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t3, y_hp);
title('Orchestra through HPF');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

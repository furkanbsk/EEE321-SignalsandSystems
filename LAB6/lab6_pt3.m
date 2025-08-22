% Load the audio file
[signal, fs] = audioread('Part3_recording.flac');
t = (0:length(signal)-1)/fs;

% Parameters
N = round(0.01 * fs);         % Length of the filter
sigma = 0.7;                  % Standard deviation for Gaussian
mu = 0;                       % Mean for Gaussian

% -------------------------------
% 1. Simple Moving Average Filter
% -------------------------------
h_smav = ones(1, N) / N;

% -------------------------------
% 2. Gaussian Moving Average Filter
% -------------------------------
n = -floor(N/2):floor(N/2);
h_gmav = (1/(sigma * sqrt(2*pi))) * exp(-((n - mu).^2) / (2*sigma^2));

% Normalize Gaussian filter
h_gmav = h_gmav / sum(h_gmav);

% ------------------------------------
% Filter the signal using convolution
% ------------------------------------
y_smav = conv(signal, h_smav, 'same');
y_gmav = conv(signal, h_gmav, 'same');

% -------------------------------
% Plotting in 2x2 subplot
% -------------------------------
figure;
subplot(2,2,1);
plot(t, signal);
title('Noisy Input Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,2,2);
plot(t, y_smav);
title('Output: Simple Moving Average');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,2,4);
plot(t, y_gmav);
title('Output: Gaussian Moving Average');
xlabel('Time (s)');
ylabel('Amplitude');

% Show filter shapes
subplot(2,2,3);
plot(0:N-1, h_smav, 'b');
hold on;
plot(n + N/2, h_gmav, 'r');
legend('SMAV', 'GMAV');
title('Impulse Responses');
xlabel('Samples');
ylabel('Amplitude');

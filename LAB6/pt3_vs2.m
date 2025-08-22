[x_noisy, fs] = audioread('Part3_recording.flac');
t = (0:length(x_noisy)-1)/fs;

N = round(0.01 * fs);                    
h_SMA = (1/N) * ones(1, N);              
nG = -5:5;                              
sigma = 0.7;
h_GMA = (1/(sigma*sqrt(2*pi))) * exp(-((nG-0).^2)/(2*sigma^2));
h_GMA = h_GMA / sum(h_GMA);             % normalize area to 1

y_SMA = ConvFUNC_M(x_noisy, h_SMA).';    % note transpose back to row
y_GMA = ConvFUNC_M(x_noisy, h_GMA).';

t_SMA = (0:length(y_SMA)-1)/fs;
t_GMA = (0:length(y_GMA)-1)/fs;

figure;
subplot(2,2,1);
plot(t, x_noisy);
xlabel('Time (s)'); ylabel('Amplitude');
title('Noisy Input');

subplot(2,2,3);
plot(t_SMA, y_SMA);
xlabel('Time (s)'); ylabel('Amplitude');
title('SMA Output');

subplot(2,2,4);
plot(t_GMA, y_GMA);
xlabel('Time (s)'); ylabel('Amplitude');
title('Gaussian MA Output');

soundsc(x_noisy, fs);    disp('Playing: Noisy');    pause(length(x_noisy)/fs + 1);
soundsc(y_SMA,   fs);    disp('Playing: SMA filtered'); pause(length(y_SMA)/fs + 1);
soundsc(y_GMA,   fs);    disp('Playing: Gaussian MA');  % end

figure;
subplot(2,1,1);
stem(0:N-1, h_SMA, 'filled');
xlabel('n'); ylabel('h_{SMAV}[n]');
title('Simple Moving‐Average Impulse Response');

subplot(2,1,2);
stem(nG, h_GMA, 'filled');
xlabel('n'); ylabel('h_{GMAV}[n]');
title('Gaussian Moving‐Average Impulse Response');

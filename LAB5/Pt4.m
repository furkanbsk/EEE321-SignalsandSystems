clear

load MA2_songdata.mat

% parameters
sampling_rate = 4000;
Ts = 1/sampling_rate;
time_vector = 0:Ts:50-Ts;

% noisiy signal
corrupted_wave = songdata + 0.05 * randn(length(songdata),1);

% original and noisy comparison
figure()
plot(time_vector, corrupted_wave, 'r--', 'LineWidth', 1.2)
hold on
plot(time_vector, songdata, 'k', 'LineWidth', 1)
hold off
legend('Noisy', 'Orijinal')
xlabel('Time (t)')
ylabel('Amplitude')
title('Orijinal and Noisy song')
grid on

% 5th order finite impulse response
filtered_wave = corrupted_wave;
for n = 5:length(corrupted_wave)
    filtered_wave(n) = (corrupted_wave(n) + corrupted_wave(n-1) + corrupted_wave(n-2) + corrupted_wave(n-3) + corrupted_wave(n-4)) / 5;
end

% Impuls response
impulse_response = [1/5 1/5 1/5 1/5 1/5];

% Freq response
freq_vals = -10:Ts:10;
Hw = @(w) 1/5 * (1 + exp(-1j*w) + exp(-1j*2*w) + exp(-1j*3*w) + exp(-1j*4*w));

% Freq resp plot
figure()
plot(freq_vals, abs(Hw(freq_vals)), 'm', 'LineWidth', 1.5)
xlabel('\omega')
ylabel('|H(e^{j\omega})|')
title('FIR Filter Response')
grid on

% noisy,filtered,original
figure()
plot(time_vector, corrupted_wave, 'r--', 'LineWidth', 1)
hold on
plot(time_vector, filtered_wave, 'g', 'LineWidth', 1.2)
plot(time_vector, songdata, 'b:', 'LineWidth', 1)
hold off
legend('Noisy', 'Filtered', 'Orijinal')
xlabel('Time (t)')
ylabel('Amplitude')
title('Comparison after filtering')
grid on

%sound(filtered_wave, sampling_rate)

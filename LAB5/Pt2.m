clear; close all; clc;

% Sampling parameters
Fs = 360;
dt = 1/Fs;

% Signal definition
signal_fn = @(t) sin(2*pi*2*t) + sin(2*pi*120*t);

% Time vector for plotting
t_plot = 0:dt:2;
plot(t_plot, signal_fn(t_plot));
title('Combined Signal: f1 = 2Hz, f2 = 120Hz');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency candidates
f1_set = [2 4 6];
f2_set = [60 90 120];

% Integration time (exact period)
t_segment = 0:dt:0.5;

% Frequency estimation using ideal T0
projection_f1 = zeros(1,3);
projection_f2 = zeros(1,3);
for k = 1:3
    projection_f1(k) = abs(sum(dt * signal_fn(t_segment) .* sin(2*pi*f1_set(k)*t_segment)));
    projection_f2(k) = abs(sum(dt * signal_fn(t_segment) .* sin(2*pi*f2_set(k)*t_segment)));
end

[~, idx_f1] = max(projection_f1);
[~, idx_f2] = max(projection_f2);
estimated_f1 = f1_set(idx_f1)
estimated_f2 = f2_set(idx_f2)

% Estimation with incorrect T0
t_faulty = 0:dt:(0.5*19/20);
faulty_proj_f1 = zeros(1,3);
faulty_proj_f2 = zeros(1,3);
for k = 1:3
    faulty_proj_f1(k) = abs(sum(dt * signal_fn(t_faulty) .* sin(2*pi*f1_set(k)*t_faulty)));
    faulty_proj_f2(k) = abs(sum(dt * signal_fn(t_faulty) .* sin(2*pi*f2_set(k)*t_faulty)));
end

[~, faulty_idx_f1] = max(faulty_proj_f1);
[~, faulty_idx_f2] = max(faulty_proj_f2);
faulty_estimate_f1 = f1_set(faulty_idx_f1)
faulty_estimate_f2 = f2_set(faulty_idx_f2)

% Noise effect: sigma = 1 and sigma = 10
clean_signal = signal_fn(t_segment);
signal_noisy_1 = clean_signal + 1*randn(1, length(clean_signal));
signal_noisy_10 = clean_signal + 10*randn(1, length(clean_signal));

% Frequency estimation with sigma = 1
est_f1_noise1 = zeros(1,3);
est_f2_noise1 = zeros(1,3);
for k = 1:3
    est_f1_noise1(k) = abs(sum(dt * signal_noisy_1 .* sin(2*pi*f1_set(k)*t_segment)));
    est_f2_noise1(k) = abs(sum(dt * signal_noisy_1 .* sin(2*pi*f2_set(k)*t_segment)));
end
[~, f1_idx_noise1] = max(est_f1_noise1);
[~, f2_idx_noise1] = max(est_f2_noise1);
guess_f1_noise1 = f1_set(f1_idx_noise1)
guess_f2_noise1 = f2_set(f2_idx_noise1)

% Frequency estimation with sigma = 10
est_f1_noise10 = zeros(1,3);
est_f2_noise10 = zeros(1,3);
for k = 1:3
    est_f1_noise10(k) = abs(sum(dt * signal_noisy_10 .* sin(2*pi*f1_set(k)*t_segment)));
    est_f2_noise10(k) = abs(sum(dt * signal_noisy_10 .* sin(2*pi*f2_set(k)*t_segment)));
end
[~, f1_idx_noise10] = max(est_f1_noise10);
[~, f2_idx_noise10] = max(est_f2_noise10);
guess_f1_noise10 = f1_set(f1_idx_noise10)
guess_f2_noise10 = f2_set(f2_idx_noise10)

% Monte Carlo simulation for different sigma
sigma_vals = [1 10 50 100];
error_rate = zeros(1, length(sigma_vals));
total_trials = 100000;

for s = 1:length(sigma_vals)
    errors = 0;
    sigma = sigma_vals(s);
    for trial = 1:total_trials
        % Random f1 and f2
        true_f1 = f1_set(randi(3));
        true_f2 = f2_set(randi(3));
        test_signal = sin(2*pi*true_f1*t_segment) + sin(2*pi*true_f2*t_segment);
        test_noisy = test_signal + sigma*randn(1, length(t_segment));
        
        resp_f1 = zeros(1,3);
        resp_f2 = zeros(1,3);
        for k = 1:3
            resp_f1(k) = abs(sum(dt * test_noisy .* sin(2*pi*f1_set(k)*t_segment)));
            resp_f2(k) = abs(sum(dt * test_noisy .* sin(2*pi*f2_set(k)*t_segment)));
        end
        
        [~, pred_idx_f1] = max(resp_f1);
        [~, pred_idx_f2] = max(resp_f2);
        pred_f1 = f1_set(pred_idx_f1);
        pred_f2 = f2_set(pred_idx_f2);
        
        if pred_f1 ~= true_f1
            errors = errors + 1;
        end
        if pred_f2 ~= true_f2
            errors = errors + 1;
        end
    end
    error_rate(s) = errors / (2 * total_trials);
end

% Plot error vs sigma
figure;
stem(sigma_vals, error_rate, 'filled');
xlabel('Noise Level (\sigma)');
ylabel('Normalized Error Rate');
title('Effect of Noise on Frequency Estimation');
grid on;
ylim([0 1]);

% As noise increases, the error in frequency identification increases.
% Longer observation time (larger T0) or averaging multiple runs could reduce error.


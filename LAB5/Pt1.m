clear; clc;

Ts = 0.001;  % time resolution
N1 = 1;      % hormonic limit for x1

% first func
t1 = 0:Ts:pi-Ts;
signal1 = @(t) cos(2*t + pi/4);
x1_vals = signal1(t1);
a1_coeffs = FSAnalysis(x1_vals, N1);  

plot_range1 = -pi/2:Ts:pi/2;
x1_approx = zeros(1, length(plot_range1));

for k = -N1:N1
    x1_approx = x1_approx + a1_coeffs(N1 + k + 1) * exp(1j * 2 * pi / pi * k * plot_range1);
end

figure;
plot(plot_range1, signal1(plot_range1), 'b', 'LineWidth', 3);
hold on;
plot(plot_range1, real(x1_approx), 'g--', 'LineWidth', 3);
title('Approximation of x1(t) with N=1');
xlabel('t'); ylabel('x1(t)');
legend('Original x1(t)', 'Fourier Approximation');
hold off;

%second func
x2 = @(t) mod(t, 2) <= 1;

t2 = 0:Ts:2-Ts;
N2 = 100;
x2_vals = x2(t2);
a2_coeffs = FSAnalysis(x2_vals, N2);

% N = 1, approximations for 10 and 100
approx_x2 = @(N) arrayfun(@(t) ...
    sum(arrayfun(@(k) a2_coeffs(N2 + k + 1) * exp(1j * 2 * pi / 2 * k * t), -N:N)), t2);

x2_1 = approx_x2(1);
x2_10 = approx_x2(10);
x2_100 = approx_x2(100);

% plots
figure;
plot(t2, x2(t2), 'k', 'LineWidth', 1.5); hold on;
plot(t2, real(x2_1), 'r--', 'LineWidth', 1.3);
plot(t2, real(x2_10), 'b--', 'LineWidth', 1.3);
plot(t2, real(x2_100), 'g--', 'LineWidth', 1.3);
xlim([-0.2 2.2]);
title('Fourier Series Approximation of x2(t)');
xlabel('t'); ylabel('x2(t)');
legend('Original x2(t)', 'x2_{1}(t)', 'x2_{10}(t)', 'x2_{100}(t)');
hold off;

% Max error comp
max_err_10 = max(abs(x2(t2) - real(x2_10)));
max_err_100 = max(abs(x2(t2) - real(x2_100)));

fprintf('Max error between x(t) and x_{10}(t): %.4f\n', max_err_10);
fprintf('Max error between x(t) and x_{100}(t): %.4f\n', max_err_100);

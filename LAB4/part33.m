Ts = 0.001;
t = 0:Ts:4;
k = 30;
x3_t = t .* (t >= 0) - (t - 3) .* ((t - 3) >= 0) - 3 * ((t - 3) >= 0);

M = 100;
c = 0.1;
kappa = 0.1;

% System is initially at rest
y = zeros(1,length(x3_t)+2);
y(2) = 0;
y(1) = 0;

% Backward approximation loop
for i = 3:length(x3_t)+2
    y(i) = (x3_t(i-2) + 2*M*y(i-1) + c*y(i-1) - M*y(i-2))/(M+c+kappa);
end

%plotting x3 and y
figure;
subplot(2, 1, 1);
plot(t, x3_t, 'r', 'LineWidth', 1.5);
xlabel("n");
ylabel("x_3[n]");
title("INPUT of x(t)");

subplot(2, 1, 2);
plot(t, y(3:end),Color="k");
xlabel("n");
ylabel("y[n]");
title("OUTPUT y(t)");

%plotting the coefficients
figure;
x_coeff = FSAnalysis(x3_t, k);
y_coeff = FSAnalysis(y, k);

sgtitle("x_{3}(t) and y(t) Fourier Series Coefficients")
subplot(2, 2, 1);
stem(-k:k, real(x_coeff),"filled",Color="#D95319");
title("x_{3}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2, 2, 2);
stem(-k:k, imag(x_coeff),"filled",Color="#A2142F");
title("x_{3}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

subplot(2, 2, 3);
stem(-k:k, real(y_coeff) ,"filled",Color="#D95319");
title("y(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

subplot(2, 2, 4);
stem(-k:k, imag(y_coeff),"filled",Color="#A2142F");
title("y(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

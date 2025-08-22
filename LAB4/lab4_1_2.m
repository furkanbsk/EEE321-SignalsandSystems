clear

Ts = 0.001;
k = 30;
x_k = -k:1:k;

x1 = @(t) 8*cos(10*pi*t) + 20*sin(6*pi*t) - 11 * cos(30*pi*t);
x2 = @(t) exp(-t);

x1_1 = x1(0:Ts:1-Ts);
x1_coeff = FSAnalysis(x1_1,k);

figure
sgtitle("x_{1}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(x1_coeff),"filled",Color="#D95319")
title("x_{1}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(x1_coeff),"filled",Color="#A2142F")
title("x_{1}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

x2_1 = x2(-1:Ts:(1-Ts));
x2_coeff = FSAnalysis(x2_1,k);

figure
sgtitle("x_{2}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(x2_coeff),"filled",Color="#D95319")
title("x_{2}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(x2_coeff),"filled",Color="#A2142F")
title("x_{1}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")


x1_par_left = Ts*(1/1) * sum(abs(x1_1).^2)
x1_par_right = sum(abs(x1_coeff).^2)

x2_par_left = Ts*(1/2) * sum(abs(x2_1).^2)
x2_par_rigt = sum(abs(x2_coeff).^2)
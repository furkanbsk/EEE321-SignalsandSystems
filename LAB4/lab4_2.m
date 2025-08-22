clear

Ts = 0.001;
k = 30;
x_k = -k:1:k;


u = @(t) double(t>=0);
r = @(t) t .* u(t);

x3 = @(t) r(mod(t,4)) - r(mod(t,4)-3) - 3*u(mod(t,4)-3);
x3_1 = x3(0:Ts:4-Ts);
x3_coeff = FSAnalysis(x3_1,k);

figure
sgtitle("x_{3}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(x3_coeff),"filled",Color="#A2142F")
title("x_{3}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(x3_coeff),"filled",Color="#77AC30")
title("x_{3}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")


z1 = @(t) x3(-t);
z2 = @(t) diff(x3(t));
z3 = @(t) (x3(t+2));
z4 = @(t) ((x3(t)+x3(-t))/2);
z5 = @(t) (x3(t).^2);

z1_1 = z1(0:Ts:4-Ts);
z2_1 = z2(0:Ts:4-Ts);
z3_1 = z3(0:Ts:4-Ts);
z4_1 = z4(0:Ts:4-Ts);
z5_1 = z5(0:Ts:4-Ts);

z1_coeff = FSAnalysis(z1_1,k);
z2_coeff = FSAnalysis(z2_1,k);
z3_coeff = FSAnalysis(z3_1,k);
z4_coeff = FSAnalysis(z4_1,k);
z5_coeff = FSAnalysis(z5_1,k);

%z1
figure
sgtitle("z_{1}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(z1_coeff),"filled",Color="#A2142F")
title("z_{1}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(z1_coeff),"filled",Color="#77AC30")
title("z_{1}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

%z2
figure
sgtitle("z_{2}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(z2_coeff),"filled",Color="#A2142F")
title("z_{2}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(z2_coeff),"filled",Color="#77AC30")
title("z_{2}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

%z3
figure
sgtitle("z_{3}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(z3_coeff),"filled",Color="#A2142F")
title("z_{3}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(z3_coeff),"filled",Color="#77AC30")
title("z_{3}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

%z4
figure
sgtitle("z_{4}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(z4_coeff),"filled",Color="#A2142F")
title("z_{4}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(z4_coeff),"filled",Color="#77AC30")
title("z_{4}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
ylim([-1 1.5])

figure
sgtitle("z_{5}(t) Fourier Series Coefficients")
subplot(2,1,1)
stem(x_k,real(z5_coeff),"filled",Color="#A2142F")
title("z_{5}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,1,2)
stem(x_k,imag(z5_coeff),"filled",Color="#77AC30")
title("z_{5}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

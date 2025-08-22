    clear;
M = 100;
c = 0.1;
kk = 0.1;

Ts = 0.001;
k = 30;
x_k = -k:1:k;

u = @(t) double(t>=0);
r = @(t) t .* u(t);


x3 = @(t) r(mod(t,4)) - r(mod(t,4)-3) - 3*u(mod(t,4)-3);
x3_1 = x3(0:Ts:4-Ts);

y = zeros(1,length(0:Ts:(4.5-Ts)));


for n= 3:length(0:Ts:4.5-Ts)
y(n) = (1/(M/(1^2)+c/1+kk))*(y(n-1)*(2*M/(1^2)-c/1)-y(n-2)*(M/1^2) +x3(n));
end

figure;

subplot(2,1,1)
plot(0:Ts:4-Ts,x3_1,Color="r")
xlabel("n")
ylabel("x_{3}[n]")
title("Input Signal x_{3}[n]")
subplot(2,1,2)
plot(0:Ts:4.5-Ts,y,Color="k")
xlabel("n")
ylabel("y[n]")
title("Output Signal y[n]")

x3_coeff = FSAnalysis(x3_1,k);
y_coeff = FSAnalysis(y,k);

figure
sgtitle("x_{3}(t) and y(t) Fourier Series Coefficients")
subplot(2,2,1)
stem(x_k,real(x3_coeff),"filled",Color="#D95319")
title("x_{3}(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,2,2)
stem(x_k,imag(x3_coeff),"filled",Color="#A2142F")
title("x_{3}(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

subplot(2,2,3)
stem(x_k,real(y_coeff),"filled",Color="#D95319")
title("y(t) Real Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")
subplot(2,2,4)
stem(x_k,imag(y_coeff),"filled",Color="#A2142F")
title("y(t) Imaginary Part of Fourier Series Coeff.")
xlabel("k")
ylabel("Amplitude")

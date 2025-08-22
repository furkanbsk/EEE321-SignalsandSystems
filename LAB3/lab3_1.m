%Sampling Period
Ts = 0.01;
Tt = -5:Ts:5;

%define sequence responses

dirdelta = zeros(size(Tt));
dirdelta(Tt==0) = 1;

u = @(t) double(t>=0);

h_t = cumsum(dirdelta); %cumulative sum of dirac delta
s_t = cumsum(u(Tt)); %cumulative sum of heaviside step func



figure;

subplot(2,1,1);
stem(Tt, h_t);
title('Impulse Response h(t)');
xlabel('Time (t)');
ylabel('h(t)');
grid on;
subplot(2,1,2);
stem(Tt, s_t);
title('Unit-Step Response s(t)');
xlabel('Time (t)');
ylabel('s(t)');
grid on;

%--for part 2
figure ;
n = 0;
for i = 1:5
 f_1 = exp(-Tt * 0.05*n) .* u(Tt);
 sgtitle('Discrititzed Responses');
 subplot(5,2,2*i-1);
 stem(Tt, f_1);
 title(['Discritized impulse response with a =',num2str(n.*0.05)]);
 xlabel('n');
 ylabel('h[n]');
 f_2 = ((1-exp(-Tt * 0.05*i))/(0.05*i)) .* u(Tt);
 subplot(5,2,2*i);
 stem(Tt, f_2);
 title(['Discritized step response with a =',num2str(i.*0.05)]);
 xlabel('n');
 ylabel('h[n]');
 n = n+1;

end

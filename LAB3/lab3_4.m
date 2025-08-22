a = 1;
t = -10:1:10;
u = @(n) double(n>=0);
func_coeff = [1, -2, 1];

%Dirac delta func shift operations 
dirdelta = zeros(size(t));
dirdelta(t==0) = 1;

f_1 = filter(func_coeff, a, dirdelta);

y_out = conv(dirdelta, func_coeff);

figure;
stem(t, y_out(1:length(t)), 'filled');
title('Impulse Response Manually');
xlabel('n');
ylabel('h[n]');
ylim([-2.1 1.2]);
xlim([-1 10]);

figure;
stem(t, f_1, 'filled');
title('Impulse Response in Matlab');
xlabel('n');
ylabel('h[n]');
ylim([-2.1 1.2]);
xlim([-1 10]);

figure;
N = 0:5;
f_sum = sumElements(f_1,N);

disp(f_sum);
stem(N, f_sum, 'filled');
title('BIBO STABILITY');
xlabel('N');
ylabel('SUM');


figure; %Responses for x1 and x2

n= 0:50;
x1 = @(n) 8*(u(n) - u(n-4)) - 4*(u(n-4) - u(n-13)); %x1(t)
x2 = @(n) (0.3).^n .* u(n); %x2(t)
y_1 = convFUNC(x1(n),func_coeff);
y_2 = convFUNC(x2(n),func_coeff);


stem(0:length(y_1)-1, y_1, 'filled'); 
title('Response for x1');
xlabel('n');
ylabel('Amplitude');

figure;
stem(0:length(y_2)-1, y_2, 'filled');
title('Response for x2');
xlabel('n');
ylabel('Amplitude');




%figure;
%range_N = 0:5;
%f_1 = @(t) dirdelta(t + 1) - [0, dirdelta(1:end-1)];
%f_2 = conv(f_1,u(t));
%f_a = f_1.* u(t-range_N);
%f_3 = sumElements(f_a,range_N);
%disp(dirdelta_shift);
   
%disp("SHİFT",num2str(f_1));
%disp(f_2);
%stem(t, f_3(1:11), 'filled');


% baştaki diff derivation kısmını düzeltecem , conv değiştir

%Dirac delta func shift operations 
%dirdelta = zeros(size(t));
%dirdelta(t==0) = 1;
%dirdelta_shift = zeros(size(t));
%dirdelta_shift(t==1) = 1;
%dirdelta_2shift = zeros(size(t));
%dirdelta_2shift(t==2) = 1;

%f_1 = (dirdelta - 2.*dirdelta_shift + dirdelta_2shift);



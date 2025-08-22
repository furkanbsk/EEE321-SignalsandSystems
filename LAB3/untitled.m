t = -100:1:100;
u = @(n) double(n>=0);
dirdelta = @(n) double(n == 0);


func_coeff = [1, -2, 1, zeros(1,length(t))];
%func_coeff = @(x,n) x(n) - 2*x(n-1) + x(n-2);

%unp_imp = dirdelta(t);
%h_inv = cumsum(cumsum(unp_imp));

%func_coeff = [1, -2, 1];
%h_inv = sumElements(sumElements([1, func_coeff,t),t);
f_i =  conv(func_coeff, h_inv);

%Dirac delta func shift operations 
%dirdelta = zeros(size(f_i));
%dirdelta(t==0) = 1;



figure;
stem(t,dirdelta(1:length(t+2)));
%Invertibility Check
%if all(f_i == [1, zeros(1, length(f_i)-1)])


if all(f_i == dirdelta)
    Invertibility = "Invertıble";
else
    Invertibility = "Not Invertıble";
end

%h_inv = cumsum(cumsum([1, zeros(1, 10)]));
%h_inv= deconvFUNC([1 0], func_coeff);

n = -5:1:20;
%n= 0:50;
x1 = @(n) 8*(u(n) - u(n-4)) - 4*(u(n-4) - u(n-13)); %x1(t)
x2 = @(n) (0.3).^n .* u(n); %x2(t)
y_11 =  convFUNC(x1(n), h_inv);
y_22 =  convFUNC(x2(n), h_inv);

figure;
stem(f_i);
title('Convolution Result (System * Inverse)');

figure;
stem(t, h_inv, 'filled'); 
title('Impulse Response of Inverse System');
xlabel('n');
ylabel('Amplitude');



figure;
stem(t, y_11(1:length(t)), 'filled');
title('Response for x1');
xlabel('n');
ylabel('Amplitude');

figure;
stem(t, y_22(1:length(t)), 'filled');
title('Response for x2');
xlabel('n');
ylabel('Amplitude');

    if all(h_inv(t < 0) == 0)  % Negatif zamanlı bileşenler sıfır mı?
        fprintf('The inverse system is causal.\n');
    else
        fprintf('The inverse system is not causal.\n');
    end


    if sum(h_inv ~= 0) == 1  % Sadece bir yerde sıfırdan farklı mı?
        fprintf('The inverse system is memoryless.\n');
    else
        fprintf('The inverse system has memory.\n');
    end

A = "The system is";
fprintf('%s %s\n', A, Invertibility);

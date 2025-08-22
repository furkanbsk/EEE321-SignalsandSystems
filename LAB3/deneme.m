clear

unit_impulse = @(n) double(n == 0);
unit_step = @(n) double(n>=0);

x1 = @(n) 8*(unit_step(n)-unit_step(n-4))-4*(unit_step(n-4)-unit_step(n-13));
x2 = @(n) power(0.3,n).*unit_step(n)

second_order_diff = @(x,n) x(n) - 2*x(n-1) + x(n-2)

second_order_diff_impulse_response = @(n) second_order_diff(unit_impulse,n)

n_range = -5:1:20

figure
stem(n_range,second_order_diff_impulse_response(n_range))
title("Impulse Respone of Second Order Diff")
xlabel("n")
ylabel("h[n]")
grid on

BIBO_N = 1:5;
BIBO_imp_rep_sec_diff = sumElements(second_order_diff_impulse_response,BIBO_N)

figure
stem(BIBO_N,BIBO_imp_rep_sec_diff)
title("BIBO Stability Impulse Respone of Second Order Diff")
xlabel("N")
ylabel("Summation up to N")
grid on


second_order_diff_x1_response = @(n) second_order_diff(x1,n)
second_order_diff_x2_response = @(n) second_order_diff(x2,n)

figure
stem(n_range,second_order_diff_x1_response(n_range))
title("x1 Respone of Second Order Diff")
xlabel("n")
ylabel("y1[n]")
grid on

figure
stem(n_range,second_order_diff_x2_response(n_range))
title("x2 Respone of Second Order Diff")
xlabel("n")
ylabel("y2[n]")
grid on

n_range_2 = -100:1:100
unit_impulse_array = unit_impulse(n_range_2);
inverse_impulse_response_array = cumsum(cumsum(unit_impulse_array));

invertibility_check = conv(second_order_diff_impulse_response(n_range_2),inverse_impulse_response_array);
figure
stem(n_range_2,invertibility_check(n_range_2+201))
title("Invertibility Check")
xlabel("n")
ylabel("h^(-1)[n] * h[n]")
grid on


if (invertibility_check(n_range_2+201) == unit_impulse_array)
    fprintf("System Is Invertible \n")
else
    fprintf("System Is Not Invertible \n")
end

if (all(inverse_impulse_response_array < 0) == 0)
    fprintf("System Is Causal \n")
else
    fprintf("System Is Not Causal \n")
end




figure
stem(n_range_2,inverse_impulse_response_array)
title("Impulse Respone of Reverse System")
xlabel("n")
ylabel("h^(-1)[n]")
grid on

inverse_second_order_diff_x1_response = conv(inverse_impulse_response_array,x1(n_range_2));
inverse_second_order_diff_x2_response = conv(inverse_impulse_response_array,x2(n_range_2));

figure
stem(n_range_2,inverse_second_order_diff_x1_response(n_range_2 + 201))
title("x1 Respone of Reverse System")
xlabel("n")
ylabel("y1[n]")
grid on


figure
stem(n_range_2,inverse_second_order_diff_x2_response(n_range_2 + 201))
title("x2 Respone of Reverse System")
xlabel("n")
ylabel("y2[n]")
grid on
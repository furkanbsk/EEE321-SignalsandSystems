% Define the input sequences
a = [0, 0.05, 0.1, 0.25, 0.5];
n = 0:50;


%unit step function
u = @(n) double(n>=0);
%define sequences
x1 = @(n) 8*(u(n) - u(n-4)) - 4*(u(n-4) - u(n-13)); %x1(t)
x2 = @(n) (0.3).^n .* u(n); %x2(t)

y_1 = zeros(length(n) + length(n) - 1, length(a));
y_2 = zeros(length(n) + length(n) - 1, length(a));

for i = 1:length(a)
    h = exp(-a(i) * n) .* u(n);
    y_1(:,i) = conv(x1(n),h,'full');
    y_2(:,i) = conv(x2(n),h,'full');   
end

E1 = zeros(size(y_1, 1), length(a) - 1);
E2 = zeros(size(y_2, 1), length(a) - 1);


s = 1;
for i = 2:length(a)
    E1(:, i-1) = y_1(:, 1) - y_1(:, i);
    E2(:, i-1) = y_2(:, 1) - y_2(:, i);
 

end

figure;
stem(n, y_1(1:length(n), 1), 'filled');
title('y1[n] for a = 0');
xlabel('n');
ylabel('Amplitude');
figure;
stem(n, y_2(1:length(n), 1), 'filled');
title('y2[n] for a = 0');
xlabel('n');
ylabel('Amplitude');



figure;
for i = 1:length(a)-1
 subplot(size(E1, 2), 1, i);
 stem(n, E1(1:length(n), i), 'filled');
 title(['E1 for a =',' ',num2str(a(i+1))]);
 xlabel('n');
 ylabel('Difference');
end

figure;
for i = 1:length(a)-1
 subplot(size(E2, 2), 1, i);
 stem(n, E2(1:length(n), i), 'filled');
 title(['E2 for a =',' ',num2str(a(i+1))]);
 xlabel('n');
 ylabel('Difference');
end













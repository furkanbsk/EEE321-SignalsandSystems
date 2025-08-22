
%The signals
x = [0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0];
h = [0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0];

y=convFUNC(x,h); % call function

%plot the signal as discrete
sgtitle('Convolution Operation ξ[n]*ξ[n]')
subplot(3,1,1)
stem(x);
title('x[n] = ξ[n]');
subplot(3,1,2)
stem(h);
title('h[n] = ξ[n]');
subplot(3,1,3)
stem(y);
title('y[n]');

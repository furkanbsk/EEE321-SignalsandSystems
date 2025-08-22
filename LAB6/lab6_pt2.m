% φ₁[n] = 1 for n=0:4, zero otherwise
n = 0:5;
phi1 = double(n<5);

% frequency grid
w = -pi:0.001:pi;

% forward & inverse
X  = DTFT(phi1, n, w);
phi2 = IDTFT(X, n, w);

% error
E = sum((phi1(:)-phi2(:)).^2);
disp(E)

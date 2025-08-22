
% Define input sequences
x1 = [2, 4, 6, 8, 7, 6, 5, 4, 3, 2, 1];
x2 = [1, 2, 1, -1];

%conv via DTFT/IDTFT (Part 2.2)
tic
y1 = ConvFUNC(x1, x2, 0:length(x1)-1, 0:length(x2)-1, 0:(length(x1)+length(x2)-2), -pi:0.001:pi);
t1 = toc;

%conv via matrix multiplication (Part 2.3)
tic
y2 = ConvFUNC_M(x1, x2);
t2 = toc;

%MATLAB built-in
tic
y3 = conv(x1, x2);
t3 = toc;

%Compare lengths
L = length(x1) + length(x2) - 1; 
assert( all([numel(y1),numel(y2),numel(y3)] == L), 'Output lengths mismatch' );


E12 = sum((y1(:) - y3(:)).^2);
E23 = sum((y2(:) - y3(:)).^2);
E13 = sum((y1(:) - y2(:)).^2);


fprintf('\nElapsed times (seconds):\n');
fprintf('  ConvFUNC (DTFT/IDTFT):     %g\n', t1);
fprintf('  ConvFUNC_M (matrix):       %g\n', t2);
fprintf('  MATLAB conv() built-in:    %g\n', t3);

fprintf('\nNorm-square differences:\n');
fprintf('  ||y1 − y3||^2 = %g\n', E12);
fprintf('  ||y2 − y3||^2 = %g\n', E23);
fprintf('  ||y1 − y2||^2 = %g\n\n', E13);

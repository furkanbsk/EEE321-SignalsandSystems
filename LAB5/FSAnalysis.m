
function [fsCoeffs] = FSAnalysis(x,k)

N = length(x);
n = 0:1:N-1;
fsCoeffs = zeros(1,2*k+1);
for range = -k:1:k;
fsCoeffs(1,range+k+1) = (1/N)*sum(x.*exp(-1j*range*(2*pi/N)*n));

end
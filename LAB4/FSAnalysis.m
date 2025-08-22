function [fsCoeffs] = FSAnalysis(x,k)
% fsCoeffs: An array that contains the Fourier series coefficients of your signal from -k to k
% x :  One complete period of the sampled continuous-time signal 
% k: The number of two-sided Fourier series coefficients that you will estimate

N = length(x); %total number of sample in single period
n = 0:1:N-1; %sample index
fsCoeffs = zeros(1,2*k+1);
for i = -k:1:k
fsCoeffs(1,i+k+1) = (1/N)*sum(x.*exp(-1j*i*(2*pi/N)*n));
end
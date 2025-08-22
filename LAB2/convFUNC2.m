function y = ConvFUNC2(x, h)
 Nx = length(x);
 Nh = length(h);
 Ny = Nx + Nh - 1;

 y = zeros(1, Ny);
 h_new = [zeros(1, Nh-1), x, zeros(1, Nh-1)];

 for n = 1:Ny
 y(n) = sum(h_new(n:n+Nh-1) .* h );
 end
end
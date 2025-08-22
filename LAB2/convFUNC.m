function [y] = convFUNC(x, h)
    Nx = length(x);
    Nh = length(h);
    Ny = Nx + Nh - 1; 
    y = zeros(1, Ny); 
    
    
    
    flp_h = fliplr(h); % Flip h for convolution operation
    new_h = [zeros(1, Nh-1), x, zeros(1, Nh-1)];
    
 %perform convolution
    for n = 1:Ny
        y(n) = sum(new_h(n : n+Nh-1) .* flp_h); %Compute the convolution by sum n's
    end
end
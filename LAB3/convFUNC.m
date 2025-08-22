function [y] = convFUNC(x, h)
    Nx = length(x); % Length of input x
    Nh = length(h); % Length of input h
    Ny = Nx + Nh - 1; % Length of the output y
    y = zeros(1, Ny); % Initialize output y with zeros
    
    % Perform convolution
    for n = 1:Ny
        % Compute the range of indices for x and h
        k_start = max(1, n - Nh + 1); % Ensure k_start is at least 1
        k_end = min(n, Nx); % Ensure k_end does not exceed Nx
        k_range = k_start:k_end; % Valid range of indices
        
        % Compute the convolution sum
        if ~isempty(k_range)
            y(n) = sum(x(k_range) .* h(n - k_range + 1));
        end
    end
end
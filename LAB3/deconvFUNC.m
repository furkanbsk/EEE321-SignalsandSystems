function [x_est] = deconvFUNC(y, h)
    Ny = length(y);
    Nh = length(h);
    Nx = Ny - Nh + 1; % Estimated length of x
    x_est = zeros(1, Nx); % Initialize output x

    % Perform deconvolution iteratively
    for n = 1:Nx
        % Compute the first value of x_est
        x_est(n) = y(n) / h(1); % Assuming h(1) is nonzero

        % Subtract the effect of x_est(n) from the next elements in y
        y(n:n+Nh-1) = y(n:n+Nh-1) - x_est(n) * h;
    end
end

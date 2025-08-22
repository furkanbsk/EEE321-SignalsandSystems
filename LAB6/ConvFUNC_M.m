function y = ConvFUNC_M(x,h)
    H = spdiags( ones(length(x)+length(h)-1,1) * h(:).', -(0:length(h)-1), length(x)+length(h)-1, length(x) );
    y = H * x(:);
end

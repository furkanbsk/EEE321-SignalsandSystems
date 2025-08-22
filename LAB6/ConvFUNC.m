function [y] = ConvFUNC(x, h, nx, nh, ny, w)
y = real(IDTFT(DTFT(x, nx, w) .* DTFT(h, nh, w), ny, w));
end

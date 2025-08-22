function X = DTFT(x,n,w)
  X = exp(-1j*(n(:)*w(:).')).' * x(:);
end

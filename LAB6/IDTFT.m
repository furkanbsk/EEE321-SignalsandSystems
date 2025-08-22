function x = IDTFT(X,n,w)
  x = real( (exp(1j*(n(:)*w(:).')) * X(:)) / length(w) );
end

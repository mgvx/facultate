function L = lagrange2(x, f, X)
% NEWTON

A = div_diff(x,f);

for k=1:length(X)
  c = cumprod(X(k)-x);
  c = [1 c(1:end-1)];
  L(k) = sum(A(1,:).*c);
end
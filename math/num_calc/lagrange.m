function L = lagrange(x, f, X)

m = length(x);
A = zeros(1,m);

for i=1:m
  A(i) = 1/prod(x(i)-x([1:i-1,i+1:m]));
end


for k=1:length(X)
  %D = A./(X(k)-x);
  D = A./(X(k)-x+1e-40);
  N = D.*f;
  L(k) = sum(N)/sum(D);
end
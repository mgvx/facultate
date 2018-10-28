function [H,dH] = herm(x, f, df, X)
% NEWTON

z = zeros(1,length(x)*2);
z(1:2:end) = x;
z(2:2:end) = x;

A = div_diff_herm(x, f, df);
H=[];

n = length(x);
dH = zeros(1,2*n);

for k=1:length(X)
  c = cumprod(X(k)-z);
  c = [1 c(1:end-1)];
  H(k) = sum(A(1,:).*c);
  
  for j=1:(2*n-1)
    dH(k) = dH(k) + polyval(polyder(poly(z(1:j))), X(k)) * A(1,j+1);
  end
  
end

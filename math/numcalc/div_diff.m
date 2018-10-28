function A = div_diff(x,y)

n = length(x);
A = zeros(n);

%A(:,0) = x;
A(:,1) = y;

for i=2:n
  A(1:n-i+1,i) = diff(A(1:n-i+2, i-1))./(x(i:n)-x(1:n-i+1))';
end

function A = aitken(x,f,X)

n = length(x);
A = zeros(n);

%A(:,0) = x;
A(:,1) = f;

for j=2:n
  for i=j:n
    A(i,j) = (1/(x(i)-x(j-1)))*(A(j-1,j-1)*(x(i)-X)-A(i,j-1)*(x(j-1)-X));
  end
end
A = A(end:end);
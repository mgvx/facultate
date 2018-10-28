h = 0.25
a = 1
ai = @(i) a + i.*h
f = @(x) sqrt((5.*x.^2+1))

m = 7
A = zeros(m+1);

for i=1:m
  A(i,1) = ai((i-1));
end
for i=1:m
  A(i,2) = f(A(i,1));
end

for j=3:m+1
  for i=1:(m-j+2)
    A(i,j) = A(i+1,j-1) - A(i,j-1);
  end
end

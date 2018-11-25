function A = div_diff_herm(x, f, df)
%z = repelem(x,2)
z = zeros(1,length(x)*2);
z(1:2:end) = x;
z(2:2:end) = x;

n = length(z);
A = zeros(n);

zz = zeros(1,length(f)*2);
zz(1:2:end) = f;
zz(2:2:end) = f;

A(:,1) = zz';
A(1:2:end,2) = df';
A(2:2:end-2,2) = diff(f)'./diff(x)';

for i=3:n
  A(1:n-i+1,i) = diff(A(1:n-i+2, i-1))./(z(i:n)-z(1:n-i+1))';
end

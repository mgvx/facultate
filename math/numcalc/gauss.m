function x = gauss(A, b)
n = length(b);
E = [A b];

for p=1:n-1
    [~,q] = max(abs(E(p:n,p)));
    q = q+p-1;
    E([p q],:) = E([q p],:);
    for j=p+1:n;
        E(j,:) = E(j,:)-E(j,p)/E(p,p)*E(p,:);
    end
end

A = E(1:n, 1:n);
b = E(:, n+1);
x = zeros(n,1);

x(n) = b(n)/A(n,n);
for i=n-1:-1:1
    x(i) = (b(i)-(A(i,:)*x))/A(i,i);
end


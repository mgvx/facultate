function R = seidel(A, b, er)

n = length(b);
x0 = rand(n,1);
x1 = rand(n,1);

it = 0;
while norm(x1 - x0) > er
    it += 1;
    x0 = x1;
    for i=1:n
        x1(i) = (b(i) - A(i,1:i-1)*x1(1:i-1) - A(i,i+1:n)*x0(i+1:n)) / A(i,i);
    end
end
it += 1

R = x1;


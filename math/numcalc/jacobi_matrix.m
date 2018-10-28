function R = jacobi_matrix(A, b, er)

% gauss seibel M = tril(A)
% S.O.R. M = tril(A)

% jacobi
M = diag(diag(A));

N = M-A;
T = M\N;
c = M\b;


n = length(b);
x0 = rand(n,1);
x1 = rand(n,1);

it = 0;
while norm(x1-x0) > (1-norm(T))/norm(T)*er
    it += 1;
    x0 = x1;
    x1 = T*x0+c;
end
it += 1

R = x1;




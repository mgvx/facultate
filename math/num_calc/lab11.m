n = 10;
o = ones(n-1, 1);
A = 3*eye(n)-diag(o,-1)-diag(o,1);
b = [2; o(1:n-2); 2];

jacobi(A, b, 0.00001)
seidel(A, b, 0.00001)

jacobi_matrix(A, b, 0.00001)

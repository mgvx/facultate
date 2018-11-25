A = [10, 7, 8, 7;
7, 5, 6, 5;
8, 6, 10, 9;
7, 5, 9, 10];
As = [10, 7, 8.1, 7.2;
7.08, 5.04, 6, 5;
8, 5.98, 9.98, 9;
6.99, 4.99, 9, 9.98];
b = [32; 23; 33; 31];
bs = [32.1; 22.9; 33.1; 30.9];

d = 0

x = A\b;
cond(A)
xs = A\bs;
fun9(b, bs, x, xs)
xs = As\b;
fun9(b, bs, x, xs)

d
cond(vander(1./(1:20)))
cond(vander(1./(1:10)))
cond(vander(1./(1:5)))

d
cond(hilb(20))
cond(hilb(10))
cond(hilb(5))

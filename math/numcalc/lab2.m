
f1 = @(x) x
f2 = @(x) 3/2*x.^2-1/2
f3 = @(x) 5/2*x.^3-3/2*x
f4 = @(x) 35/8*x.^4-15/4*x.^2+3/8

subplot (2, 2, 1)
fplot(f1,[0,1]);
legend("l1")
subplot (2, 2, 2)
fplot(f2,[0,1]);
legend("l2")
subplot (2, 2, 3)
fplot(f3,[0,1]);
legend("l3")
subplot (2, 2, 4)
fplot(f4,[0,1]);
legend("l4")


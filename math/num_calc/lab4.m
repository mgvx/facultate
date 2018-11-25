x = [1 2 3 4 5];
f = [22 23 25 30 28];
lagrange(x, f, 2.5)
lagrange2(x, f, 2.5)

X = linspace(0,6,10);
clf
hold on
plot(x,f)
plot(X,lagrange2(x,f,X),"--r")


fun = @(x) e.^sin(x);
X = linspace(0,6,1000);
x = linspace(0,6,13)
clf
hold on
plot(x,fun(x),"*")
plot(X,lagrange2(x,fun(x),X),"--r")
%x = [2,4,6,8]
%y = [4,8,14,16]
%div_diff(x,y)

x = [1930, 1940, 1950, 1960, 1970, 1980];
f = [123203, 131669, 150697, 179323, 203212, 226505];
lagrange(x, f, [1955])
lagrange(x, f, [1995])

x = [100,121,144];
f = [10,11,12];
lagrange(x, f, [115])

%fun = @(x) (1+cos(pi.*x))./(1+x)
fun = @(x) 1./(1+x.^2)
X = [-5:0.01:5];
x = linspace(-5,5,13);

clf
hold on
plot(X,fun(X))
plot(X,lagrange2(x,fun(x),X),"--r")


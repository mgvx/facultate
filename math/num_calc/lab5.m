d = [0 225 383 623 993];
t = [0 3 5 8 13];
f = [75 77 80 74 72];
X = [10 10 10];
[H, dh] = herm(t, d, f, X);




fun = @(x) ln(x); 
x = [1 2];
f = [0 0.6931];
df = [1 0.5];

fun = @(x) sin(2*x); 
dfun = @(x) 2*cos(2*x);

x = [-5 -2 1 2 5]
f = fun(x)
df = dfun(x)

X = linspace(-5,5,15);
X = [-4 0 4]
[H, dH] = herm(x, f, df, X)

clf
hold on
plot(X,dH);

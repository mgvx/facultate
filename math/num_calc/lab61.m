x = linspace(1,7,7);
y = [13 15 20 14 15 13 10];

m = length(f);
d = m*sum(x.^2)-(sum(x))^2;

a = (m*sum(x*y')-sum(x)*sum(y))/d;
b = (sum(x.^2)*sum(y)-sum(x*y')*sum(x))/d;

fun = @(x) a*x+b;
fun(8)

hold on
plot(x,fun(x),"--r")
plot(x,y,"*")


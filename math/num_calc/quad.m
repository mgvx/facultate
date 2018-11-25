function R = quad(a,b,n,f)
x = linspace(a,b,n+1);
R = ((b-a)./(2.*n)).*(f(a)+f(b)+2*sum(f(x(2:n))));
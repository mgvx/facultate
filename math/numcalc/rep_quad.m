function R = rep_quad(a,b,n,f)
x = linspace(a+(b-a)/(2*n),b-(b-a)/(2*n),n);
R = ((b-a)./n).*sum(f(x));

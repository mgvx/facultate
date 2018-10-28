%f = @(x)(x-2)^2 - log(x) 
%x = bisect(f, 1, 2, 100, 0.0001)
%f(x)

%f = @(x) x-cos(x)
%x = falsepos(f, 0.5, pi/4, 100, 0.0001)
%f(x)

%f = @(x) x.^3 - x.^2 - 1
%x = secant(f, 1, 2, 100, 0.0001)
%f(x)

f = @(x) x-cos(x)
fd = @(x) 1+sin(x)
x = newton12(f, fd, pi/4, 100, 0.0001)
f(x)


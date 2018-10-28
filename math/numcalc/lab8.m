
%a=1;
%b=1.5;
%
%f = @(x) e.^(-x.^2);
%
%R = rep_quad(a, b, 2, f)
%R = rep_quad(a, b, 10, f)
%R = rep_quad(a, b, 150, f)

%
%a=0;
%b=1;
%
%f = @(x) 2./(1 + x.^2);
%
%pi/2
%R = romberg(a, b, 0.00001, f)
%R = rep_simpson(a, b, 0.00001, f)

a=1;
b=3;

f = @(x) 100./x.^2 .* sin(10./x);

R = adaptive(a, b, 0.000001, f)
%R = rep_simpson(a, b, 0.00001, f)

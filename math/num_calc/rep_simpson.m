function R = rep_simpson(a, b, er, f)

qs = 111;
qs2 = 777;
qt = 333;

h = b-a;
qt2 = h/2*(f(a)+f(b));

k=1;
while (abs(qs2 - qs) > er)
    j = 1:2^(k-1);

    qt = qt2;
    qs = qs2;

    qt2 = qt./2 + h/(2.^k) * sum(f(a + (2*j-1)/(2^k)*h));
    qs2 = 1./3.*(4.*qt2 - qt);

    k += 1;
end

R = qt2;


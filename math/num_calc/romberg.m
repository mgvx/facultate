function R = romberg(a, b, er, f)

h = b-a;
qt = 666;
qt2 = h/2*(f(a)+f(b));

k=1;
while (abs(qt2 - qt) > er)
    j = 1:2^(k-1);
    qt = qt2;
    qt2 = qt/2 + h/(2.^k) * sum(f(a + (2*j-1)/(2^k)*h));
    k += 1;
end

R = qt2;


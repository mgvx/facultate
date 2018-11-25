function c = secant(f, a, b, nit, err)
i=0;
while i<nit && abs(a-b)>err
    c = b - f(b)*(b-a)/(f(b)-f(a));
    a = b;
    b = c;
    i += 1;
    end
end
i

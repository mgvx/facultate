function c = bisect(f, a, b, nit, err)
i=0;
while i<nit && abs(a-b)>err
    i += 1;
    c = (a+b)/2;
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
end
i

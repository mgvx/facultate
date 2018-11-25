function c = falsepos(f, a, b, nit, err)
i=0;
while i<nit && (a-b)>err
    i += 1;
    c = (a*f(b) - b*f(a))/(f(b)-f(a));
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
end
i

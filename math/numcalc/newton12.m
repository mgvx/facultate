function x = newton12(f, fd, x, nit, err)
i=0;
while i<nit && abs(f(x))>err
    i += 1;
    x = x - f(x)/fd(x);
    end
end
i

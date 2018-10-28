function I = adaptive(a, b, er, f)

I1 = rep_simpson(a,b, er, f);
I2 = rep_simpson(a,(a+b)/2, er, f) + rep_simpson((a+b)/2,b, er, f);

if (abs(I1-I2) < er)
    I = I2;
else
    I = adaptive(a, (a+b)/2, er/2, f) + adaptive((a+b)/2, b, er/2, f);
end

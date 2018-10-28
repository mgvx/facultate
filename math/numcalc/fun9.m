function R = fun9(b, bs, x, xs)

rb = norm(b-bs)/norm(b);
rx = norm(x-xs)/norm(x);
R = rx/rb;



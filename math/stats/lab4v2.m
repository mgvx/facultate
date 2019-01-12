% Normal Aprox of Binomial
% bino(n,p) ~ norm(miu=np, sigma=v/np(1-p))
% p moderate, n large;

p = input('p = ');
for n = 1:3:100
    xpdf = 0:n;
    ypdf = binopdf(xpdf,n,p);
    plot(xpdf,ypdf,'*-');
    pause(0.5);
end

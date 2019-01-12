% binomial distribution
n = input('no trials: ');
p = input('prob success: ');

x_pdf = 0:n;
y_pdf = binopdf(x_pdf,n,p);
plot(x_pdf,y_pdf,'bx')
hold on

x_cdf = 0:0.01:n;
z_cdf = binocdf(x_cdf,n,p);
plot(x_cdf,z_cdf,'g.')
legend('pdf','cdf');

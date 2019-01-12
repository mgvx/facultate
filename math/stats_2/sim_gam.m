clear all

% sim Gamma using ITM and the fact sum of Exp
a = input('a (pos int) = ');
lambda = input('lambda (>0) = ');
err = input('er = '); % 1e-2, 1e-3
alpha = input('alpha (0,1) = '); % level of significance
N = ceil(0.25*(norminv(alpha/2, 0, 1)/err)^2); % number of simulations

for i=1:N
    X(i) = sum(-lambda*log(rand(a,1)));
end

% compare graphically the cdf of Gamma distr
x = 0:0.01:(-a*lambda*log(lambda*err));
xcdf = gamcdf(x,a,lambda);

for i=1:length(x)
    mysim(i) = mean(X<x(i));
end

clf
plot(x, xcdf, x, mysim, 'r:')
legend('cdf of Gamma', 'Simulation')



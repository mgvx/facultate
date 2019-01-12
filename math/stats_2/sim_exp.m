clear all

% sim exp distr using a ITM
lambda = input('lambda (>0) = ');
err = input('er = '); % 1e-2, 1e-3
alpha = input('alpha (0,1) = '); % level of significance
N = ceil(0.25*(norminv(alpha/2, 0, 1)/err)^2);
%N = input('num of simulations = ');

for i=1:N
    X(i) = -1/lambda*log(rand);
end

% compare graphically the cdf of Exp(1/lambda) distr
x = 0:0.01:(1/lambda*log(lambda/err));
xcdf = expcdf(x,1/lambda);

for i=1:length(x)
    mysim(i) = mean(X<x(i));
end

clf
plot(x, xcdf, x, mysim, 'r:')
legend('cdf of Exp', 'Simulation')

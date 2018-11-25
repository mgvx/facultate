clear all

% sim geom distr using ITM
p = input('p (0,1) = ');
X = ceil(log(rand)/log(1-p)-1);

err = input('er = '); % 1e-2, 1e-3
alpha = input('alpha (0,1) = '); % level of significance
N = ceil(0.25*(norminv(alpha/2, 0, 1)/err)^2); % number of simulations
% fprintf('N = %7d\n')

for i=1:N
    X(i) = ceil(log(rand)/log(1-p)-1);
end

% compare to true Geo(p) graphically
UX = unique(X);
nX = hist(X, length(UX));
rel_freq = nX/N;

k = 0:10;
pk = geopdf(k,p);

clf
plot(k, pk, '*', UX, rel_freq, 'ro')
legend('Geo distr', 'Simulation')








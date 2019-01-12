% simulate Poisson(p) distr
clear all

lambda = input('lambda (>0) = ');
N = input('num of simulations = ');

for j=1:N
    U = rand;
    i=0;
    F(j) = exp(-lambda);
    while U >= F(j)
        i = i+1;
        F(j) = F(j) + exp(-lambda)*(lambda^i)/gamma(i+1);
    end
    X(j) = i;
end

% compare to true Poisson(p) graphically
UX = unique(X);
nX = hist(X, length(UX));
rel_freq = nX/N;

k = 0:30;
pk = poisspdf(k,lambda);

clf
plot(k, pk, '*', UX, rel_freq, 'ro')
legend('Poisson distr', 'Simulation')


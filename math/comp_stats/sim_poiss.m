clear all

% sim poiss distr using a spacial method
lambda = input('lambda (>0) = ');
N = input('num of simulations = ');

for i=1:N
    X(i) = 0; % initial value
    U = rand;
    while U>exp(-lambda)
        U = U*rand;
        X(i) = X(i)+1;
    end
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

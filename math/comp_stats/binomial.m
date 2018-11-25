% simulate Bino(p) distr
clear all

n = input('num of trials = ');
p = input('prob of success = ');
N = input('num of simulations = ');

for i=1:N
    U = rand(n,1);
    X(i) = sum(U<p);
end

% compare to true Bino(p) graphically
UX = unique(X);
nX = hist(X, length(UX));
rel_freq = nX/N;

k = 0:n;
pk = binopdf(k,n,p);

clf
plot(k, pk, '*', UX, rel_freq, 'ro')
legend('Bino distr', 'Simulation')


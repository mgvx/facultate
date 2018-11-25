% simulate Geo(p) distr
clear all

p = input('prob of success = ');
N = input('num of simulations = ');

for i=1:N
    X(i) = 0;
    while rand >= p % count num failures
        X(i) = X(i)+1;
    end
end

% compare to true Geo(p) graphically
UX = unique(X);
nX = hist(X, length(UX));
rel_freq = nX/N;

k = 0:30;
pk = geopdf(k,p);

clf
plot(k, pk, '*', UX, rel_freq, 'ro')
legend('Geo distr', 'Simulation')


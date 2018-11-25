% simulate NegBino(p) distr
clear all

n = input('rank of the success = ');
p = input('prob of success = ');
N = input('num of simulations = ');

for i=1:N
    for j=1:n
        Y(j) = 0;
        while rand >= p % count num failures
            Y(j) = Y(j)+1;
        end
    end
    X(i) = sum(Y);
end

% compare to true NegBino(p) graphically
UX = unique(X);
nX = hist(X, length(UX));
rel_freq = nX/N;

k = 0:30;
pk = nbinpdf(k,n,p);

clf
plot(k, pk, '*', UX, rel_freq, 'ro')
legend('NegBino distr', 'Simulation')


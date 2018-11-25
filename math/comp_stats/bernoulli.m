% simulate Bern(p) distr
clear all

p = input('p (in(0,1) = ');
U = rand;
X = U<p;

N = input('num of simulations = '); % size of MC study
for i=1:N
    U = rand;
    X(i) = U<p;
end

% compare to true Bern(p)
UX = unique(X)
nX = hist(X, length(UX));
rel_freq = nX/N


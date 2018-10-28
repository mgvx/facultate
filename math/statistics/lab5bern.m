% simulation of bern(p) distr
p = input('prob of success = ');
U = rand;
X = (U<p); % x is 1 if success else x is 0 fail
clear X;

% generate a sample of N variables
N = input('nr of simulations = ');
for i=1:N
    U = rand;
    X(i) = U<p;
end
uX = unique(X)
freq = hist(X,length(uX));
relfreq = freq/N
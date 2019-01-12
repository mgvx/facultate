% simulation of bino(n,p) distr
% bino(1,p) = bern(p)
n = input('nr of trials = ');
p = input('prob of success = ');
U = rand(n,1);
X = sum(U<p); % nr successes
clear X;

% generate a sample of N variables
N = input('nr of simulations = ');
for i=1:N
    U = rand(n,1);
    X(i) = sum(U<p);
end
uX = unique(X);
freq = hist(X,length(uX));
relfreq = freq/N;

% compare graphically
clf
xpdf = 0:n;
ypdf = binopdf(xpdf,n,p);
plot(xpdf,ypdf,'*',uX,relfreq,'+');
legend('binopdf','simulation');
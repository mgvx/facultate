% simulation of geo(p) distr
% X nr of failures before first success
p = input('prob of success = ');
X = 0;
while(rand>=p)
    X = X+1;
end
clear X;

% generate a sample of N variables
N = input('nr of simulations = ');
for i=1:N
    X(i) = 0;
    while(rand>=p)
        X(i) = X(i)+1;
    end
end
uX = unique(X);
freq = hist(X,length(uX));
relfreq = freq/N;

% compare graphically
clf
xpdf = 0:20;
ypdf = geopdf(xpdf,p);
plot(xpdf,ypdf,'*',uX,relfreq,'+');
legend('geopdf','simulation');
% simulation of negbino(n,p) distr / pascal
% X nr of failures before first success
n = input('rank of success = ');
p = input('prob of success = ');
for j = 1:n
    Y(j) = 0;
    while(rand>=p)
        Y(j) = Y(j)+1;
    end
end
X = sum(U<p);
clear X;
clear Y;

% generate a sample of N variables
N = input('nr of simulations = ');
for i=1:N
    for j = 1:n
        Y(j) = 0;
        while(rand>=p)
            Y(j) = Y(j)+1;
        end
    end
    X(i) = sum(Y);
end
uX = unique(X);
freq = hist(X,length(uX));
relfreq = freq/N;

% compare graphically
clf
xpdf = 0:50;
ypdf = nbinpdf(xpdf,n,p);
plot(xpdf,ypdf,'*',uX,relfreq,'+');
legend('nbinpdf','simulation');
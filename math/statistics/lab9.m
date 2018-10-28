% CONFIDENCE INTERVALS

X = [ 7 7 4 5 9 9 ...
    4 12 8 1 8 7 ...
    3 13 2 1 17 7 ...
    12 5 6 2 1 13 ...
    14 10 2 4 9 11 ...
    3 5 12 6 10 7 ];

conflvl = input('confidence level = ');
alpha = 1 - conflvl;

n = length(X);
mX = mean(X);
sigma = 5;

z1 = norminv(1-alpha/2,0,1);
z2 = norminv(alpha/2,0,1); % z2=1-z1 simetry

ci1 = mX - sigma/sqrt(n)*z1;
ci2 = mX - sigma/sqrt(n)*z2;

fprintf('Confidence Interval for the mean (sigma known): (%3.4f, %3.4f)\n',ci1,ci2);


% CONFIDENCE INTERVALS

X = [ 1.48 1.26 1.52 1.56 1.48 1.46 ...
    1.30 1.28 1.43 1.43 1.55 1.57 ...
    1.51 1.53 1.68 1.37 1.47 1.61 ...
    1.49 1.43 1.64 1.51 1.60 1.65 ...
    1.60 1.64 1.51 1.51 1.53 1.74 ];

conflvl = input('confidence level = ');
alpha = 1 - conflvl;

n = length(X);
s = std(X);
mX = mean(X);

z1 = chi2inv(1-alpha/2,n-1);
z2 = chi2inv(alpha/2,n-1);

ci1 = (n-1)*s*s/z1;
ci2 = (n-1)*s*s/z2;

fprintf('Confidence Interval for the variance: (%3.4f, %3.4f)\n',ci1,ci2);

fprintf('Confidence Interval for the standard deviation: (%3.4f, %3.4f)\n',sqrt(ci1),sqrt(ci2));


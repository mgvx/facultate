% CONFIDENCE INTERVALS

X=[99.8*ones(1,2),99.9*ones(1,5),98.0*ones(1,3),100.1*ones(1,4),100.5*ones(1,2),100.0*ones(1,2),100.2*ones(1,2)];

conflvl = input('confidence level = ');
alpha = 1 - conflvl;

n = length(X);
mX = mean(X);
s = std(X);

t1 = tinv(1-alpha/2,n-1);
t2 = tinv(alpha/2,n-1); % t2=1-t1 simetry

ci1 = mX - s/sqrt(n)*t1;
ci2 = mX - s/sqrt(n)*t2;

fprintf('Confidence Interval for the mean: (%3.4f, %3.4f)\n',ci1,ci2);


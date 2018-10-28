% TESTS
X = [99.8*ones(1,2),99.9*ones(1,5),98.0*ones(1,3),100.1*ones(1,4),100.5*ones(1,2),100.0*ones(1,2),100.2*ones(1,2)];
n = length(X);

alpha = input('significance level = ');
% h0: u = 99.4 (<)
% h1: u > 9 (right test)
u0 = 99.4; % test value

% tail -1:'left' 0:'both' 1:'right'
[h,p,ci,stats] = ttest(X,u0,alpha,1); 
% [0/1 answer, Pvalue, conf int, [tstat, degree freedom, std dev]]

if h==0
    fprintf('do not reject h0\n');
    fprintf('buy energy bars\n');
else
    fprintf('reject h0\n');
    fprintf('do not buy energy bars\n');
end
fprintf('Observed Value TS: %3.4f\n',stats.tstat);
fprintf('P Value: %3.4f\n',p);

q = tinv(1-alpha,n-1); % quantille
fprintf('Rejection Region: (%3.4f,inf)\n',q);



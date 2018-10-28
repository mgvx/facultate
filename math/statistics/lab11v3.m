% TESTS
X = [ 7 7 4 5 9 9 ...
    4 12 8 1 8 7 ...
    3 13 2 1 17 7 ...
    12 5 6 2 1 13 ...
    14 10 2 4 9 11 ...
    3 5 12 6 10 7 ];

alpha = input('significance level = ');
% h0: u = 25
% h1: u != 25 
v0 = 25;

% tail -1:'left' 0:'both' 1:'right'
[h,p,ci,stats] = vartest(X,v0,alpha,0); 

if h==0
    fprintf('do not reject h0\n');
    fprintf('assumption correct\n');
else
    fprintf('reject h0\n');
    fprintf('assumption not correct\n');
end
fprintf('Observed Value TS: %3.4f\n',stats.chisqstat);
fprintf('P Value: %3.4f\n',p);

q1 = chi2inv(alpha/2,stats.df);
q2 = chi2inv(1-alpha/2,stats.df);
fprintf('Rejection Region: (-inf,%3.4f)U(%3.4f,inf)\n',q1,q2);



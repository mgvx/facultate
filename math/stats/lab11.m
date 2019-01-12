% TESTS
X = [ 7 7 4 5 9 9 ...
    4 12 8 1 8 7 ...
    3 13 2 1 17 7 ...
    12 5 6 2 1 13 ...
    14 10 2 4 9 11 ...
    3 5 12 6 10 7 ];

alpha = input('significance level = ');
% h0: u = 9 (>)
% h1: u < 9 (left test)
u0 = 9;
sigma = 5;

% tail -1:'left' 0:'both' 1:'right'
[h,p,ci,zval] = ztest(X,u0,sigma,alpha,-1); 
% [0/1 answer, Pvalue, conf int, observed val TS]

if h==0
    fprintf('do not reject h0\n');
    fprintf('computers meet the efficiency standard\n');
else
    fprintf('reject h0\n');
    fprintf('computers do not meet the efficiency standard\n');
end
fprintf('Observed Value TS: %3.4f\n',zval);
fprintf('P Value: %3.4f\n',p);

qalpha = norminv(alpha,0,1);
fprintf('Rejection Region: (-inf,%3.4f)\n',qalpha);



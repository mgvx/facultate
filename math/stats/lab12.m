% CONFIDENCE INTERVALS
% 2 populations

X1 = [ 22.4 21.7 ...
    24.5 23.4 ...
    21.6 23.3 ...
    22.4 21.6 ...
    24.8 20.0 ];

X2 = [ 17.7 14.8 ...
    19.6 19.6 ...
    12.1 14.8 ...
    15.4 12.6 ...
    14.0 12.2 ];

alpha = input('significance level = ');

% PUNCTU A 
% h0: sigm1^2/sigm2^2 = 1 
% h1: sigm1^2/sigm2^2 =/= 1 (two tailed test)

[h,p,ci,stats] = vartest2(X1,X2,alpha,0); % Fisher
% stats: fstats (obs val of TS) df1/df2 (par of F dist)
if h==0
    fprintf('do not reject h0\n');
    fprintf('population variance are equal\n');
else
    fprintf('reject h0\n');
    fprintf('population variance are different\n');
end

fprintf('observed value of TS: %3.4f\n',stats.fstat);
fprintf('P value: %3.4f\n',p);
q1 = finv(alpha/2,stats.df1,stats.df2);
q2 = finv(1-alpha/2,stats.df1,stats.df2);
fprintf('Reject Region: (-inf,%3.4f)U(%3.4f,+inf)\n',q1,q2);

fprintf('\n');

% PUNCTU B 
% h0: u1 = u2 (MIU MEDIA)
% h1: u1 > u2 (right tailed test)
 
vartype = 'equal'; % 'unequal'
[h,p,ci,stats] = ttest2(X1,X2,alpha,1,vartype);
% stats: tstats (obs val of TS) df (par of T dist) sd (est of std dev)

if h==0
    fprintf('do not reject h0\n');
    fprintf('no\n');
else
    fprintf('reject h0\n');
    fprintf('yes\n');
end


fprintf('observed value of TS: %3.4f\n',stats.tstat);
fprintf('P value: %e\n',p);
q = tinv(1-alpha,stats.df);
fprintf('Reject Region: (%3.4f,+inf)\n',q);







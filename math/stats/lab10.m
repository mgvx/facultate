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

conflvl = input('confidence level = ');
alpha = 1 - conflvl;

n1 = length(X1);
n2 = length(X2);
mX1 = mean(X1);
mX2 = mean(X2);
s1 = std(X1);
s2 = std(X2);
v1 = var(X1);
v2 = var(X2);

sp = sqrt(((n1-1)*v1+(n2-1)*v2)/(n1+n2-2));

t1 = tinv(1-alpha/2,n1+n2-2);
t2 = tinv(alpha/2,n1+n2-2);

ci1 = mX1-mX2 - t1*sp*sqrt(1/n1+1/n2);
ci2 = mX1-mX2 - t2*sp*sqrt(1/n1+1/n2);

fprintf('CI for difference of means (sgm1=sgm2): (%3.4f, %3.4f)\n',ci1,ci2);

c = (s1*s1/n1)/(s1*s1/n1+s2*s2/n2);
n = c*c/(n1-1)+(1-c)*(1-c)/(n2-1);

t3 = tinv(1-alpha/2,1/n);
t4 = tinv(alpha/2,1/n);

ci3 = mX1-mX2 - t3*sqrt(s1*s1/n1+s2*s2/n2);
ci4 = mX1-mX2 - t4*sqrt(s1*s1/n1+s2*s2/n2);

fprintf('CI for difference of means (sgm1!=sgm2): (%3.4f, %3.4f)\n',ci3,ci4);

t5 = finv(1-alpha/2,n1-1,n2-1);
t6 = finv(alpha/2,n1-1,n2-1);

ci5 = 1/t5*s1*s1/s2/s2;
ci6 = 1/t6*s1*s1/s2/s2;

fprintf('CI for ratio of the variances: (%3.4f, %3.4f)\n',ci5,ci6);
fprintf('CI for ratio of the standard variances: (%3.4f, %3.4f)\n',sqrt(ci5),sqrt(ci6));



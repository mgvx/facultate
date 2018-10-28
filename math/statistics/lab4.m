x0 = input('x0 = ');
x1 = input('x1 = ');
x2 = input('x2 = ');
alpha = input('alpha(0,1) = ');
beta = input('beta(0,1) = ');

% a) prob x < x0 = F(x0)
% b) prob x > x0 = 1 - F(x0)
% c) prob x1 < x < x2
% d) prob x > x1 || x > x2
% e) x for prob alpha
% f) x for prob > beta

option = input('1 for Normal\n2 for Student\n3 for Fisher\n');
switch option
    case 1
        %Normal Dist
        miu = input('miu = ');
        sigma = input('sigma(>0) = ');  
        pa = normcdf(x0,miu,sigma);
        pb = 1-pa;
        pc = normcdf(x2,miu,sigma) - normcdf(x1,miu,sigma);
        pd = 1-pc;
        qalpha = norminv(alpha,miu,sigma); % quantile
        qbeta = norminv(1-beta,miu,sigma);
    case 2
        %Student Dist
        nu = input('nu = ');
        pa = tcdf(x0,nu);
        pb = 1-pa;
        pc = tcdf(x2,nu) - tcdf(x1,nu);
        pd = 1-pc;
        qalpha = tinv(alpha,nu);
        qbeta = tinv(1-beta,nu);
    case 3
        %Fisher Dist
        df1 = input('df1 = ');
        df2 = input('df2 = ');
        pa = fcdf(x0,df1,df2);
        pb = 1-pa;
        pc = fcdf(x2,df1,df2) - fcdf(x1,df1,df2);
        pd = 1-pc;
        qalpha = finv(alpha,df1,df2);
        qbeta = finv(1-beta,df1,df2);
    otherwise
        error('Wrong Option');
end

fprintf('Answer f: %f\n',qbeta);
fprintf('Answer a: %f\n',pa);
fprintf('Answer b: %f\n',pb);
fprintf('Answer c: %f\n',pc);
fprintf('Answer d: %f\n',pd);
fprintf('Answer e: %f\n',qalpha);





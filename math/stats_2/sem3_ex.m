clear all

%err = input('er = '); % 1e-2, 1e-3
%alpha = input('alpha (0,1) = '); % level of significance
%N = ceil(0.25*(norminv(alpha/2, 0, 1)/err)^2); % number of simulations

%kdays = input('nr prev days considered = ');
%inlast = input('nr of errors in the last k days (vector) = ');
%tmax = input('max time after which software deleted (days) = ');

% Ttotal : time takes to find all errors
% Ntotalerr : total number of errors

err = 0.01;
alpha = 0.05;
N = ceil(0.25*(norminv(alpha/2, 0, 1)/err)^2); % number of simulations

k = 4;
inlast = [10,5,7,6];
tmax = 10;

for j=1:N
    T = 0; % time from now on
    X = inlast(k); % nr of errors on day T
    nrerr = sum(inlast); % nr errors detected so far
    last = inlast;
    while X>0
        lambda = min(last);
        U = rand;
        X = 0;
        while U>=exp(-lambda)
            U=U*rand;
            X=X+1;
        end
        % update
        T=T+1;
        nrerr = nrerr+X;
        last=[last(2:k),X];
    end
    Ttotal(j) = T-1;
    Ntotalerr = nrerr;
end
fprintf('a - %f\n', mean(Ttotal));
fprintf('b - %f\n', mean(Ntotalerr));
fprintf('c - %f\n', mean(Ttotal>tmax));

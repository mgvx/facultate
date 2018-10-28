X=[20*ones(1,2),21,22*ones(1,3),23*ones(1,6),24*ones(1,5),25*ones(1,9),26*ones(1,2),27*ones(1,2)];
Y=[75*ones(1,3),76*ones(1,2),77*ones(1,2),78*ones(1,5),79*ones(1,8),80*ones(1,8),81,82];

mX = mean(X);
mY = mean(Y);
fprintf('mean X: %3.4f\n',mX)
fprintf('mean Y: %3.4f\n',mY)

vX = var(X,1);
vY = var(Y,1);
fprintf('var X: %3.4f\n',vX)
fprintf('var Y: %3.4f\n',vY)

covar = cov(X,Y,1);
fprintf('covariance: %3.4f\n',covar(1,2))
corr = corrcoef(X,Y);
fprintf('corellation coef: %3.4f\n',corr(1,2))

regX = 20:27;
regY = mY+corr(1,2)*sqrt(vY)/sqrt(vX)*(regX-mX);
scatter(X,Y)
hold on
plot(regX,regY,'')


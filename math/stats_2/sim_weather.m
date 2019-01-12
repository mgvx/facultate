% simulation prob sem4 p5

Nm = input('length of sample path: ');
N = input('num of simulations: ');

for j = 1:N
    P0 = [0.2 0.8];         % initial distr of sunny/rainy days
    P = [0.7 0.3; 0.4 0.6]; % transition prob matrix
    P1(1,:) = P0;           % the forecast for day t=1

    for t = 1:Nm
        U = rand;
        X(t) = 1*(U<P0(1)) + 2*(U>=P0(1));  % generate X(t) as Bern(P0(1))
        P1(t+1,:) = P1(t,:) * P;    % the forecast for next day Pt+1=Pt*P
        P0 = P(X(t),:);
    end
    % X
    % find long streaks fo sunny/rainy days
    ichange = [find(X(1:end-1)~= X(2:end)),Nm];    % indices where states change
    % longstreaks of sunny/rainy
    longstr(1) = ichange(1);
    for i = 2:length(ichange)
        longstr(i) = ichange(i) - ichange(i-1);
    end
    % streaks of sunny/rainy longstr
    if X(1)==1
        sunny = longstr(1:2:end);
        rainy = longstr(2:2:end);
    else
        sunny = longstr(2:2:end);
        rainy = longstr(1:2:end);
    end
    maxs(j) = max(sunny);
    maxr(j) = max(rainy);
end
fprintf('\nprob of water shortage: %1.4f\n', mean(maxs>=7))
fprintf('\nprob of flooding: %1.4f\n', mean(maxr>=7))



% simulate a Bino counting process
Nb = input('size of sample path = ');
p = input('probability of success = ');

X = zeros(1,Nb);
X(1) = (rand<p);

for t=2:Nb
    X(t) = X(t-1) + (rand<p); % count nr of successes
end

% illustration
del = input('frame size = ');
axis([0 Nb 0 max(X)]); % allocate the box for the graph

hold on
title('Binomial Counting Process');
xlabel('time');
ylabel('num arrivals');

for t=1:Nb
    plot(t,X(t),'o', 'MarkerSize', 10)
    pause(del)
end
hold off



% simulate a Poisson counting process
lambda = input('arrival rate = ');
Tmax = input('max time = ');

arr_times = (-1/lambda)*log(rand); % array of arrival times Exp(lambda) distributed
last_arr = arr_times

while last_arr <= Tmax
    last_arr = last_arr + (-1/lambda)*log(rand);
    arr_times = [arr_times, last_arr];
end
arr_times = arr_times(1:end-1);

t=0:0.01:Tmax;
n = length(t);
X = zeros(1,n);

for s=1:n
    X(s) = sum(arr_times<=t(s)); % num arrivals by time t(s)
end

% illustration
axis([0 Tmax 0 max(X)]); % allocate the box for the graph

hold on
title('Poisson Counting Process');
xlabel('time');
ylabel('num arrivals');
comet(t,X)
hold off



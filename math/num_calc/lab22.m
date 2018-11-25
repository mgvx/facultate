
T = @(n,x) cos(n.*acos(x))
x = [-1:0.01:1];
hold on

%plot(x,T(1,x),x,T(2,x),x,T(3,x))
plot(x,lab2f(x,1),x,lab2f(x,2),x,lab2f(x,3))
legend("1","2","3")
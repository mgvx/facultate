a = [1,2,3];
b = [4;5;6];
c = b*a;
c^2;
[m,k] = max(b);
d = [b b];

a = [1,2,13;4,5,6;7,8,9];
b = [4,8,5;-1,0,5;2,3,8];
[m,n] = size(a);
t = a';
mean(a);
diag(a);
t = zeros(3);
t = eye(6);

x = a\b;
A = magic(10);
B = A(2:9,3:10);

P = [1,0,0,1];
polyval(P,3);
roots(P);

f = @(x) x.^3+1;
f(5);
f(1:3);

P1 = [-2,8,10]
P2 = [5,-1,5]
plot (P1,P2);

x = 0:0.01:1;
F = @(x) exp(10*x.*(x-1)).*sin(12*pi*x);
plot(x,F(x),'-*r');

t = 0:0.01:10*pi;
x = @(t,a,b) (a+b).*cos(t)-b.*cos((a/b+1)*t);
y = @(t,a,b) (a+b).*sin(t)-b.*sin((a/b+1)*t);
plot(x(t,1,2),y(t,1,2));
hold on
plot(x(t,3,2),y(t,3,2),'r');
% fplot(f,[0,1]);

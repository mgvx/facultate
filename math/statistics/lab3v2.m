% sim moneda
n = input('nr sim: ');
u = rand(3,n);
y = u<0.5;
x = sum(y);
hist(x)

x = 0:50;
y = [];
for i = 1:51
  if mod(x(i),2) == 0
    y = [y, x(i)/2];
  else
    y = [y, 3*x(i)+1];
  end
 end
% plot(x,y,'o');

x=0:50;
y=x/2;
y(2:2:end) = 3*x(2:2:end)+1;
 plot(x,y,'o')

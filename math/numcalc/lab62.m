x = [0 10 20 30 40 60 80 100]
y = [0.0061 0.0123 0.0234 0.0424 0.0738 0.1992 0.4736 1.0133]


X = linspace(0,10,100)

for i=1:5
  p = polyfit(x,y,i);
  polyval(p,45);
end



hold on
plot(x,y,"*")
for i=1:5
  plot(X,polyval(polyfit(x,y,i),X))
end

clf
hold on
axis([0,3,0,5])
[x,y] = ginput(10)
plot(x,y,"*")
for i=1:5
  plot(X,polyval(polyfit(x,y,i),X),"--r")
end
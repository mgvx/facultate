x=0:0.05:3;
% y=2*x+1;
y1=(x.^2)/10;
y2=x.*sin(x);
y3=cos(x);

% plot(x,y1,'p');
% hold on
% plot(x,y2,'>');
% hold on
% plot(x,y3,'h');
% 
% title('This is graph');
% legend('first','ya','thrd');

subplot(3,1,1);
plot(x,y1,'p');
subplot(3,1,2);
plot(x,y2,'>');
subplot(3,1,3);
plot(x,y3,'o');
    
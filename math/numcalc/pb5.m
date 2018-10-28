function y = pb5(x,n)
% y=x;
% for  i=1:n
%   y=1+1/(1+y);
% end

if(n>0)
  y=1+1/(1+pb5(x,n-1));
else
  y=x;
end

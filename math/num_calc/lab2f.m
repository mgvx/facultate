function y = lab2f(x,n)

if(n==0)
  y=1;
else
  if(n==1)
    y=x;
  else
    y=2.*x.*lab2f(x,n-1)-lab2f(x,n-2);
  end
end
end
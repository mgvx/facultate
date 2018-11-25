function y = lab2f3(x,n)

if(n==0)
  y=1;
else
  y= lab2f3(x,n-1)+x.^n/factorial(n);
end
end

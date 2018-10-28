f = @(x) 2./(1+x^2);
a=0;
b=1;

%hold on
%plot([a,b],[f(a),f(b)],'r')
%axis([0,1,0,2])
%clf

a=0;
b=2*pi;

r=110;
p=75;

u =  ((60*r)/(r.^2-p.^2));
f = @(x) (1-((p/r).^2)*sin(x)).^(1/2);

R = u * quad(a,b,2,f);
R = u * quad(a,b,4,f);
R = u * quad(a,b,10,f);


a=1;
b=2;
f = @(x) x.*log(x);

%quad(a,b,5,f)
%quad(a,b,10,f)
%quad(a,b,15,f)

%simson(a,b,2,f)
%simson(a,b,3,f)
%simson(a,b,10,f)

f = @(t) e.^(-t.^2);
a = 0;
b = 0.5;

u = 2/(pi^(1/2));
R = u * simson(a,b,4,f)
R = u * simson(a,b,10,f)

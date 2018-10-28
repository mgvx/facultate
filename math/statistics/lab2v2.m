a=input('a=');
b=input('b=');
n=input('n=');

ind=1:n; %length n
lim=a:((b-a)/n):b;
left_lim=lim(ind);
right_lim=lim(ind+1);
mid=(left_lim+right_lim)/2;

res=[ind;left_lim;right_lim;mid]

fprintf('Nr |     Subint    | Mid\n',res)
fprintf('-------------------------\n')
fprintf(' %d | [%3.3f,%3.3f] | %3.3f\n',res)



% simulation of bern(p) distr
alpha = input('alpha = ');
N = input('sample size = ');
x = exprnd(alpha,1,N);

% number classes
n = 1+(10/3)*log10(N);

id = 1:n;
limits = min(x):((max(x)-min(x))/n):max(x);
left_lim = limits(id);
right_lim = limits(id+1);
[freq, mark] = hist(x,n);
rel_freq = freq / N;

res = [id; left_lim; right_lim; mark; freq; rel_freq];

fprintf('Nr\t|\tClass\t\t\t|\tMark\t|\tFreq\t|\tRel Freq\n')
fprintf('-------------------------------------------------------------\n')
fprintf('%d\t|\t[%3.3f,%3.3f]\t|\t%3.3f\t|\t%d\t|\t%3.3f\n', res);

hist(x,n);
hold on
plot(mark,freq,'r','lineWidth',2);

fprintf('Mode:\n');
id_mode = find(freq==max(freq));
res_mode = [id_mode; left_lim(id_mode); right_lim(id_mode); mark(id_mode); freq(id_mode); rel_freq(id_mode)];
fprintf('%d\t|\t[%3.3f,%3.3f]\t|\t%3.3f\t|\t%d\t|\t%3.3f\n', res_mode);

fprintf('Mean: %3.3f\n',mean(x));

qua = [25,50,75];
Q = prctile(x, qua);
fprintf('Quartiles:\nQ1 = %3.3f\nQ2 = %3.3f\nQ3 = %3.3f\n',Q);

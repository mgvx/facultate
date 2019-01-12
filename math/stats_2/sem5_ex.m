
1)  lambda = 2/min
    p <= 0.1

 a) delta = p/lambda = 0.05 mins

 b) delta = 3 sec
    t = 3 mins
    n = t/delta = 60 frames
    X(t) in Bino(60,0.1)
    P(X(60)=0) = binopdf(0,60,0.1)

 c) t = 1h = 360 sec
    n = 3600/3 = 1200 frames
    X(t) in Bino(1200,0.1)
    P(X(1200)>100) = 1-P(X(1200)<=100) = 1-binocdf(0,1200,0.1)


2)  lambda = 2/3 /min
    delta = 1/30 /min
    p = .. = 1/45
    t = 30 mins
    in 30 mins .. n = 30/delta = 900 frames
    distrib: X in Bino(900,1/45) ..
    E(X) = np = 900*1/45 = 20 messages
    stdev = sqrt(var(X)) = sqrt(n*p*q) = .. = 4.42


3)  lambda = 5 /min
    X(t) in Poisson(lambda*t)

 a) t = 2 mins
    P(no offer) = P(X<3) = P(X<=2) = 1 - poiscdf(2, 2*10) = 0.002

 b) t = 1/3 mins
    interarrival time = T in Exp(lambda)
    P(T>1/3) = 1 - expcdf(1/3, 1/lambda)

 c) time of the first offer = time of the 3rd connection
    time of the kth arrival
    T3 = sum of 3 indep. Exp(5) -> Gamma(3, 1/lambda)
    E(T3) = alpha*lambda = 35 sec
    stdev = sqrt(alpha*lambda^2) = 0.34


4)  lambda = 1/4 year
    X = drink & drive
    X in Poisson(lambda)
    P(keeps license) = P(X<3) = P(X<=2) = poisscdf(2,2.5)


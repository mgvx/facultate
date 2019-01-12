1.
    2 states
    p = [0.4 0.6]
        [0.6 0.4]

a)  initial time t=0
    X0 P0=[1 0]
    3 times lates
    P(3)11, p(3)12 = ?


    P = [0.4, 0.6, 0.6, 0.4]
    p^3

b)  steady state distr
    pi P = pi
    sum pi_k = 1

    pi = [pi1 pi2]
    0.4 pi1 + 0.6 pi2 = pi1
    0.6 pi1 _ 0.4 pi2 = pi2
    pi1 + pi2 = 1
    pi = [0.5 0.5]


2.
    2 states black/brown
    p = [0.4 0.6]
        [0.6 0.4]
    homo MC
    P0 = [0 1]

    p(2)21 = ?
    P = P0*P(2) = P0*p^2


3.
    2 states green/red
    p = [0.6 0.4]
        [0.3 0.7]
    p0 = [1 0]

    P2=P0*P(2)


4.
    Xt : the nr of concurent users at time t

a)  P = [A0] = [p00 p01 p02]
        [A1] = [p10 p11 p12]
        [A2] = [p20 p21 p22]

    A0 : Bino(2, 0.2)
    A0 = binopdf(0:2, 2, 0.2) = [..]

    A1 : we have 1 connected user
    p10 = P(the connected disconnects) and P(the disconnected does not connect) = 0.2 * 0.8
    p12 = P(the connected does not disconnect) and P(the disconnected connects) = 0.5 * 0.2
    p11 = 1 - p10 - p12 = 0.5
    A1 = [..]

    A2 : there are 2 connected users ~ nr of disconnects
    A2 : Bino(2, 0.5)
    A2 = binopdf(2:-1, 2, 0.5) = [..]

    P = [A0, A1, A2]

b)  t = 0, P0 = [0 0 1]
    t = 2, P2 = P0 * P^2 = [..]
    P(2)21 = ..

c)  noon t = 120
    find steady state distrib
    exists because all entries are nonzero

    pi P = pi
    [pi1 pi2 pi3] * [p00 p01 p02] = [pi1 pi2 pi3]
                    [p10 p11 p12]
                    [p20 p21 p22]

    AX=b transpose: A=[P'-I3, [1 1 1]]
                    (this is a 4 by 3 matrix)

    .. X=A\b
    E(X120) ~ E(pi) = .. = 0.574


5.
    P = [0.7 0.3]
        [0.4 0.6]

a)  steady state = [4/7 3/7]

b)  P0 = [0.2 0.8]
    see problem ..



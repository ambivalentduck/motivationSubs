clc
clear all

syms w11 w12 w21 w22 tc2 t real
syms ts1 ts2 positive

tc1=0;

ta1=(t-tc1)/ts1+.5;
K1=(30*ta1^2-60*ta1^3+30*ta1^4)/ts1*(heaviside(t-(tc1-ts1/2))*heaviside(t-(tc1+ts1/2)));

ta2=(t-tc2)/ts2+.5;
K2=(30*ta2^2-60*ta2^3+30*ta2^4)/ts2*(heaviside(t-(tc2-ts2/2))*heaviside(t-(tc2+ts2/2)));

th=atan((w22*K2+w12*K1)/(w21*K2+w11*K1))

dth=diff(th,t)
simplify(dth)


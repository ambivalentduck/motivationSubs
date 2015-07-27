clc
clear all

t=0:.001:1;

[K,A]=computeKern(t,.5,1);
P=K.*A;
mP=max(P);

figure(3)
clf
hold on
plot(t,P/mP,'b',t,sin(t*(2*pi)),'r')
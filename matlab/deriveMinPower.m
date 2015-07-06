clc
clear all

N=5;
syms p1 p2 p3 p4 p5 p6 p7 p8 t real

xmj=10*t^3-15*t^4+6*t^5;
vmj=diff(xmj,t)
amj=diff(vmj,t)
wmj=double(int((amj*vmj)^2,t,0,1))

P=[p1 p2 p3];
x=dot(P,t.^(3:5))
v=diff(x,t)
a=diff(v,t)

w=v*a;
w2i=int(w^2,t,0,1);
w2i=simplify(w2i);

C=zeros(N-3)
C1=sum(P(1:(N-2)))-1; %x=1 at t=1
C2=dot(3:N,P(1:(N-2))); %v=0 at t=1
[sp2, sp3]=solve(C1,C2,p2,p3)

w2i=subs(w2i,p2,sp2);
w2i=subs(w2i,p3,sp3);
w2i=simplify(w2i)

w2p=inline(vectorize(w2i))
figure(1)
clf
hold on
ps=0:.1:10;
plot(ps,w2p(ps))
plot([0 10],wmj*[1 1],'r')

mp1=double(solve(diff(w2i)));
mp1=mp1(1)
mp2=subs(sp2,p1,mp1)
mp3=subs(sp3,p1,mp1)

dt=0:.01:1;

ix=inline(vectorize(x))
iv=inline(vectorize(v))
ia=inline(vectorize(a))
sx=ix(mp1,mp2,mp3,dt);
sv=iv(mp1,mp2,mp3,dt);
sa=ia(mp1,mp2,mp3,dt);

figure(N)
clf
subplot(3,1,1)
hold on
plot(dt,10*dt.^3-15*dt.^4+6*dt.^5,'r')
plot(dt,sx)
ylabel('X, m')
subplot(3,1,2)
hold on
cvmj=30*dt.^2-60*dt.^3+30*dt.^4;
plot(dt,30*dt.^2-60*dt.^3+30*dt.^4,'r')
plot(dt,sv)
ylabel('V, m/s')
subplot(3,1,3)
hold on
avmj=60*dt-180*dt.^2+120*dt.^3;
plot(dt,cvmj.*avmj,'r')
plot(dt,sv.*sa)
ylabel('Power, watts')
xlabel('t, normalized')
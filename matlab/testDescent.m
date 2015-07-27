clc
clear all

global xdot tfit

N=3;
[vel,kerns,pos,w,tc,ts,t]=buildwalk(N,.005);

figure(1)
clf
hold on
for k=1:N
    plot(t,kerns(:,k),'g')
end
plot(t,vecmag(vel))

tfit=t;
xdot=vel';

P0=zeros(4,N);
Ptrue=zeros(4,N);
for k=1:N
    P0(:,k)=[.05*(rand(2,1)-.5)+w(k,:)';tc(k);ts(k)];
    Ptrue(:,k)=[w(k,:)';tc(k);ts(k)];
end
P0=P0(:);
PtrueFlat=Ptrue(:);

P=fminunc(@supMJ5Pgrad,PtrueFlat+.03*(rand(12,1)-.5),optimset('GradObj','on'))
r=reshape(P,4,3);

wfit=r(1:2,:)';
tcfit=r(3,:);
tsfit=abs(r(4,:));

[yfit,kernsfit]=supMJ5P(wfit,tcfit,tsfit,tfit);
plot(t,vecmag(yfit),'r.')
for k=1:N
    inds=(t>=(tcfit(k)-tsfit(k)/2))&(t<=(tcfit(k)+tsfit(k)/2));
    plot(t(inds),kernsfit(inds,k),'m.')
end
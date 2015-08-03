clc
clear all

tdes=100;
t1=16.3/100;
N=floor(tdes/t1);

dT=0.005;

%Two interwoven "strands" of submovements
maxspacing=0;
tsmean=.3;
tsdiff=.05;

w=zeros(N,2);
tc=zeros(N,1);
ts=zeros(N,1);
w(1,:)=[.4 0];
tc(1)=.125;
ts(1)=.25;
for k=2:ceil(N/2)
    ts(k)=(rand-.5)*tsdiff+tsmean;
    tc(k)=tc(k-1)+ts(k-1)/2+ts(k)/2+rand*maxspacing;
    w(k,:)=rand(1,2)-.5;
    %w(k,:)=pol2cart(pi*rand,.1);
end
w(k+1,:)=rand*.2+.2;
tc(k+1)=.2;
ts(k+1)=.3;
for k=k+2:N
    ts(k)=(rand-.5)*tsdiff+tsmean;
    tc(k)=tc(k-1)+ts(k-1)/2+ts(k)/2+rand*maxspacing;
    w(k,:)=rand(1,2)-.5;
    %w(k,:)=pol2cart(pi*rand,.1);
end

tup=max(tc+ts/2);
t=0:dT:tup;

coverage=zeros(size(t));
for k=1:N
    inds=(t>(tc(k)-ts(k)/2))&(t<(tc(k)+ts(k)/2));
    coverage(inds)=coverage(inds)+1;
end

v=supMJ5P(w,tc,ts,t);
a=[gradient(v(:,1)),gradient(v(:,2))]/dT;

P=dot(a',v');
figure(1)
clf
subplot(2,2,1)
hist(abs(P),50)
title('Power histogram')
xlabel('Power, Watts')

E=dot(v',v');
subplot(2,2,2)
hist(E,100)
title('Energy histogram')
xlabel('Energy, Joules')

subplot(2,2,3)
plot(t,P)
title('raw')
ylabel('Power, watts')
xlabel('Time, seconds')

subplot(2,2,4)
hist(coverage)
title('coverage histogram')
xlabel('Simultaneous Submovements')

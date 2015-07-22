clc
clear all

tdes=100;
t1=16.3/100;
N=floor(tdes/t1);

dT=0.005;

%Two interwoven "strands" of submovements
maxspacing=0;
tsmean=.2;
tsdiff=0;

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
hist(abs(P),50)

E=dot(v',v');
figure(2)
hist(E,100)

figure(3)
plot(t,P)

figure(4)
hist(coverage)

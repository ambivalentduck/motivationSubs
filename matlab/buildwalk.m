function [vel,kerns,pos,w,tc,ts,t]=buildwalk(N,dT)

w=zeros(N,2);
tc=zeros(N,1);
ts=zeros(N,1);
w(1,:)=[.4 0];
tc(1)=.125;
ts(1)=.25;
for k=2:ceil(N/2)
    ts(k)=rand*.2+.2;
    tc(k)=tc(k-1)+ts(k-1)/2+ts(k)/2+rand*.05;
    w(k,:)=rand(1,2)-.5;
end
w(k+1,:)=rand*.2+.2;
tc(k+1)=.2;
ts(k+1)=.3;
for k=k+2:N
    ts(k)=rand*.2+.2;
    tc(k)=tc(k-1)+ts(k-1)/2+ts(k)/2+rand*.05;
    w(k,:)=rand(1,2)-.5;
end

tup=max(tc+ts/2);
t=0:dT:tup;

[vel,kerns,pos]=supMJ5P(w,tc,ts,t);
clc
clear all

dT=0.005;

%Two interwoven "strands" of submovements
N=7;
w=zeros(N,2);
tc=zeros(N,1);
ts=zeros(N,1);
w(1,:)=[.4 0];
tc(1)=.125;
ts(1)=.25;
for k=2:4
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

[th,rh]=cart2pol(vel(:,1),vel(:,2));
gth=gradient(th);
oops=abs(gth)>2.9;
gth(oops)=(abs(gth(oops))-pi).*sign(gth(oops));
thd=gth/dT;
direcChange=.1*abs(thd).*rh;
testme=gradient(direcChange)/dT;

thresh=.5;
[posp,starts]=findpeaks(testme);
starts=starts(posp>thresh);
[negp,ends]=findpeaks(-testme);
ends=ends(negp>thresh);

figure(1)
clf
subplot(1,2,1)
hold on
plot(pos(:,1),pos(:,2))
for k=1:length(starts)
    plot(pos(starts(k),1),pos(starts(k),2),'mx')
end
for k=1:length(ends)
        plot(pos(ends(k),1),pos(ends(k),2),'mo')
end
for k=1:N
    [v,f]=min(abs(t-tc(k)));
    text(pos(f,1),pos(f,2),num2str(k))
    [v,f]=min(abs(t-tc(k)+ts(k)/2));
    plot(pos(f,1),pos(f,2),'kx')
    [v,f]=min(abs(t-tc(k)-ts(k)/2));
    plot(pos(f,1),pos(f,2),'ko')
end
subplot(1,2,2)
hold on
plot(t,vecmag(vel))

for k=1:size(kerns,2)
    plot(t,kerns(:,k),'g')
end
plot(t,.1*testme,'r')

for k=1:length(starts)
    plot(t(starts),0,'mx')
end

for k=1:length(ends)
    plot(t(ends),0,'mo')
end

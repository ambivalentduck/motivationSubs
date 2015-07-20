clc
clear all

dT=0.005;
N=10;

%Two interwoven "strands" of submovements

[vel,kerns,pos,w,tc,ts,t]=buildwalk(N,dT);
[ath,dth,th,sp]=vel2dir(vel,1);
dth=5*dth/max(dth);
ath=50*gradient(ath);

thresh=0;
[posp,starts]=findpeaks(ath);
starts=starts(posp>thresh);
[negp,ends]=findpeaks(-ath);
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
    [blah,f]=min(abs(t-tc(k)));
    text(pos(f,1),pos(f,2),num2str(k))
    [blah,f]=min(abs(t-tc(k)+ts(k)/2));
    plot(pos(f,1),pos(f,2),'kx')
    [blah,f]=min(abs(t-tc(k)-ts(k)/2));
    plot(pos(f,1),pos(f,2),'ko')
end
subplot(1,2,2)
hold on
plot(t,sp)
plot(t,th,'k')

for k=1:N
    plot(t,kerns(:,k),'g')
    [blah,f]=min(abs(t-tc(k)));
    text(t(f),sp(f),num2str(k))
end
plot(t,dth,'c')
plot(t,ath,'r')

for k=1:length(starts)
    plot(t(starts),0,'mx')
end

for k=1:length(ends)
    plot(t(ends),0,'mo')
end
ylim([-10 10])

subplot(1,2,1)
axis equal
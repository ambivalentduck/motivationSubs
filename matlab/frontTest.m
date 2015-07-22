clc
clear all

S=5;
fname=[datadir,'strokeFE',num2str(S),'.mat'];
load(fname)
Tmax=3;
vel=v(t<Tmax,:);
pos=x(t<Tmax,:);
t=t(t<Tmax);

[ath,dth,th,sp]=vel2dir(vel,1); %Was 1

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

subplot(1,2,2)
hold on
plot(t,sp)
plot(t,th,'k')


plot(t,dth,'c')
plot(t,ath,'r')

for k=1:length(starts)
    plot(t(starts),0,'mx')
end

for k=1:length(ends)
    plot(t(ends),0,'mo')
end
ylim(8*[-1 1])

subplot(1,2,1)
axis equal
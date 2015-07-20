clc
clear all

dT=0.005;
N=20;

%Two interwoven "strands" of submovements

[vel,kerns,pos,w,tc,ts,t]=buildwalk(N,dT);
[ath,dth,th,sp]=vel2dir(vel);
dth=5*dth/max(dth);
ath=5*ath/max(ath);
acc=gradient(sp)/dT;
jerk=gradient(ath);

thresh=0;
[posp,starts]=findpeaks(ath);
starts=starts(posp>thresh);
[negp,ends]=findpeaks(-ath);
ends=ends(negp>thresh);

figure(2)
clf
subplot(2,1,1)
hold on
plot(t(starts),jerk(starts),'mx')
subplot(2,1,2)
hold on
plot(t(ends),jerk(ends),'mo')

figure(1)
clf
subplot(1,2,1)
hold on
plot(pos(:,1),pos(:,2))
plot(pos(starts,1),pos(starts,2),'mx')
plot(pos(ends,1),pos(ends,2),'mo')

for k=1:N
    [blah,f]=min(abs(t-tc(k)));
    [blah,fs]=min(abs(t-tc(k)+ts(k)/2));
    [blah,fe]=min(abs(t-tc(k)-ts(k)/2));
    figure(1)
    text(pos(f,1),pos(f,2),num2str(k))
    plot(pos(fs,1),pos(fs,2),'kx')
    plot(pos(fe,1),pos(fe,2),'ko')
    figure(2)
    subplot(2,1,1)
    plot(t(fs),jerk(fs),'kx')
    subplot(2,1,2)
    plot(t(fe),jerk(fe),'ko')
end
figure(1)
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
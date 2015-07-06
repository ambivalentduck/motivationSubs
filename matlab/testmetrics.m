clc
clear all

dT=0.005;
t=0:dT:1;
[vel,kerns,pos]=supMJ5P([.3 0;0 1;-.25 0;-.25 -.25],[.15 .3 .45 .57],[.3 .45 .25 .25],t);

figure(1)
clf
subplot(1,2,1)
plot(pos(:,1),pos(:,2))
subplot(1,2,2)
hold on
plot(t,vecmag(vel))
[th,rh]=cart2pol(vel(:,1),vel(:,2));
gth=gradient(th);
oops=abs(gth)>2.9;
gth(oops)=(abs(gth(oops))-pi).*sign(gth(oops));
thd=gth/dT;
direcChange=.1*abs(thd).*rh;
testme=gradient(direcChange)/dT;
for k=1:size(kerns,2)
    plot(t,kerns(:,k),'g')
end
plot(t,.1*testme,'r')
[blah,starts]=findpeaks(testme);
for k=1:length(starts)
    plot(t(starts),0,'mx')
end
[blah,ends]=findpeaks(-testme);
for k=1:length(ends)
    plot(t(ends),0,'mo')
end

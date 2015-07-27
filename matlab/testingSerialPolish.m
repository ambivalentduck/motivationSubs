clc
clear all

S=5;
fname=[datadir,'strokeFE',num2str(S),'.mat'];
load(fname)

Tmin=4;
Tmax=6;

% [v,kerns,x,w,tc,ts,t]=buildwalk(7,.005);
% Tmax=max(t);

N=2; %In theory you got this from thermoparams...but spoilers!
dT=mean(diff(t));

f=find((t>=Tmin)&(t<=Tmax));
t=t(f);
x=x(f,:);
v=v(f,:);

[dth,th,spd]=vel2pol(v);
dth=dth*2;
[~,fp]=findpeaks(abs(dth));

figure(1)
clf
subplot(1,2,1)
hold on
plot(x(:,1),x(:,2),'k')
plot(x(fp,1),x(fp,2),'rx')

subplot(1,2,2)
hold on
plot(t,spd,'k')
plot(t(fp),spd(fp),'rx')
plot(t,th/pi,'g')
plot(t,dth,'c')

%Where speed is a local minimum and dth is a local maximum, two
%submovements just barely overlap.
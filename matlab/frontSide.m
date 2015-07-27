clc
clear all

S=5;
fname=[datadir,'strokeFE',num2str(S),'.mat'];
load(fname)
Tmax=2;

% [v,kerns,x,w,tc,ts,t]=buildwalk(7,.005);
% Tmax=max(t);

N=2; %In theory you got this from thermoparams...but spoilers!
dT=mean(diff(t));

f=find(t<Tmax);
figure(1)
clf
subplot(1,2,1)
hold on
plot(x(f,1),x(f,2),'k')
[ddirec,direc,spd]=vel2pol(v(f,:));
subplot(1,2,2)
hold on
plot(t(f),spd,'k')
plot(t(f),direc/pi,'g')
plot(t(f),ddirec,'c')
try
    for k=1:size(kerns,2)
        plot(t,kerns(:,k),'g')
    end
end

k=2;
th=t(f);
dth=th;
ath=th;
jth=th;
flag=0*th;
th(1)=atan2(v(1,2),v(1,1));
dth(1)=0;
ath(1)=0;
jth(1)=0;
while t(k)<Tmax
    th(k)=atan2(v(k,2),v(k,1));
    dth(k)=th(k)-th(k-1);
    
    %Fix theta wrapping issues
    if dth(k)>pi
        dth(k)=dth(k)-2*pi;
    elseif dth(k)<-pi
        dth(k)=dth(k)+2*pi;
    end
    ath(k)=abs(dth(k))-abs(dth(k-1));
    jth(k)=ath(k)-ath(k-1);
    
    if k>10 %some lead-in messiness
        lookback=1;
        if jth(k-lookback)==0 %This should never happen...
            loopback=lookback+1;
        end
        if (jth(k-lookback)<0)&(jth(k)>=0)
            flag(k)=2;
        elseif (jth(k-lookback)>0)&(jth(k)<=0)
            flag(k)=1;
        end
    end
    if flag(k)
        marker='ox';
        subplot(1,2,1)
        plot(x(k,1),x(k,2),['m',marker(flag(k))])
        subplot(1,2,2)
        plot(t(k),sp(k),['m',marker(flag(k))])
        
        %is it spurious, an intersection, or a start/end?
        
        
    end
    k=k+1;
end
plot(t(f),ath*5+.1,'r')

return



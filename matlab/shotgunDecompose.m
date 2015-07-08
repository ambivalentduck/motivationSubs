clc
clear all

S=5;
fname=[datadir,'strokeFE',num2str(S),'.mat'];
load(fname)

N=2; %In theory you got this from thermoparams...but spoilers!

dT=mean(diff(t));
wordLength=1/dT; %1 second
coverage=5;
strands=divide2conquer(length(t),wordLength,coverage);

nStrands=size(strands,1);

figure(1)
clf

for k=1:10 %nStrands
    strand=strands(k,1):strands(k,2);
    
    [ath,dth,th,sp]=vel2dir(v(strand,:));
    msp=max(sp);
    dth=msp*dth/max(dth);
    ath=msp*ath/max(ath);
    ts=t(strand);

    subplot(4,3,k)
    hold on
    plot(ts,sp,'b')
    plot(ts,(th+pi)/4,'k')
    plot(ts,dth,'c')
    plot(ts,ath,'r')
end

%In theory, findpeaks on -direcChange accomplishes what you were previously using recursion to do.
%This means you can do a full 2s in...I think...one pass. If not...you can
%polish in a second pass. After that, you can polish-polish with gradient
%descent.

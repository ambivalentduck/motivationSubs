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
    subplot(4,3,k)
    hold on
    plot(t(strand),vecmag(v(strand,:)))
    [th,rh]=cart2pol(v(strand,1),v(strand,2));
    gth=gradient(th);
    oops=abs(gth)>2.9;
    gth(oops)=(abs(gth(oops))-pi).*sign(gth(oops));
    thd=gth/dT;
    direcChange=.01*abs(thd);
    testme=gradient(direcChange)/dT;
    plot(t(strand),direcChange,'r')
    plot(t(strand),testme/10,'g')
end

%In theory, findpeaks on -direcChange accomplishes what you were previously using recursion to do.
%This means you can do a full 2s in...I think...one pass. If not...you can
%polish in a second pass. After that, you can polish-polish with gradient
%descent.

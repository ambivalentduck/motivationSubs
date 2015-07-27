clc
clear all

center=.5;
t=0:.01:1;
sep=0:.01:.5;
W1=[1 0]';
W2=[.5 .5]';
ts1=.6;
ts2=.4;
WC=W1.*W2;

Pd=zeros(length(sep),length(t));
P1=Pd;
P2=Pd;

figure(3)
clf
hold on

for S=1:length(sep)
    [V1,A1]=computeKern(t,center-sep(S)/2,ts1);
    [V2,A2]=computeKern(t,center+sep(S)/2,ts2);
    %tcC=(center+sep(S)/2-ts2/2+center-sep(S)/2+ts1/2)/2;
    %[VC,AC]=computeKern(t,tcC,sqrt(ts1*ts2));
    P1=dot(W1,W1)*A1.*V1;
    P2=dot(W2,W2)*A2.*V2;
    plot3(sep(S)*ones(length(t),1),t,P1,'k')
    plot3(sep(S)*ones(length(t),1),t,P2,'r')
    Pd(S,:)=dot((W1*V1+W2*V2),(W1*A1+W2*A2))-P1-P2;
    %Q(S,:)=dot(WC,WC)*AC.*VC;
end

[X,Y]=meshgrid(sep,t);
surf(X,Y,Pd','edgealpha',0)
%mesh(X,Y,Q','facealpha',0)
xlabel('Separation, s')
ylabel('Time, s')
zlabel('Wattage')



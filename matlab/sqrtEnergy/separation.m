clc
clear all

center=.5;
t=0:.01:1;
sep=0:.01:.5;
W1=[1 0]';
W2=[3 0]';
ts1=.7;
ts2=.2;
WC=W1.*W2;

P=zeros(length(sep),length(t));
Q=P;

for S=1:length(sep)
    [V1,A1]=computeKern(t,center-sep(S)/2,ts1);
    [V2,A2]=computeKern(t,center+sep(S)/2,ts2);
    %tcC=(center+sep(S)/2-ts2/2+center-sep(S)/2+ts1/2)/2;
    %[VC,AC]=computeKern(t,tcC,sqrt(ts1*ts2));
    P(S,:)=dot((W1*V1+W2*V2),(W1*A1+W2*A2))-dot(W1,W1)*A1.*V1-dot(W2,W2)*A2.*V2;
    %Q(S,:)=dot(WC,WC)*AC.*VC;
end

figure(3)
clf
hold on
[X,Y]=meshgrid(sep,t);
surf(X,Y,P','edgealpha',0)
%mesh(X,Y,Q','facealpha',0)
xlabel('Separation, s')
ylabel('Time, s')
zlabel('Difference, Watts')

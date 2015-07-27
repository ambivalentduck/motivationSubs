clc
clear all

t=0:.001:1;

[K,A]=computeKern(t,.5,1);
P=K.*A;

figure(1)
clf
subplot(2,2,1)
plot(t,K)
title('Speed Kernel')
xlabel('Time')
ylabel('Speed')

subplot(2,2,2)
[h,x]=hist(K(K~=0));
bar(x,h/sum(h))
xlabel('Speed')
ylabel('Relative Frequency')

subplot(2,2,3)
plot(t,P)
title('Power via Kernel')
xlabel('Time')
ylabel('Power')

N=1000
for k=1:N
    catme(k).r=exprnd(1);
    catme(k).vals=catme(k).r*P;
end

vals=horzcat(catme.vals);
r=horzcat(catme.r);
subplot(2,2,4)
hold on
[ec,x1]=ecdf(abs(vals(vals~=0)));
[r,x2]=ecdf(r(r~=0));

mu=expfit(abs(vals));
plot(x1,ec,'b',x2,r,'r',x1,expcdf(x1,mu),'g')
title('Hypothesized CDF Change')
xlabel('Power')
ylabel('Cumulative Pr(Power)')
legend('Raw','Weight^2','Fit')

load('free_exp_05stroke.mat')
%load('free_exp_MF.mat')

pwr=dot(v',a');
figure(2)
clf
inds=1:20:size(x,1);
[ep,x3]=ecdf(abs(pwr));
mu=expfit(abs(pwr));
plot(x3,ep,'b',x3,expcdf(x3,mu),'r')
title('Actual CDF Change')
xlabel('Power')
ylabel('Cumulative Pr(Power)')
legend('Raw','Fit')
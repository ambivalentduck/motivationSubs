function thermoparams(k)
k=6;
fname=[datadir,'strokeFE',num2str(k),'.mat'];
load(fname)

edges=[linspace(0,10,50) inf];
figure(1)
P=dot(a',v')';
counts=histc(abs(P),edges);
counts=counts/sum(counts);

r=-P(P<=0);%abs(P);

% Given exponential distribution with a quirk that ends prior to x1...
% The ratio of two bins factors conveniently such that so long as the bins are of equal width,w,
%    Pr(x2+w)/Pr(x1+w)=exp(-mu(x2-x1))
% While this masks the spike at 0, need principled lower, upper, and width
l=3;
u=5;
w=4;
cuml=sum(r<l);
cumls=sum(r<(l+w));
cumu=sum(r<u);
cumus=sum(r<(u+w));
datamu=-(u-l)/log((cumus-cumu)/(cumls-cuml))

f=find((edges>=l)&(edges<=(u+w)));
P=polyfit(edges(f)',log(counts(f)),1)
ec=expcdf(edges,-1/P(1));
ec=ec*exp(P(2));

figure(1)
clf
hold on
bar(edges(1:end-1),counts(1:end-1))

plot(edges(1:end-2),ec(2:end-1)-ec(1:end-2),'r')
%plot(10,frac-ec(end-2),'rx')

figure(2)
clf
hold on
plot(edges,log(counts),'.')
plot(edges(1:end-2),log(ec(2:end-1)-ec(1:end-2)))





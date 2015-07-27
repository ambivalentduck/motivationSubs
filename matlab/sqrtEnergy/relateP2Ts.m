clc
clear all

syms t w1 w2 real
syms ts positive

ta=t/ts+.5;
K=(30*ta^2-60*ta^3+30*ta^4)/ts;

w=[w1;w2];

v=w*K;
a=w*diff(K,t);

P=simplify(dot(v,a))
W=int(abs(P),t,-ts/2,ts/2)

return
gradw=diff(cost,w);
gradw=subs(gradw,K, k);
gradw=subs(gradw,w*k-y, fitE)

gradtc=diff(cost,tc);
gradtc=subs(gradtc,K, k);
gradtc=subs(gradtc,w*k-y, fitE);
gradtc=subs(gradtc,ta, tA)
%gradtc=subs(collect(gradtc),,tcdiff)
tcdiff=(-120*tA^3 +180*tA^2 -60*tA)/(ts^2)
simplify(gradtc/tcdiff)

gradts=diff(cost,ts);
gradts=subs(gradts,K, k);
gradts=subs(gradts,w*k-y, fitE);
gradts=subs(gradts,ta, tA);
gradts=subs(gradts,(t-tc)/ts^2, tD);
gradts=simplify(gradts)
tsdiff=(tD*(-120*tA^3+180*tA^2-60*tA)-k)/ts
simplify(gradts/tsdiff)
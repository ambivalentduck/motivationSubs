function [ath,dth,th,sp]=vel2dir(v)

[th,sp]=cart2pol(v(:,1),v(:,2));

dth=gradient(th);

%Atan2 isn't smart enough to wrap th around the discontinuity.
wrap=abs(dth)>2.9;
dth(wrap)=(abs(dth(wrap))-pi).*sign(dth(wrap));
gth=gradient(dth);

zfrq=zeros(length(dth)+4,1);
for k=1:length(dth)
    zfrq(k+4)=4*zfrq(k+3)-6*zfrq(k+2)+4*zfrq(k+1)-zfrq(k)+gth(k);
end
ath=zfrq(5:end);
ath=ath-smooth(ath,5);

%ath=gradient(abs(dth));


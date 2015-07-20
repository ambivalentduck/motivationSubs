function [ath,dth,th,sp]=vel2dir(v)

[th,sp]=cart2pol(v(:,1),v(:,2));

dth=gradient(th);

%Atan2 isn't smart enough to wrap th around the discontinuity.
wrap=abs(dth)>2.9;
dth(wrap)=(abs(dth(wrap))-2*pi).*sign(dth(wrap));

ath=gradient(abs(dth));


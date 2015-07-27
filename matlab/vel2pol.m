function [dth,th,sp]=vel2pol(v)

[th,sp]=cart2pol(v(:,1),v(:,2));
dth=gradient(th);

%Wrap th around the discontinuity from atan2.
wrap=abs(dth)>2.9;
dth(wrap)=(abs(dth(wrap))-pi).*sign(dth(wrap));


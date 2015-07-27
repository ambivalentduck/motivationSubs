function [dth,th,sp]=vel2dir(v)

[th,sp]=cart2pol(v(:,1),v(:,2));
ldth=length(th);

dth=gradient(th);

%Atan2 isn't smart enough to wrap th around the discontinuity.
wrap=abs(dth)>2.9;
dth(wrap)=(abs(dth(wrap))-pi).*sign(dth(wrap));
% in=gradient(abs(dth));
% 
% zfrq=zeros(ldth+4,1);
% for k=1:ldth
%     zfrq(k+4)=4*zfrq(k+3)-6*zfrq(k+2)+4*zfrq(k+1)-zfrq(k)+in(k);
% end
% zfrq=zfrq(5:end);
% % for k=1:ldth
% %     zfrq(k)=4*zfrq(k+1)-6*zfrq(k+2)+4*zfrq(k+3)-zfrq(k+4)+in(k);
% % end
% % zfrq=zfrq(1:end-4);
% zffNorm=zeros(size(zfrq));
% zffNorm1=zeros(size(zfrq));
% 
% for k=1:ldth
%     sub=zfrq(max(1,k-span):min(ldth,k+span));
%     zffNorm1(k)=zfrq(k)-mean(sub);
% end
% 
% % for k=1:ldth
% %     sub=zffNorm1(max(1,k-span):min(ldth,k+span));
% %     zffNorm(k)=zffNorm1(k)-mean(sub);
% % end
% zffNorm=zffNorm1;
% %ath=gradient(abs(dth));


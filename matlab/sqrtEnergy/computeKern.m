function [kern,accel]=computeKern(t,tc,ts)

ts2=ts/2;
td=t-tc;
ta=td/ts+.5;
if ~isa(t,'sym')
    ta(abs(td)>ts2)=0;
end

kern=(30*ta.^2-60*ta.^3+30*ta.^4)/ts;
if nargout>1
    accel=(60*ta-180*ta.^2+120*ta.^3)/(ts^2);
end
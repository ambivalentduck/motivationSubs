function stroke_dat2mat(k)

datadir='../data/stroke/';
subname=num2str(k,'%2.2d');
fname=[datadir,'strokeFE',num2str(k),'.mat'];

if ~exist(fname,'file')
    load([datadir,'QQQ7_s',subname,'_d1.mat']);
    x=DDD(:,1:2);
    filtn=64;
    filtType='loess';
    t=0:.005:.005*(size(DDD,1)-1);
    t(end)/60
    t=t';
    x=[smooth(x(:,1),filtn,filtType) smooth(x(:,2),filtn,filtType)];
    v=[gradient(x(:,1)) gradient(x(:,2))]/.005;
    a=[gradient(v(:,1)) gradient(v(:,2))]/.005;
    save(fname,'t','x','v','a');
end
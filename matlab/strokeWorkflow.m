clc
clear all

%Workflow

n=6; %1:10

%Add differential optimization just in case it's needed
addpath ../../DeOpt/

workflow={'','stroke_dat2mat'
    %'nTW','thermoparams'
    %'dX','decompose'
    %'NEVERMATCH','finalresultsfig'
    };

prefix='strokeFE';
mfiles=dir('.');
datafiles=dir(datadir);

for k=n
    flag=0;
    for kk=1:size(workflow,1)
        if (~exist([datadir,prefix,num2str(k),workflow{kk,1},'.mat'],'file'))||flag
            feval(workflow{kk,2},k);
            flag=1;
        elseif mfiles(strcmp({mfiles.name},[workflow{kk,2},'.m'])).datenum > datafiles(strcmp({datafiles.name},[prefix,num2str(k),workflow{kk,1},'.mat'])).datenum
            feval(workflow{kk,2},k);
            flag=1;
        end
    end
end
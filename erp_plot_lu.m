clc;
clear all;
cd('D:\ternus_EEG\Raw data1\ternus-eeg');
load('chanlocs.mat');
load('erp_rmbase.mat');
%load('erp_rmbase2.mat');
load('erptimes.mat');
 EM=permute(EM_rmbase,[2 1 3]);
 GM=permute(GM_rmbase,[2 1 3]);
 %% plot erp
 EM_erp=squeeze(mean(EM,3));
figure;plot(times,EM_erp(:,28),'b-')
GM_erp=squeeze(mean(GM,3));
hold on;plot(times,GM_erp(:,28),'r-');
 xlim([-700 600]); 
%%
 diff=GM-EM;
 data={squeeze(EM(161:385,:,:)) ; squeeze(GM(161:385,:,:))};
%data={squeeze(EM(209:353,:,:)); squeeze(GM(209:353,:,:))};%squeeze(diff(209:353,:,:));; -100ms~800ms
% data_chan={squeeze(mean(EM(209:353,:,:),2));squeeze(mean(GM(209:353,:,:),2))};
data_diff=squeeze(diff(161:385,28,:));
figure;plot(times(161:385),mean(data_diff,2));
std_plotcurve(times(161:385),data,...
     'datatype','erp','titles',{'EMvsGM'},'plotgroups','together','plotconditions','together',...
     'legend','on','plotdiff','off','plotstderr', 'on', 'figure', 'on','threshold',NaN,'ylim',[-4 4],'filter',30,'colors',{[238/255,29/255,37/255],[58/255,82/255,164/255],[1,1,1]}...
 ,'chanlocs',chanlocs);%  ,'threshold',0.05',

% %--plot all chanels--% %
std_plotcurve(times(161:225),{squeeze(GM(161:225,:,:))},...
     'datatype','erp','titles',{'EMvsGM'},'plotgroups','together','plotconditions','together',...
     'legend','on','plotdiff','off','plotstderr', 'on', 'figure', 'on','threshold',NaN,'ylim',[-1.5 1.5],'filter',30,'colors',{[0,0,0],[58/255,82/255,164/255],[1,1,1]}...
,'chanlocs',chanlocs);% 

% %--plot specific channel--%
chan=[28];
subs=[1:17];

color_matrix=[];
for m=1:17
color_matrix=rand(1,3);
matrix{m}={color_matrix};
end

std_plotcurve(times(161:385),{squeeze(diff(161:385,chan,subs))},...
     'datatype','erp','titles',{['chan']},'plotgroups','together','plotconditions','together',...
     'legend','on','plotdiff','off','plotstderr', 'on','plotsubjects','off', 'figure', 'on','threshold',NaN,'ylim',[-1.5 1.5],'filter',30,'colors',{[0,0,0],[58/255,82/255,164/255],[1,1,1]} ...
);% 

 
%   [stats, df, pvals, surrog]=statcond(data,'paired','on','method','param','verbose','on');
%  std_plotcurve(times(161:385),data,...
%      'datatype','erp','titles',{'EMvsGM'},'plotgroups','together','plotconditions','together',...
%      'legend','on','plotstderr', 'off', 'figure', 'on','threshold',NaN,'ylim',[-4 4],'filter',30,'chanlocs',chanlocs,'colors',{[238/255,29/255,37/255],[58/255,82/255,164/255],[1,1,1]}...
%   , 'condstats',{pvals});%  ,'threshold',0.05',
 axh=findall(gcf,'type','axes');set(axh,'YDir','reverse');

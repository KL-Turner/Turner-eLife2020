function [AnalysisResults] = FigS21_Manuscript2020(rootFolder,saveFigs,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
% Purpose: Generate figure panel S21 for Turner_Kederasetti_Gheres_Proctor_Costanzo_Drew_Manuscript2020
%________________________________________________________________________________________________________________________

%% set-up and process data
dataDir = [rootFolder '\Summary Figures and Structures\Pixel Drift Correction\'];
cd(dataDir)
% character list of ProcData files
procDataFileStruct = dir('*_ProcData.mat');
procDataFiles = {procDataFileStruct.name}';
procDataFileIDs = char(procDataFiles);
catLH_CBVdata = [];
catRH_CBVdata = [];
catCement_cementData = [];
% load the processed CBV/cement data from each file and concat it into one array
for aa = 1:size(procDataFileIDs,1)
    procDataFileID = procDataFileIDs(aa,:);
    load(procDataFileID,'-mat')
    samplingRate = ProcData.notes.CBVCamSamplingRate;
    LH_CBVdata = ProcData.data.CBV.LH;
    RH_CBVdata = ProcData.data.CBV.RH;
    Cement_cementData = ProcData.data.CBV.Cement;
    catLH_CBVdata = horzcat(catLH_CBVdata,LH_CBVdata); %#ok<*AGROW>
    catRH_CBVdata = horzcat(catRH_CBVdata,RH_CBVdata);
    catCement_cementData = horzcat(catCement_cementData,Cement_cementData);
end
% establish whether a slow exponential trend exists for the data
[B,A] = butter(3,0.01/(samplingRate/2),'low');
filtCatCement_cementData = filtfilt(B,A,catCement_cementData);
x = ((1:length(filtCatCement_cementData))/samplingRate)';
% create a weight vector for the trend
Cement_weightVec = ones(1,length(x));
Cement_secondHalfMean = mean(filtCatCement_cementData(floor(length(filtCatCement_cementData/2)):end));
for t = 1:length(Cement_weightVec)
    if filtCatCement_cementData(t) > Cement_secondHalfMean
        Cement_weightVec(t) = 10;
    end
end
% compare weighted models
Cement_modelFit = fit(x,filtCatCement_cementData','exp2','Weight',Cement_weightVec);
Cement_modelFit_Y = Cement_modelFit(x);
Cement_modelFit_norm = (Cement_modelFit_Y - min(Cement_modelFit_Y))./min(Cement_modelFit_Y);
Cement_modelFit_flip = 1 - Cement_modelFit_norm;
% apply exponential correction to original data
LH_adjCatC_CBVdata = catLH_CBVdata.*Cement_modelFit_flip';
RH_adjCatC_CBVdata = catRH_CBVdata.*Cement_modelFit_flip';
cd(rootFolder)
%% Fig. S21
summaryFigure = figure('Name','FigS21 (a-f)');
sgtitle('Figure Panel S21 (a-f) Turner Manuscript 2020')
%% [S21a] Data and exponential fit for cement ROI
ax1 = subplot(2,3,1);
p4a = plot(x,filtCatCement_cementData,'color',colors_Manuscript2020('deep carrot orange'),'LineWidth',1);
hold on
p4b = plot(x,Cement_modelFit_Y,'color',colors_Manuscript2020('electric purple'),'LineWidth',1);
title('[S21a] Cement ROI pixel drift')
xlabel('Time (s)')
ylabel('Pixel intensity (12-bit)')
legend([p4a,p4b],'cement ROI drift','exp2 fit')
axis tight
axis square
set(gca,'box','off')
ax1.TickLength = [0.03,0.03];
%% [S21b] original left hemisphere
ax2 = subplot(2,3,2);
plot(x,catLH_CBVdata,'color','r','LineWidth',0.5)
title({'[S21b] Left hemisphere','original data'})
xlabel('Time (s)')
ylabel('Pixel intensity (12-bit)')
axis tight
axis square
set(gca,'box','off')
ax2.TickLength = [0.03,0.03];
%% [S21c] original right hemisphere
ax3 = subplot(2,3,3);
plot(x,catRH_CBVdata,'color','c','LineWidth',0.5)
title({'[S21c] Right hemisphere','original data'})
xlabel('Time (s)')
ylabel('Pixel intensity (12-bit)')
axis tight
axis square
set(gca,'box','off')
ax3.TickLength = [0.03,0.03];
%% [S21d] correction profile
ax4 = subplot(2,3,4);
plot(x,Cement_modelFit_flip,'color',colors_Manuscript2020('electric purple'),'LineWidth',1)
title('[S21d] Correction profile')
xlabel('Time (s)')
ylabel('Correction profile (%)')
axis tight
axis square
set(gca,'box','off')
ax4.TickLength = [0.03,0.03];
%% [S21e] left hemisphere correction
ax5 = subplot(2,3,5);
plot(x,catLH_CBVdata,'color','r','LineWidth',0.5)
hold on
p8 = plot(x,LH_adjCatC_CBVdata,'color',colors_Manuscript2020('electric purple'),'LineWidth',0.5);
title({'[S21e] Left hemisphere','original vs. corrected data'})
xlabel('Time (s)')
ylabel('Pixel intensity (12-bit)')
legend(p8,'corrected')
axis tight
axis square
set(gca,'box','off')
ax5.TickLength = [0.03,0.03];
%% [S21f] right hemisphere correction
ax6 = subplot(2,3,6);
plot(x,catRH_CBVdata,'color','c','LineWidth',0.5)
hold on
plot(x,RH_adjCatC_CBVdata,'color',colors_Manuscript2020('electric purple'),'LineWidth',0.5);
title({'[S21f] Right hemisphere','original vs. corrected data'})
xlabel('Time (s)')
ylabel('Pixel intensity (12-bit)')
axis tight
axis square
set(gca,'box','off')
ax6.TickLength = [0.03,0.03];
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder '\Summary Figures and Structures\MATLAB Analysis Figures\'];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure,[dirpath 'FigS21']);
    set(summaryFigure,'PaperPositionMode','auto');
    print('-painters','-dpdf','-bestfit',[dirpath 'FigS21'])
end

end

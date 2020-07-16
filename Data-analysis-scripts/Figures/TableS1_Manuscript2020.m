function [AnalysisResults] = TableS1_Manuscript2020(rootFolder,saveFigs,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
% Purpose: Generate Table S1 for Turner_Kederasetti_Gheres_Proctor_Costanzo_Drew_Manuscript2020
%________________________________________________________________________________________________________________________

%% set-up and process data
animalIDs = {'T99','T101','T102','T103','T105','T108','T109','T110','T111','T119','T120','T121','T122','T123'};
allCatLabels = [];
% extract data from each animal's sleep scoring results
for aa = 1:length(animalIDs)
    animalID = animalIDs{1,aa};
    dataLoc = [rootFolder '/' animalID '/Bilateral Imaging/'];
    cd(dataLoc)
    scoringResults = 'Forest_ScoringResults.mat';
    load(scoringResults,'-mat')
    numberOfScores(aa,1) = length(ScoringResults.alllabels); %#ok<*AGROW>
    indAwakePerc(aa,1) = round((sum(strcmp(ScoringResults.alllabels,'Not Sleep'))/length(ScoringResults.alllabels))*100,1);
    indNremPerc(aa,1) = round((sum(strcmp(ScoringResults.alllabels,'NREM Sleep'))/length(ScoringResults.alllabels))*100,1);
    indRemPerc(aa,1) = round((sum(strcmp(ScoringResults.alllabels,'REM Sleep'))/length(ScoringResults.alllabels))*100,1);
    allCatLabels = vertcat(allCatLabels,ScoringResults.alllabels);
end
labels = {'Awake','NREM','REM'};
% mean percentage of each state between animals
meanAwakePerc = round(mean(indAwakePerc,1),1);
stdAwakePerc = round(std(indAwakePerc,0,1),1);
meanNremPerc = round(mean(indNremPerc,1),1);
stdNremPerc = round(std(indNremPerc,0,1),1);
meanRemPerc = round(mean(indRemPerc,1),1);
stdRemPerc = round(std(indRemPerc,0,1),1);
meanPercs = horzcat(meanAwakePerc,meanNremPerc,meanRemPerc);
% percentage of each state for all labels together
allAwakePerc = round((sum(strcmp(allCatLabels,'Not Sleep'))/length(allCatLabels))*100,1);
allNremPerc = round((sum(strcmp(allCatLabels,'NREM Sleep'))/length(allCatLabels))*100,1);
allRemPerc = round((sum(strcmp(allCatLabels,'REM Sleep'))/length(allCatLabels))*100,1);
meanAllPercs = horzcat(allAwakePerc,allNremPerc,allRemPerc);
% total time per animal behavioral states
labelTime = 5;   % seconds
IOS_indTotalTimeHours = round(((numberOfScores*labelTime)/60)/60,1);
IOS_allTimeHours = round(sum(IOS_indTotalTimeHours),1);
IOS_meanTimeHours = round(mean(IOS_indTotalTimeHours,1),1);
IOS_stdTimeHours = round(std(IOS_indTotalTimeHours,0,1),1);
IOS_totalTimeAwake = round(IOS_indTotalTimeHours.*(indAwakePerc/100),1);
IOS_totalTimeNREM = round(IOS_indTotalTimeHours.*(indNremPerc/100),1);
IOS_totalTimeREM = round(IOS_indTotalTimeHours.*(indRemPerc/100),1);
cd(rootFolder)
%% Table S1
summaryTable = figure('Name','TableS1'); %#ok<*NASGU>
sgtitle('Table S1 Turner Manuscript 2020')
variableNames = {'TotalTimeHrs','AwakeTimeHrs','AwakePerc','NREMTimeHrs','NREMPerc','REMTimeHrs','REMPerc'};
T = table(IOS_indTotalTimeHours,IOS_totalTimeAwake,indAwakePerc,IOS_totalTimeNREM,indNremPerc,IOS_totalTimeREM,indRemPerc,'RowNames',animalIDs,'VariableNames',variableNames);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames,'Units','Normalized','Position',[0,0,1,1]);
uicontrol('Style','text','Position',[700,600,100,150],'String',{'Total Time (Hrs): ' num2str(IOS_allTimeHours),'Mean time per animal (Hrs): ' num2str(IOS_meanTimeHours) ' +/- ' num2str(IOS_stdTimeHours)});
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder '\Summary Figures and Structures\MATLAB Analysis Figures\'];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryTable,[dirpath 'TableS1']);
end

end

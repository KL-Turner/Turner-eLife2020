function [AnalysisResults] = TableS8_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
% Purpose: Generate Table S8 for Turner_Kederasetti_Gheres_Proctor_Costanzo_Drew_Manuscript2020
%________________________________________________________________________________________________________________________

%% set-up and process data
columnNames = AnalysisResults.Coherr.columnNames;
columnNames = {'Rest','NREM','REM','Alert','Asleep','All'};
rowNames = {'Delta_C001_meanStD','Delta_C001_pVal','Theta_C001_meanStD','Theta_C001_pVal'...
    'Alpha_C001_meanStD','Alpha_C001_pVal','Beta_C001_meanStD','Beta_C001_pVal'};
T(1,:) = cell2table(AnalysisResults.Coherr.deltaBandPower.meanStD001);
T(2,:) = cell2table(AnalysisResults.Coherr.deltaBandPower.p001);
T(3,:) = cell2table(AnalysisResults.Coherr.thetaBandPower.meanStD001);
T(4,:) = cell2table(AnalysisResults.Coherr.thetaBandPower.p001);
T(5,:) = cell2table(AnalysisResults.Coherr.alphaBandPower.meanStD001);
T(6,:) = cell2table(AnalysisResults.Coherr.alphaBandPower.p001);
T(7,:) = cell2table(AnalysisResults.Coherr.betaBandPower.meanStD001);
T(8,:) = cell2table(AnalysisResults.Coherr.betaBandPower.p001);
T.Properties.RowNames = rowNames;
T.Properties.VariableNames = columnNames;
%% Table S8
summaryTable = figure('Name','TableS8'); %#ok<*NASGU>
sgtitle('Table S8 Turner Manuscript 2020')
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames,'Units','Normalized','Position',[0,0,1,1]);
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures' delim];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryTable,[dirpath 'TableS8']);
end

end

function [AnalysisResults] = Table3_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
% Purpose: Generate Table 3 for Turner_Kederasetti_Gheres_Proctor_Costanzo_Drew_Manuscript2020
%________________________________________________________________________________________________________________________

%% set-up and process data
columnNames = AnalysisResults.Coherr.columnNames;
columnNames = {'Rest','NREM','REM','Alert','Asleep','All'};
rowNames = {'Gamma_C01_meanStD','Gamma_C01_pVal','HbT_C01_meanStD','HbT_C01_pVal'};
T(1,:) = cell2table(AnalysisResults.Coherr.gammaBandPower.meanStD01);
T(2,:) = cell2table(AnalysisResults.Coherr.gammaBandPower.p01);
T(3,:) = cell2table(AnalysisResults.Coherr.CBV_HbT.meanStD01);
T(4,:) = cell2table(AnalysisResults.Coherr.CBV_HbT.p01);
T.Properties.RowNames = rowNames;
T.Properties.VariableNames = columnNames;
%% Table 3
summaryTable = figure('Name','Table3'); %#ok<*NASGU>
sgtitle('Table 3 Turner Manuscript 2020')
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames,'Units','Normalized','Position',[0,0,1,1]);
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures'];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryTable,[dirpath 'Table3']);
end

end

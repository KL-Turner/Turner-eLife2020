function [AnalysisResults] = TableS6_Manuscript2020(rootFolder,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
% Purpose: Generate Table S6 for Turner_Kederasetti_Gheres_Proctor_Costanzo_Drew_Manuscript2020
%________________________________________________________________________________________________________________________

%% set-up and process data for Table S6
columnNames = AnalysisResults.NeuralHemoCoherence.columnNames;
rowNames = {'Delta_C01_meanStD','Delta_C01_pVal','Theta_C01_meanStD','Theta_C01_pVal'...
    'Alpha_C01_meanStD','Alpha_C01_pVal','Beta_C01_meanStD','Beta_C01_pVal'...
    'Delta_C001_meanStD','Delta_C001_pVal','Theta_C001_meanStD','Theta_C001_pVal'...
    'Alpha_C001_meanStD','Alpha_C001_pVal','Beta_C001_meanStD','Beta_C001_pVal'};
T(1,:) = cell2table(AnalysisResults.NeuralHemoCoherence.deltaBandPower.meanStD01);
T(2,:) = cell2table(AnalysisResults.NeuralHemoCoherence.deltaBandPower.p01);
T(3,:) = cell2table(AnalysisResults.NeuralHemoCoherence.thetaBandPower.meanStD01);
T(4,:) = cell2table(AnalysisResults.NeuralHemoCoherence.thetaBandPower.p01);
T(5,:) = cell2table(AnalysisResults.NeuralHemoCoherence.alphaBandPower.meanStD01);
T(6,:) = cell2table(AnalysisResults.NeuralHemoCoherence.alphaBandPower.p01);
T(7,:) = cell2table(AnalysisResults.NeuralHemoCoherence.betaBandPower.meanStD01);
T(8,:) = cell2table(AnalysisResults.NeuralHemoCoherence.betaBandPower.p01);
T(9,:) = cell2table(AnalysisResults.NeuralHemoCoherence.deltaBandPower.meanStD001);
T(10,:) = cell2table(AnalysisResults.NeuralHemoCoherence.deltaBandPower.p001);
T(11,:) = cell2table(AnalysisResults.NeuralHemoCoherence.thetaBandPower.meanStD001);
T(12,:) = cell2table(AnalysisResults.NeuralHemoCoherence.thetaBandPower.p001);
T(13,:) = cell2table(AnalysisResults.NeuralHemoCoherence.alphaBandPower.meanStD001);
T(14,:) = cell2table(AnalysisResults.NeuralHemoCoherence.alphaBandPower.p001);
T(15,:) = cell2table(AnalysisResults.NeuralHemoCoherence.betaBandPower.meanStD001);
T(16,:) = cell2table(AnalysisResults.NeuralHemoCoherence.betaBandPower.p001);
T.Properties.RowNames = rowNames;
T.Properties.VariableNames = columnNames;
%% save figure(s)
dirpath = [rootFolder '\Summary Figures and Structures\'];
if ~exist(dirpath,'dir')
    mkdir(dirpath);
end
%% Table S6
summaryTable = figure('Name','TableS6');
sgtitle('Table S6 Turner Manuscript 2020')
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames,'Units','Normalized','Position',[0,0,1,1]);
savefig(summaryTable,[dirpath 'TableS6']);

end

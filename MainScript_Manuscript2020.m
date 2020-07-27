function [] = MainScript_Manuscript2020()
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
% Purpose: Generates KLT's main and supplemental figs for the 2020 sleep paper.
%
% Scripts used to pre-process the original data are located in the folder "Pre-processing-scripts".
% Functions that are used in both the analysis and pre-processing are located in the analysis folder.
%________________________________________________________________________________________________________________________

clear; clc; close all;
%% make sure the code repository and data are present in the current directory.
currentFolder = pwd;
addpath(genpath(currentFolder));
fileparts = strsplit(currentFolder,filesep);
if ismac
    rootFolder = fullfile(filesep,fileparts{1:end});
    delim = '/';
else
    rootFolder = fullfile(fileparts{1:end});
    delim = '\';
end
% add root folder to Matlab's working directory.
addpath(genpath(rootFolder))
%% run the data analysis. The progress bars will show the analysis progress.
rerunAnalysis = 'n';
saveFigs = 'n';
if exist('AnalysisResults.mat') ~= 2 || strcmp(rerunAnalysis,'y') == true
    multiWaitbar_Manuscript2020('Analyzing sleep probability',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing behavioral distributions',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing behavioral heart rate' ,0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing behavioral transitions',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing vessel behavioral transitions',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing behavioral hemodynamics',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing behavioral vessel diameter',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing laser doppler flow',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing coherence',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing neural-hemo coherence',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing power spectra',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing vessel power spectra',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing Pearson''s correlation coefficients',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing cross correlation',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing model cross validation distribution',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing evoked responses',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing vessel evoked responses',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing CBV-Gamma relationship',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing HbT-Sleep probability',0,'Color','B'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing TwoP-Sleep probability',0,'Color','W'); pause(0.25);
    multiWaitbar_Manuscript2020('Analyzing arteriole durations',0,'Color','B'); pause(0.25);
    % run analysis and output a structure containing all the analyzed data.
    [AnalysisResults] = AnalyzeData_Manuscript2020(rootFolder);
    multiWaitbar_Manuscript2020('CloseAll');
else
    disp('Loading analysis results and generating figures...'); disp(' ')
    load('AnalysisResults.mat')
end
%% supplemental figure panels
[AnalysisResults] = FigS22_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS21_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS20_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS19_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS18_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS17_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS16_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS15_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS14_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS13_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS12_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS11_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS10_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS9_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS8_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS7_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS6_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS5_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS4_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS3_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS2_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = FigS1_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
%% supplemental tables
[AnalysisResults] = TableS12_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS11_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS10_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS9_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS8_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS7_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS6_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS5_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
% TableS4 - text only, no figure
% TableS3 - text only, no figure
[AnalysisResults] = TableS2_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = TableS1_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
%% main figure panels
[AnalysisResults] = Fig8_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig7_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig6_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig5_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig4_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig3_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig2_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Fig1_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
%% tables
[AnalysisResults] = Table5_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Table4_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Table3_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Table2_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults);
[AnalysisResults] = Table1_Manuscript2020(rootFolder,saveFigs,delim,AnalysisResults); %#ok<NASGU>
%% fin.
disp('MainScript Analysis - Complete'); disp(' ')
end

function [AnalysisResults] = AnalyzeData_Manuscript2020(rootFolder)
% IOS animal IDs
IOS_animalIDs = {'T99','T101','T102','T103','T105','T108','T109','T110','T111','T119','T120','T121','T122','T123'};
% Two photon animal IDs
TwoP_animalIDs = {'T115','T116','T117','T118','T125','T126'};
saveFigs = 'y';
if exist('AnalysisResults.mat') == 2
    load('AnalysisResults.mat')
else
    AnalysisResults = [];
end
%% Block [1] Analyze the probability of an animal being awake or asleep based on duration of the trial (IOS)
runFromStart = 'n';
for aa = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,aa})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,aa}),'SleepProbability') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeAwakeProbability_Manuscript2020(IOS_animalIDs{1,aa},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing sleep probability','Value',aa/length(IOS_animalIDs));
end
%% Block [2] Analyze the behavioral distributions (IOS)
runFromStart = 'n';
for bb = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,bb})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,bb}),'BehaviorDistributions') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeBehavioralDistributions_Manuscript2020(IOS_animalIDs{1,bb},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing behavioral distributions','Value',bb/length(IOS_animalIDs));
end
%% Block [3] Analyze the mean heart rate during different behaviors (IOS)
runFromStart = 'n';
for cc = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,cc})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,cc}),'MeanHR') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeMeanHeartRate_Manuscript2020(IOS_animalIDs{1,cc},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing behavioral heart rate','Value',cc/length(IOS_animalIDs));
end
%% Block [4] Analyze behavioral transitions (IOS)
runFromStart = 'n';
for dd = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,dd})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,dd}),'Transitions') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeTransitionalAverages_Manuscript2020(IOS_animalIDs{1,dd},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing behavioral transitions','Value',dd/length(IOS_animalIDs));
end
%% Block [5] Anayze behavioral transitions (2PLSM)
runFromStart = 'n';
for ee = 1:length(TwoP_animalIDs)
    if isfield(AnalysisResults,(TwoP_animalIDs{1,ee})) == false || isfield(AnalysisResults.(TwoP_animalIDs{1,ee}),'Transitions') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeVesselTransitionalAverages_Manuscript2020(TwoP_animalIDs{1,ee},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing vessel behavioral transitions','Value',ee/length(TwoP_animalIDs));
end
%% Block [6] Analyze the mean HbT during different behaviors (IOS)
runFromStart = 'n';
for ff = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,ff})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,ff}),'MeanCBV') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeMeanCBV_Manuscript2020(IOS_animalIDs{1,ff},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing behavioral hemodynamics','Value',ff/length(IOS_animalIDs));
end
%% Block [7] Analyze the mean vessel diameter during different behaviors (2PLSM)
runFromStart = 'n';
for gg = 1:length(TwoP_animalIDs)
    if isfield(AnalysisResults,(TwoP_animalIDs{1,gg})) == false || isfield(AnalysisResults.(TwoP_animalIDs{1,gg}),'MeanVesselDiameter') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeMeanVesselDiameter_Manuscript2020(TwoP_animalIDs{1,gg},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing behavioral vessel diameter','Value',gg/length(TwoP_animalIDs));
end
%% Block [8] Analyze mean laser doppler flow during different behaviors (IOS)
runFromStart = 'n';
for hh = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,hh})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,hh}),'LDFlow') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeLaserDoppler_Manuscript2020(IOS_animalIDs{1,hh},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing laser doppler flow','Value',hh/length(IOS_animalIDs));
end
%% Block [9] Analyze the coherence between bilateral hemispheres (IOS)
runFromStart = 'n';
for jj = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,jj})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,jj}),'Coherence') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeCoherence_Manuscript2020(IOS_animalIDs{1,jj},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing coherence','Value',jj/length(IOS_animalIDs));
end
%% Block [10] Analyze the coherence between bilateral hemispheres (IOS)
runFromStart = 'n';
for jj = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,jj})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,jj}),'NeuralHemoCoherence') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeNeuralHemoCoherence_Manuscript2020(IOS_animalIDs{1,jj},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing neural-hemo coherence','Value',jj/length(IOS_animalIDs));
end
%% Block [11] Analyze the power spectra of each single hemisphere (IOS)
runFromStart = 'n';
for kk = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,kk})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,kk}),'PowerSpectra') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzePowerSpectrum_Manuscript2020(IOS_animalIDs{1,kk},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing power spectra','Value',kk/length(IOS_animalIDs));
end
%% Block [12] Analyze vessel power during different behaviors (2PLSM)
runFromStart = 'n';
for ll = 1:length(TwoP_animalIDs)
    if isfield(AnalysisResults,(TwoP_animalIDs{1,ll})) == false || isfield(AnalysisResults.(TwoP_animalIDs{1,ll}),'PowerSpectra') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeVesselPowerSpectrum_Manuscript2020(TwoP_animalIDs{1,ll},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing vessel power spectra','Value',ll/length(TwoP_animalIDs));
end
%% Block [13] Analyze the Pearson's correlation coefficient between neural/hemodynamic signals (IOS)
runFromStart = 'n';
for mm = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,mm})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,mm}),'CorrCoeff') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeCorrCoeffs_Manuscript2020(IOS_animalIDs{1,mm},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing Pearson''s correlation coefficients','Value',mm/length(IOS_animalIDs));
end
%% Block [14] Analyze the cross-correlation between local neural activity and hemodynamics (IOS)
runFromStart = 'n';
for nn = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,nn})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,nn}),'XCorr') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeXCorr_Manuscript2020(IOS_animalIDs{1,nn},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing cross correlation','Value',nn/length(IOS_animalIDs));
end
%% Block [15] Analyze the cross validation distribution of 100 iterations of real data and shuffled data (IOS)
runFromStart = 'n';
for oo = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,oo})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,oo}),'ModelAccuracy') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeModelAccuracy_Manuscript2020(IOS_animalIDs{1,oo},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing model cross validation distribution','Value',oo/length(IOS_animalIDs));
end
%% Block [16] Analyze the stimulus-evoked and whisking-evoked neural/hemodynamic responses (IOS)
runFromStart = 'n';
for pp = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,pp})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,pp}),'EvokedAvgs') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeEvokedResponses_Manuscript2020(IOS_animalIDs{1,pp},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing evoked responses','Value',pp/length(IOS_animalIDs));
end
%% Block [17] Analyze the whisking-evoked arteriole response (2PLSM)
runFromStart = 'n';
for qq = 1:length(TwoP_animalIDs)
    if isfield(AnalysisResults,(TwoP_animalIDs{1,qq})) == false || isfield(AnalysisResults.(TwoP_animalIDs{1,qq}),'EvokedAvgs') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeVesselEvokedResponses_Manuscript2020(TwoP_animalIDs{1,qq},saveFigs,rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing vessel evoked responses','Value',qq/length(TwoP_animalIDs));
end
%% Block [18] Analyze the CBV-gamma relationship (IOS)
runFromStart = 'n';
for qq = 1:length(IOS_animalIDs)
    if isfield(AnalysisResults,(IOS_animalIDs{1,qq})) == false || isfield(AnalysisResults.(IOS_animalIDs{1,qq}),'HbTvsGamma') == false || strcmp(runFromStart,'y') == true
        [AnalysisResults] = AnalyzeCBVGammaRelationship_Manuscript2020(IOS_animalIDs{1,qq},rootFolder,AnalysisResults);
    end
    multiWaitbar_Manuscript2020('Analyzing CBV-Gamma relationship','Value',qq/length(IOS_animalIDs));
end
%% Block [19] Analyze the HbT-Sleep probability (IOS)
runFromStart = 'n';
if isfield(AnalysisResults,'HbTSleepProbability') == false || strcmp(runFromStart,'y') == true
    [AnalysisResults] = AnalyzeHbTSleepProbability_Manuscript2020(IOS_animalIDs,rootFolder,AnalysisResults);
end
multiWaitbar_Manuscript2020('Analyzing HbT-Sleep probability','Value',1/length(1));
%% Block [20] Analyze the TwoP-Sleep probability (2PLSM)
runFromStart = 'n';
if isfield(AnalysisResults,'TwoPSleepProbability') == false || strcmp(runFromStart,'y') == true
    [AnalysisResults] = AnalyzeTwoPSleepProbability_Manuscript2020(TwoP_animalIDs,rootFolder,AnalysisResults);
end
multiWaitbar_Manuscript2020('Analyzing TwoP-Sleep probability','Value',1/length(1));
%% Block [21] Analyze the time of each arousal-state data per artery (2PLSM)
runFromStart = 'n';
if isfield(AnalysisResults,'ArterioleDurations') == false || strcmp(runFromStart,'y') == true
    [AnalysisResults] = AnalyzeArterioleDurations_Manuscript2020(TwoP_animalIDs,rootFolder,AnalysisResults);
end
multiWaitbar_Manuscript2020('Analyzing arteriole durations','Value',1/length(1));
%% fin.
disp('Loading analysis results and generating figures...'); disp(' ')

end

%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
%   Purpse:  1) Additions to the MergedData structure including flags and scores.
%            2) A RestData.mat structure with periods of rest.
%            3) A EventData.mat structure with event-related information.
%            4) Find the resting baseline for vessel diameter and neural data.
%            5) Analyzing the spectrogram for each file and normalize by the resting baseline.
%________________________________________________________________________________________________________________________
%
%   Inputs: MergedData files, followed by newly created RestData and EventData structs for normalization 
%           by the unique day and vessel's resting baseline.
%
%   Outputs: 1) Additions to the MergedData structure including behavioral flags and scores.
%            2) A RestData.mat structure with periods of rest.
%            3) A EventData.mat structure with event-related information.
%            4) A Baselines.mat structure with resting baselines.
%            5) A SpecData.mat structure for each merged data file.
%
%   Last Revised: March 21st, 2019
%________________________________________________________________________________________________________________________

%% BLOCK PURPOSE: [0] Load the script's necessary variables and data structures.
% Clear the workspace variables and command window.
clc;
clear;
disp('Analyzing Block [0] Preparing the workspace and loading variables.'); disp(' ')

mergedDirectory = dir('*_MergedData.mat');
mergedDataFiles = {mergedDirectory.name}';
mergedDataFiles = char(mergedDataFiles);
[animalID,~,~,~,~,~] = GetFileInfo2_2P(mergedDataFiles(1,:));
load(mergedDataFiles(1,:),'-mat');
trialDuration_Sec = MergedData.notes.trialDuration_Sec;
dataTypes = {'vesselDiameter','EMG','corticalDeltaBandPower','corticalThetaBandPower','corticalAlphaBandPower','corticalBetaBandPower',...
    'corticalGammaBandPower','corticalMUAPower','hippocampalDeltaBandPower','hippocampalThetaBandPower','hippocampalAlphaBandPower'...
    'hippocampalBetaBandPower','hippocampalGammaBandPower','hippocampalMUAPower'};


%% BLOCK PURPOSE: [1] Categorize data.
disp('Analyzing Block [1] Categorizing behavioral data, adding flags to MergedData structures.'); disp(' ')
for a = 1:size(mergedDataFiles, 1)
    fileName = mergedDataFiles(a,:);
    disp(['Analyzing file ' num2str(a) ' of ' num2str(size(mergedDataFiles, 1)) '...']); disp(' ')
    CategorizeData_2P(fileName)
end

%% BLOCK PURPOSE: [2] Create RestData data structure.
disp('Analyzing Block [2] Creating RestData struct for vessels and neural data.'); disp(' ')
[RestData] = ExtractRestingData_2P(mergedDataFiles,dataTypes);
    
%% BLOCK PURPOSE: [3] Create EventData data structure.
disp('Analyzing Block [3] Creating EventData struct for vessels and neural data.'); disp(' ')
[EventData] = ExtractEventTriggeredData_2P(mergedDataFiles,dataTypes);

%% BLOCK PURPOSE: [4] Create Baselines data structure.
disp('Analyzing Block [4] Finding the resting baseline for vessel diameter and neural data.'); disp(' ')
targetMinutes = 15;
trialDuration_sec = 900;
[RestingBaselines] = CalculateRestingBaselines_2P(animalID,targetMinutes,trialDuration_sec,RestData);

%% BLOCK PURPOSE [5] Analyze the spectrogram for each session.
disp('Analyzing Block [5] Analyzing the spectrogram for each file and normalizing by the resting baseline.'); disp(' ')
neuralDataTypes = {'corticalNeural','hippocampalNeural'};
CreateTrialSpectrograms_2P(mergedDataFiles,neuralDataTypes);

% Find spectrogram baselines for each day
specDirectory = dir('*_SpecData.mat');
specDataFiles = {specDirectory.name}';
specDataFiles = char(specDataFiles);
[RestingBaselines] = CalculateSpectrogramBaselines_2P(animalID,trialDuration_Sec,specDataFiles,RestingBaselines,neuralDataTypes);

% Normalize spectrogram by baseline
NormalizeSpectrograms_2P(specDataFiles,RestingBaselines,neuralDataTypes);

%% BLOCK PURPOSE [6]
saveFigs = 'y';
GenerateSingleFigures_2P(mergedDataFiles,RestingBaselines,saveFigs)

disp('Two Photon Stage Three Processing - Complete.'); disp(' ')

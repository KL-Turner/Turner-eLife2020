function [EventData] = ExtractEventTriggeredData_2P(mergedDataFiles, dataTypes)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%
% Adapted from code written by Dr. Aaron T. Winder: https://github.com/awinde
%________________________________________________________________________________________________________________________
%
%   Purpose: Separates data corresponding to various behaviors into structures
%________________________________________________________________________________________________________________________
%
%   Inputs: MergedDataFiles - [matrix] names of files organized as rows.
%           dataTypes - [cell] the measurements to be chunked into data epochs
%
%   Outputs:  EventData - [struct] data chunked around behavioral events
%
%   Last Revised: March 21st, 2019
%________________________________________________________________________________________________________________________

EventData = [];
epoch.duration = 14;
epoch.offset = 4;

% Control for dataTypes as string
if not(iscell(dataTypes))
    dataTypes = {dataTypes};
end

for dT = 1:length(dataTypes)
    temp = struct();
    dataType = dataTypes{dT};
    
    for f = 1:size(mergedDataFiles, 1)    
        % Load MergedData File
        filename = mergedDataFiles(f, :);
        load(filename);

        % Get the date and file ID to include in the EventData structure
        [animalID,~,fileDate,fileID,~,vesselID] = GetFileInfo2_2P(mergedDataFiles(f,:));

        % Get the types of behaviors present in the file (stim,whisk,rest)
        holdData = fieldnames(MergedData.flags);
        behaviorFields = holdData([1 2],1);
        
        % Sampling frequency for element of dataTypes
        if strcmp(dataType, 'vesselDiameter')
            Fs = floor(MergedData.notes.p2Fs);
        else
            Fs = floor(MergedData.notes.dsFs);
        end
            % Loop over the behaviors present in the file
            for bF = 1:length(behaviorFields)
                % Create behavioral subfields for the temp structure, if needed
                if not(isfield(temp, behaviorFields{bF}))
                    subFields = fieldnames(MergedData.flags.(behaviorFields{bF}));
                    blankCell = cell(1, size(mergedDataFiles, 1));
                    structVals = cell(size(subFields));
                    structVals(:) = {blankCell};
                    temp.(behaviorFields{bF}) = cell2struct(structVals, subFields, 1)';
                    temp.(behaviorFields{bF}).fileIDs = blankCell;
                    temp.(behaviorFields{bF}).fileDates = blankCell;
                    temp.(behaviorFields{bF}).data = blankCell;
                    temp.(behaviorFields{bF}).vesselIDs = blankCell;
                end

                % Assemble a structure to send to the sub-functions
                data = MergedData.data;
                data.flags = MergedData.flags;
                data.notes = MergedData.notes;

                % Extract the data from the epoch surrounding the event
                disp(['Extracting event-triggered ' dataType ' ' behaviorFields{bF} ' data from file ' num2str(f) ' of ' num2str(size(mergedDataFiles, 1)) '...']); disp(' ');
                [chunkData, evFilter] = ExtractBehavioralData_2P(data, epoch, dataType, Fs, behaviorFields{bF});

                % Add epoch details to temp struct
                [temp] = AddEpochInfo_2P(data, behaviorFields{bF}, temp, fileID, fileDate, vesselID, evFilter, f);
                temp.(behaviorFields{bF}).data{f} = chunkData;
            end 
    end
    % Convert the temporary stuct into a final structure
    [EventData] = ProcessTempStruct_2P(EventData, dataType, temp, epoch);
end
save([animalID '_EventData.mat'], 'EventData');

function [chunkData, evFilter] = ExtractBehavioralData_2P(data, epoch, dataType, Fs, behavior)

% Setup variables
eventTimes = data.flags.(behavior).eventTime;
trialDuration = (data.notes.trialDuration_Sec);

% Get the content from data.(dataType)
data = getfield(data, {}, dataType, {});

% Calculate start/stop times (seconds) for the events
allEpochStarts = eventTimes - epoch.offset*ones(size(eventTimes));
allEpochEnds = allEpochStarts + epoch.duration*ones(size(eventTimes));

% Filter out events which are too close to the beginning or end of trials
startFilter = allEpochStarts > 0;
stopFilter = round(allEpochEnds) < trialDuration; % Apply "round" to give an 
                                              % extra half second buffer 
                                              % and prevent indexing errors
evFilter = logical(startFilter.*stopFilter);
% disp(['ExtractEventTriggeredData > ExtractBehavioralData:' upper(behavior) ': Events at times: ' num2str(eventTimes(not(evFilter))') ' seconds omitted. Too close to beginning/end of trial.']);
% disp(' ');

% Convert the starts from seconds to samples, round down to the nearest
% sample, coerce the value above 1.

epochStarts = max(floor(allEpochStarts(evFilter)*Fs),1);

% Calculate stops indices using the duration of the epoch, this avoids
% potential matrix dimension erros caused by differences in rounding when
% converting from seconds to samples.
sampleDur = round(epoch.duration*Fs);
epochStops = epochStarts + sampleDur*ones(size(epochStarts));

% Extract the chunk of data from the trial
chunkData = zeros(sampleDur + 1, length(epochStarts), size(data, 1));

for eS = 1:length(epochStarts)
    chunkInds = epochStarts(eS):epochStops(eS);
    chunkData(:, eS, :) = data(:, chunkInds)';
end


function [temp] = AddEpochInfo_2P(data, behavior, temp, fileID, fileDate, vesselID, evFilter, f)

% Get the field names for each behavior
fields = fieldnames(data.flags.(behavior));

% Filter out the events which are too close to the trial edge
for flds = 1:length(fields)
    field = fields{flds};
    temp.(behavior).(field){f} = data.flags.(behavior).(field)(evFilter,:)';
end

% Tag each event with the file ID, arrange cell array horizontally for
% later processing.
temp.(behavior).fileIDs{f} = repmat({fileID}, 1, sum(evFilter));
temp.(behavior).fileDates{f} = repmat({fileDate}, 1, sum(evFilter));
temp.(behavior).vesselIDs{f} = repmat({vesselID}, 1, sum(evFilter));


function [EventData] = ProcessTempStruct_2P(EventData, dataType, temp, epoch)

% Get dataType names
behaviorFields = fieldnames(temp);

% Intialize Behavior fields of the dataType sub-structure
structArray2 = cell(size(behaviorFields));
EventData.(dataType) = cell2struct(structArray2, behaviorFields, 1);

for bF = 1:length(behaviorFields)
    behavior = behaviorFields{bF};
    
    % Get Behavior names
    eventFields = fieldnames(temp.(behavior));
    
    % Initialize Event fields for the Behavior sub-structure
    structArray3 = cell(size(eventFields));
    EventData.(dataType).(behavior) = cell2struct(structArray3, eventFields, 1);
    
    for eF = 1:length(eventFields)
        evField = eventFields{eF};
        transferArray = [temp.(behavior).(evField){:}];
        EventData.(dataType).(behavior).(evField) = permute(transferArray, unique([2, 1, ndims(transferArray)], 'stable'));
    end
    EventData.(dataType).(behavior).epoch = epoch;
end

function [DataStruct] = NormBehavioralDataStruct_IOS_Manuscript2020(DataStruct, RestingBaselines, baselineType)
%___________________________________________________________________________________________________
% Edited by Kevin L. Turner
% Ph.D. Candidate, Department of Bioengineering
% The Pennsylvania State University
%
% Originally written by Aaron T. Winder
%
%   Last Revised: October 5th, 2018
%___________________________________________________________________________________________________
%
%   Author: Aaron Winder
%   Affiliation: Engineering Science and Mechanics, Penn State University
%   https://github.com/awinde
%
%   DESCRIPTION: Normalizes measured data by periods of rest.
%
%_______________________________________________________________
%   PARAMETERS:
%                     DataStruct [Structure] - contains the data to be
%                       normalized by the resting baseline. Created using
%                       GetRestingData.m or ExtractEventTriggeredData.m
%_______________________________________________________________
%   RETURN:
%
%_______________________________________________________________

dataTypes = fieldnames(DataStruct);
for dT = 1:length(dataTypes)
    dataType = char(dataTypes(dT));
    if strcmp(dataType, 'CBV_HbT') == false
        hemisphereDataTypes = fieldnames(DataStruct.(dataType));
        
        for hDT = 1:length(hemisphereDataTypes)
            hemDataType = char(hemisphereDataTypes(hDT));
            
            if isfield(DataStruct.(dataType).(hemDataType), 'whisk')
                behaviorFields = fieldnames(DataStruct.(dataType).(hemDataType));
                
                for bF = 1:length(behaviorFields)
                    behField = char(behaviorFields(bF));
                    if ~isempty(DataStruct.(dataType).(hemDataType).(behField).data)
                        NormData = DataStruct.(dataType).(hemDataType).(behField).data;
                        [uniqueDays, ~, ~] = GetUniqueDays_IOS_Manuscript2020(DataStruct.(dataType).(hemDataType).(behField).fileDates);
                        
                        
                        for uD = 1:length(uniqueDays)
                            date = uniqueDays{uD};
                            strDay = ConvertDate_IOS_Manuscript2020(date);
                            [~, dayInds] = GetDayInds_IOS_Manuscript2020(DataStruct.(dataType).(hemDataType).(behField).fileDates, date);
                            
                            disp(['Normalizing ' (hemDataType) ' ' (dataType) ' ' (behField) ' for ' (strDay) '...']); disp(' ')
                            % Calculate the baseline differently depending on data type
                            if iscell(DataStruct.(dataType).(hemDataType).(behField).data)
                                dayData = DataStruct.(dataType).(hemDataType).(behField).data(dayInds);
                                normDayData = cell(size(dayData));
                                dayBaseline = RestingBaselines.(baselineType).(dataType).(hemDataType).(strDay);
                                
                                for dD = 1:size(dayData, 1)
                                    cellBase = dayBaseline*ones(1, size(dayData{dD}, 2));
                                    normDayData{dD} = dayData{dD} ./ cellBase - 1;
                                end
                                NormData(dayInds) = normDayData;
                            else
                                dayBaseline = RestingBaselines.(baselineType).(dataType).(hemDataType).(strDay);
                                % Preallocate array and use for permutation
                                normDayData = DataStruct.(dataType).(hemDataType).(behField).data(dayInds, :, :);
                                
                                % Permute norm_session_data to handle both matrix and array (squeeze
                                % causes a matrix dimension error if not permuted)
                                dayData = permute(normDayData, unique([2, 1, ndims(normDayData)], 'stable'));
                                
                                for dD = 1:size(dayData,2)
                                    normDayData(dD, :, :) = squeeze(dayData(:, dD, :)) ./ (ones(size(dayData, 1), 1)*dayBaseline) - 1;
                                end
                                NormData(dayInds, :, :) = normDayData;
                            end
                            DataStruct.(dataType).(hemDataType).(behField).NormData = NormData;
                        end
                    end
                end
            else
                NormData = DataStruct.(dataType).(hemDataType).data;
                [uniqueDays, ~, ~] = GetUniqueDays_IOS_Manuscript2020(DataStruct.(dataType).(hemDataType).fileDates);
                for uD = 1:length(uniqueDays)
                    date = uniqueDays{uD};
                    strDay = ConvertDate_IOS_Manuscript2020(date);
                    [~, dayInds] = GetDayInds_IOS_Manuscript2020(DataStruct.(dataType).(hemDataType).fileDates, date);
                    
                    disp(['Normalizing ' (hemDataType) ' ' (dataType) ' for ' (strDay) '...']); disp(' ')
                    % Calculate the baseline differently depending on data type
                    if iscell(DataStruct.(dataType).(hemDataType).data)
                        dayData = DataStruct.(dataType).(hemDataType).data(dayInds);
                        normDayData = cell(size(dayData));
                        dayBaseline = RestingBaselines.(baselineType).(dataType).(hemDataType).(strDay);
                        for dD = 1:size(dayData, 1)
                            cellBase = dayBaseline*ones(1, size(dayData{dD}, 2));
                            normDayData{dD} = dayData{dD} ./ cellBase - 1;
                        end
                        NormData(dayInds) = normDayData;
                    else
                        dayBaseline = RestingBaselines.(dataType).(hemDataType).(strDay);
                        % Preallocate array and use for permutation
                        normDayData = DataStruct.(dataType).(hemDataType).data(dayInds, :, :);
                        
                        % Permute norm_session_data to handle both matrix and array (squeeze
                        % causes a matrix dimension error if not permuted)
                        dayData = permute(normDayData, unique([2, 1, ndims(normDayData)], 'stable'));
                        
                        for dD = 1:size(dayData,2)
                            normDayData(dD, :, :) = squeeze(dayData(:, dD, :)) ./ (ones(size(dayData, 1), 1)*dayBaseline) - 1;
                        end
                        NormData(dayInds, :, :) = normDayData;
                    end
                    DataStruct.(dataType).(hemDataType).NormData = NormData;
                end
            end
        end
    end
end

end
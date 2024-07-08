function tableFeatures = extractTableFeatures(tdmsTables, segment_length, overlap)
    % Check if segment_length and overlap are provided, otherwise use default values
    if nargin < 2
        segment_length = 1000;  
    end
    if nargin < 3
        overlap = 500;
    end

    % Initialize an empty table for storing all features
    allFeaturesTable = table();

    % Get names of files in tdmsTables struct
    fields = fieldnames(tdmsTables);

    for i = 1:numel(fields)
        % Each file name from the struct
        fieldName = fields{i};
        % Table is read from struct
        dataTable = tdmsTables.(fieldName).data;
        % Selection of all channels
        signal_columns = dataTable{:, 2:end}; % Assuming data is in numeric format
        % Number of segments are calculated
        num_segments = floor((size(signal_columns, 1) - overlap) / (segment_length - overlap));
        % Labels from struct are read
        fieldSpecs = struct;
        fieldSpecs.torque = tdmsTables.(fieldName).torque; 
        fieldSpecs.speed = tdmsTables.(fieldName).speed;
        fieldSpecs.label = tdmsTables.(fieldName).label; 
        fieldSpecs.damageLabel = tdmsTables.(fieldName).damageLabel;
        fieldSpecs.damageType = tdmsTables.(fieldName).damageType; 
        fieldSpecs.fs = tdmsTables.(fieldName).fs;

        % Loop through each segment and extract features
        for seg = 1:num_segments
            start_idx = (seg-1) * (segment_length - overlap) + 1;
            end_idx = start_idx + segment_length - 1;

            segment = signal_columns(start_idx:end_idx, :);

            timeFeatures = extractTimeFeatures(segment);
            frequencyFeatures = extractFrequencyFeatures(segment, tdmsTables.(fieldName).fs);
            timeFrequencyFeatures = extractTimeFrequencyFeatures(segment, tdmsTables.(fieldName).fs);

            % Prepare a table for the features of the current segment
            timeFeatureTable = struct2table(timeFeatures);
            frequencyFeatureTable = struct2table(frequencyFeatures);
            timeFrequencyFeatureTable = struct2table(timeFrequencyFeatures);

            % Combine all feature tables
            combinedFeatureTable = [timeFeatureTable, frequencyFeatureTable, timeFrequencyFeatureTable];

            % Add field specs to the feature table
            fieldSpecsTable = struct2table(fieldSpecs);
            % Repeat field specs for the number of rows in the feature table
            repeatedFieldSpecsTable = repmat(fieldSpecsTable, size(combinedFeatureTable, 1), 1);

            % Concatenate field specs and features horizontally
            combinedTable = [repeatedFieldSpecsTable, combinedFeatureTable];

            % Append the combined table to the main table
            allFeaturesTable = [allFeaturesTable; combinedTable];
        end
    end

    % Return the final combined table
    tableFeatures = allFeaturesTable;
end

function tableFeatures = extractTableFeatures(tableData, segment_length, overlap, fs)
    % Check if segment_length and overlap are provided, otherwise use default values
    if nargin < 2
        segment_length = 1000;
        fs = 12800;
    end
    if nargin < 3
        overlap = 500;
        fs = 12800;
    end

    % Initialize an empty table for storing all features
    allFeaturesTable = table();

    % Get names of files in tdmsTables struct
    fields = tableData.Properties.VariableNames;

    for i = 3:numel(fields)
        % Each file name from the struct
        fieldName = fields{i};
        %disp(fieldName)
        % % Selection of all channels
        signal_columns = tableData{:, 3:end}; % Assuming data is in numeric format
        % % Number of segments are calculated
        num_segments = floor((size(signal_columns, 1) - overlap) / (segment_length - overlap));
        disp(num_segments)
        
        % % Loop through each segment and extract features
        for seg = 1:num_segments
            start_idx = (seg-1) * (segment_length - overlap) + 1;
            end_idx = start_idx + segment_length - 1;

            segment = signal_columns(start_idx:end_idx, :);

            timeFeatures = extractTimeFeatures(segment);
            frequencyFeatures = extractFrequencyFeatures(segment, fs);
            timeFrequencyFeatures = extractTimeFrequencyFeatures(segment, fs);

            % Prepare a table for the features of the current segment
            timeFeatureTable = struct2table(timeFeatures);
            frequencyFeatureTable = struct2table(frequencyFeatures);
            timeFrequencyFeatureTable = struct2table(timeFrequencyFeatures);

            % Combine all feature tables
            combinedFeatureTable = [timeFeatureTable, frequencyFeatureTable, timeFrequencyFeatureTable];

            % Append the combined table to the main table
            allFeaturesTable = [allFeaturesTable; combinedFeatureTable];
            
        end
    end

    % Return the final combined table
    tableFeatures = allFeaturesTable;
end

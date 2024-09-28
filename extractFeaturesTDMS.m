function [features, featuresTable] = extractFeaturesTDMS(tdmsTables, timeDomain, frequencyDomain, timeFrequencyDomain, segmentLength, overlap, sampleFrequency)
    segment_length = 1000;  
    overlap = 500;
    %sampleFrequency = 1000;
    fs = sampleFrequency;

    fields = fieldnames(tdmsTables);

    for i = 1:numel(fields)
        fieldName = fields{i};
        dataTable = tdmsTables.(fieldName).data;
        signal_columns = dataTable(:, 2:end);
        num_segments = floor((height(signal_columns) - overlap) / (segment_length - overlap));
        fieldSpecs = struct;
        [fieldSpecs.date, fieldSpecs.hour, fieldSpecs.torque, fieldSpecs.velocity] = extractVariables(fieldName);

        features = [];

        %Loop through each segment and extract features
        for seg = 1:num_segments
            start_idx = (seg-1) * (segment_length - overlap) + 1;
            end_idx = start_idx + segment_length - 1;

            segment = signal_columns{start_idx:end_idx, :};

            timeFeatures = extractTimeFeatures(segment);

            frequencyFeatures = extractFrequencyFeatures(segment, sampleFrequency);
            
            timeFrequencyFeatures = extractTimeFrequencyFeatures(segment, sampleFrequency);

            combinedFeatures = struct();
            combinedFeatures.timeFeatures = timeFeatures;
            combinedFeatures.frequencyFeatures = frequencyFeatures;
            combinedFeatures.timeFrequencyFeatures = timeFrequencyFeatures;
            %combinedFeatures.fieldSpecs = fieldSpecs;

            % Append to features array
            features = [features; combinedFeatures];
        end
        
        featuresTable = convertFeaturesStructToTable(features, signal_columns);

    end
end
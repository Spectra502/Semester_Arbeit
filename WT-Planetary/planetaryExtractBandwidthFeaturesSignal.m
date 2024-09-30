function featuresTable = planetaryExtractBandwidthFeaturesSignal(fileStruct, decimateFactor, segment_length, overlap, label, sidebandLength)
    fields = fieldnames(fileStruct);
    featuresTable = [];
    for i=1 : numel(fields)
        fileNames = {fileStruct.(fields{i}).name};
        for j=1 : numel(fileNames)
            % if (j == 3)
            %     break
            % end
            fileName = fileStruct.(fields{i})(j).name;
            folderPath = fileStruct.(fields{i})(j).folder;
            fullfilePath = fullfile(folderPath, fileName);
            speed = extractSpeedFromFilename(fileName);

            data = load(fullfilePath);
            samplingFrequency = data.SampleRate;
            channels = data.Data(:,1:2);
            GMFsun = 28*speed/60;
            GMFplanet = 64*speed/60;
            GMFring = 100*speed/60;
            
            sunFrequencyFeaturesFile = struct2table(planetaryFileBandwidthFrequencyFeatures(channels, samplingFrequency, segment_length, overlap, decimateFactor, GMFsun, sidebandLength, 'sun'));
            planetFrequencyFeaturesFile = struct2table(planetaryFileBandwidthFrequencyFeatures(channels, samplingFrequency, segment_length, overlap, decimateFactor, GMFplanet, sidebandLength, 'planet'));
            ringFrequencyFeaturesFile = struct2table(planetaryFileBandwidthFrequencyFeatures(channels, samplingFrequency, segment_length, overlap, decimateFactor, GMFring, sidebandLength, 'ring'));
            % Prepare speed and label columns
            numRows = height(sunFrequencyFeaturesFile);  % Get the number of rows in the features table
            speedCol = repmat(speed, numRows, 1);  % Replicate the speed value for all rows
            label_name = label + "_" + i;
            labelCol = repmat(label_name, numRows, 1);  % Replicate the label for all rows
            
            % Convert speedCol and labelCol to tables
            speedTable = array2table(speedCol, 'VariableNames', {'Speed'});
            labelTable = array2table(labelCol, 'VariableNames', {'Label'});
            
            % Concatenate all tables (speed, label, time features, frequency features)
            combinedTable = [labelTable, speedTable, sunFrequencyFeaturesFile, planetFrequencyFeaturesFile, ringFrequencyFeaturesFile];

            % Append the new combinedTable to featuresTable
            if isempty(featuresTable)
                featuresTable = combinedTable;  % If it's the first iteration, initialize featuresTable
            else
                featuresTable = [featuresTable; combinedTable];  % Vertically concatenate the tables
            end
        end
    end
end
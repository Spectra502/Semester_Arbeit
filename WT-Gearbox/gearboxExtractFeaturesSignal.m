function featuresTable = gearboxExtractFeaturesSignal(fileStruct, folderPath, decimateFactor, segment_length, overlap)
    featuresTable = [];
    for i=1 : length(fileStruct)
        
        fullfilePath = fullfile(folderPath, fileStruct{i});
        [label, rpm, Nm] = gearbox_extract_labels_from_filename(fileStruct{i});
        dataTable = readtable(fullfilePath);
        channels_1 = table2array(dataTable(128000:256000, 3:8));
        channels_2 = table2array(dataTable(320000:448000, 3:8));
        channels_3 = table2array(dataTable(512000:640000, 3:8));
        columnNames = dataTable.Properties.VariableNames;
        channelNames = string(columnNames(3:8));
        sampleFrequency = 12800;

        timeFeaturesFile_1 = struct2table(gearboxFileTimeFeatures(channels_1, segment_length, overlap, decimateFactor, channelNames));
        %timeFeaturesFile_2 = struct2table(gearboxFileTimeFeatures(channels_2, segment_length, overlap, decimateFactor, channelNames));
        timeFeaturesFile_3 = struct2table(gearboxFileTimeFeatures(channels_3, segment_length, overlap, decimateFactor, channelNames));
        timeFrequencyFeaturesFile_1 = struct2table(gearboxFileTimeFrequencyFeatures(channels_1, sampleFrequency, segment_length, overlap, decimateFactor, channelNames));
        timeFrequencyFeaturesFile_3 = struct2table(gearboxFileTimeFrequencyFeatures(channels_3, sampleFrequency, segment_length, overlap, decimateFactor, channelNames));
        frequencyFeaturesFile_1 = struct2table(gearboxFileFrequencyFeatures(channels_1, sampleFrequency, segment_length, overlap, decimateFactor, channelNames));
        frequencyFeaturesFile_3 = struct2table(gearboxFileFrequencyFeatures(channels_3, sampleFrequency, segment_length, overlap, decimateFactor, channelNames));


        timeTableCombined = vertcat(timeFeaturesFile_1, timeFeaturesFile_3);
        timeFrequencyTableCombined = vertcat(timeFrequencyFeaturesFile_1, timeFrequencyFeaturesFile_3);
        frequencyTableCombined = vertcat(frequencyFeaturesFile_1, frequencyFeaturesFile_3);

        % Prepare speed and label columns
        numRows = height(timeTableCombined);  % Get the number of rows in the features table
        rpmCol = repmat(rpm, numRows, 1);  % Replicate the speed value for all rows
        NmCol = repmat(Nm, numRows, 1);
        labelCol = repmat(label, numRows, 1);  % Replicate the label for all rows
        labelCol = cellstr(labelCol);
        
        % Convert speedCol and labelCol to tables
        speedTable = array2table(rpmCol, 'VariableNames', {'rpm'});
        NmTable = array2table(NmCol, 'VariableNames', {'Nm'});
        labelTable = array2table(labelCol, 'VariableNames', {'Label'});


        
        % Concatenate all tables (speed, label, time features, frequency features)
        combinedTable = [labelTable, speedTable, NmTable, timeTableCombined, timeFrequencyTableCombined, frequencyTableCombined];

        % Append the new combinedTable to featuresTable
        if isempty(featuresTable)
            featuresTable = combinedTable;  % If it's the first iteration, initialize featuresTable
        else
            featuresTable = [featuresTable; combinedTable];  % Vertically concatenate the tables
        end
    end
end
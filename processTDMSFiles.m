function tdmsTables = processTDMSFiles(fileList, folderPath, percentageToKeep)
    percentageToKeep = 100;

    %creates dictionary to store the data with the corresponding labels
    tdmsTables = struct();
    
    %calculates how many rows are going to be kept
    function numRowsToKeep = calculateRowsToKeep(dataTable, percentageToKeep)
        numRows = height(dataTable);
        numRowsToKeep = round(numRows * (percentageToKeep / 100));
    end
    
    % function label = findLabel(folderPath)
    %     if contains(folderPath, 'healthy', 'IgnoreCase', true)
    %         label = 'healthy';
    %     elseif contains(folderPath,'damaged', 'IgnoreCase', true)
    %         label = 'damaged';
    %     else
    %         label = '';
    %     end
    % end
    % 
    % label = findLabel(folderPath);

    for i = 1:length(fileList)
        [label, torque, speed, damageLabel, damageType] = extractVariables(fileList{i});

        fullFilePath = fullfile(folderPath, label, fileList{i});
        %disp(fullFilePath)
        
        data = tdmsread(fullFilePath);
        dataTable = data{1};

        numRowsToKeep = calculateRowsToKeep(dataTable, percentageToKeep);
        
        if numRowsToKeep > 0
            sampledData = dataTable(1:numRowsToKeep,:);
        else
            sampledData = dataTable;
        end

        sampledData = sampledData(~all(ismissing(sampledData), 2), :);
        
        if ismember('Time', sampledData.Properties.VariableNames)
            sampledData.Time = datetime(sampledData.Time, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        end

        [~, fileName, ~] = fileparts(fullFilePath);
        
        validFieldName = matlab.lang.makeValidName(fileName);
        
        
        %[date, hour, torque, velocity] = extractVariables(fileName);

        tdmsTables.(validFieldName).data = sampledData;
        tdmsTables.(validFieldName).label = label;
        tdmsTables.(validFieldName).torque = torque;
        tdmsTables.(validFieldName).speed = speed;
        tdmsTables.(validFieldName).damageLabel = damageLabel;
        tdmsTables.(validFieldName).damageType = damageType;

    end

end
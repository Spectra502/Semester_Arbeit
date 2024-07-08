function [tdmsTables] = processTDMSFiles(fileList, folderPath, percentageToKeep)
    tdmsTables = struct();

    function numRowsToKeep = calculateRowsToKeep(dataTable, percentageToKeep)
        numRows = height(dataTable);
        numRowsToKeep = round(numRows * (percentageToKeep / 100));
    end

    function label = findLabel(folderPath)
        if contains(folderPath, 'healthy', 'IgnoreCase', true)
            label = 'healthy';
        elseif contains(folderPath,'damaged', 'IgnoreCase', true)
            label = 'damaged';
        else
            label = '';
        end
    end
    
    label = findLabel(folderPath);

    for i = 1:length(fileList)
        fullFilePath = fullfile(folderPath, fileList{i});
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
        
        [date, hour, torque, velocity] = extractVariables(fileName);

        tdmsTables.(validFieldName).data = sampledData;
        tdmsTables.(validFieldName).velocity = label;
        tdmsTables.(validFieldName).date = date;
        tdmsTables.(validFieldName).hour = hour;
        tdmsTables.(validFieldName).torque = torque;
        tdmsTables.(validFieldName).velocity = velocity;

    end

end
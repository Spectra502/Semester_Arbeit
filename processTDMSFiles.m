function tdmsTables = processTDMSFiles(fileList, folderPath, decimateFactor)
    % Set a default value for decimateFactor if not provided
    if nargin < 3
        decimateFactor = 1;
    end

    % Creates a dictionary to store the data with the corresponding labels
    tdmsTables = struct();

    for i = 1:length(fileList)
        [label, torque, speed, damageLabel, damageType] = extractVariables(fileList{i});

        fullFilePath = fullfile(folderPath, label, fileList{i});
        % disp(fullFilePath)
        
        data = tdmsread(fullFilePath);
        dataTable = data{1};

        if decimateFactor > 1
            % Initialize a new table for the decimated data
            sampledData = dataTable(1:decimateFactor:end, :);
            % Decimate each column except for the Time column
            for col = 2:width(dataTable)
                sampledData{:, col} = decimate(dataTable{:, col}, decimateFactor);
            end
            % % Decimate the Time column appropriately
            % if ismember('Time', dataTable.Properties.VariableNames)
            %     sampledData.Time = dataTable.Time(1:decimateFactor:end);
            % else
            %     % If there's no Time column, create a placeholder or skip
            %     warning('No Time column found for decimation.');
            % end
            % % Ensure all columns are of the same length
            % minLength = min(cellfun(@length, table2cell(sampledData)));
            % sampledData = sampledData(1:minLength, :);
        else
            sampledData = dataTable;
        end

        % Remove rows where all elements are missing
        %sampledData = sampledData(~all(ismissing(sampledData), 2), :);
        
        % Convert the Time column to datetime if it exists
        % if ismember('Time', sampledData.Properties.VariableNames)
        %     sampledData.Time = datetime(sampledData.Time, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        % end

        [~, fileName, ~] = fileparts(fullFilePath);
        
        validFieldName = matlab.lang.makeValidName(fileName);
        
        tdmsTables.(validFieldName).data = sampledData;
        tdmsTables.(validFieldName).label = label;
        tdmsTables.(validFieldName).torque = torque;
        tdmsTables.(validFieldName).speed = speed;
        tdmsTables.(validFieldName).damageLabel = damageLabel;
        tdmsTables.(validFieldName).damageType = damageType;
    end
end

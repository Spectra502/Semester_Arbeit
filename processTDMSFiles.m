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
            
        else
            sampledData = dataTable;
        end

        [~, fileName, ~] = fileparts(fullFilePath);
        
        %creates a valid name for struct
        validFieldName = matlab.lang.makeValidName(fileName);
        
        tdmsTables.(validFieldName).data = sampledData;
        tdmsTables.(validFieldName).label = label;
        tdmsTables.(validFieldName).torque = torque;
        tdmsTables.(validFieldName).speed = speed;
        tdmsTables.(validFieldName).damageLabel = damageLabel;
        tdmsTables.(validFieldName).damageType = damageType;

        if decimateFactor == 1
            tdmsTables.(validFieldName).fs = 100000;
        else
            tdmsTables.(validFieldName).fs = 100000/decimateFactor;
        end
    end
end

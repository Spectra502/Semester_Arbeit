function exportFeaturesCSV(folderPath, fileName, targetPath, segment_length, overlap, fs)
    fullFilePath = fullfile(folderPath, fileName);
    disp(fileName);
    [rpm, Nm, label] = extractFileInfo(fileName);

    dataTable = readtable(fullfile(folderPath, fileName));
    
    extractedFeaturesTable = extractTableFeatures(dataTable, segment_length, overlap, fs);
    %extractedFeaturesTable = table([1; 2; 3], {'A'; 'B'; 'C'}, 'VariableNames', {'ID', 'Name'});

    heightFeatures = height(extractedFeaturesTable);
    
    labelCol = repmat(label, heightFeatures,1);
    rpmCol = repmat(rpm, heightFeatures,1);
    torqueCol = repmat(Nm, heightFeatures,1);
    tableInfo = table(labelCol, rpmCol, torqueCol, 'VariableNames', {'label', 'rpm', 'Nm'});

    combinedTable = [tableInfo, extractedFeaturesTable];

    % Create the full file path
    fullPath = fullfile(targetPath, [label,'_', num2str(rpm),'rpm','_', num2str(Nm),'Nm_',num2str(fs),'Hz', '.csv']);
    
    % Write the table to a CSV file
    try
        writetable(combinedTable, fullPath);
        disp(['Table successfully exported to ', fullPath]);
    catch ME
        disp(['Error exporting table: ', ME.message]);
    end
    
end
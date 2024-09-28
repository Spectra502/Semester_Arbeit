function [tdmsTable, channel_selection] = readTdmsFile(folderPath, fileName, channel_selection)
    %reads tdms file and converts it into a table
    fullFilePath = fullfile(folderPath, fileName);
    data = tdmsread(fullFilePath);
    table = data{1};
    clean_table = removevars(table,'Time');
    tdmsTable = clean_table(:, channel_selection);
end
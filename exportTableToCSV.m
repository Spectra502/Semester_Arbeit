function exportTableToCSV(tbl)
    % Check if the input is a table
    if ~istable(tbl)
        error('Input must be a table.');
    end
    
    % Prompt user to select a folder
    targetFolder = uigetdir;
    if targetFolder == 0
        disp('No folder selected. Operation cancelled.');
        return;
    end
    
    % Ask for the CSV file name
    prompt = {'Enter the name of the CSV file (without extension):'};
    dlgtitle = 'CSV File Name';
    dims = [1 50];
    definput = {'exported_table'};
    answer = inputdlg(prompt, dlgtitle, dims, definput);
    
    if isempty(answer)
        disp('No file name entered. Operation cancelled.');
        return;
    end
    
    fileName = answer{1};
    
    % Create the full file path
    fullPath = fullfile(targetFolder, [fileName, '.csv']);
    
    % Write the table to a CSV file
    try
        writetable(tbl, fullPath);
        disp(['Table successfully exported to ', fullPath]);
    catch ME
        disp(['Error exporting table: ', ME.message]);
    end
end

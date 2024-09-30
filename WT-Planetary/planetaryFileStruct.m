function [fileStruct, label] = planetaryFileStruct()
    % Prompt user to select the folder
    folderPath = uigetdir('Select Folder');
    [~, folderName, ~] = fileparts(folderPath);
    label = folderName;
    
    % If no folder selected, return an empty struct
    if folderPath == 0
        disp('No folder selected.');
        fileStruct = struct();
        return;
    end
    
    % Initialize a struct to store file information
    fileStruct = struct();
    
    % Define the directories (you can extend this if you have more numbered directories)
    dirNames = {'1', '2'};
    
    % Loop through the directories
    for i = 1:length(dirNames)
        dirPath = fullfile(folderPath, dirNames{i});
        
        % Check if the directory exists
        if isfolder(dirPath)
            % Get files and filter out directories
            files = dir(dirPath);
            files = files(~[files.isdir]);
            
            % Store files in the struct
            fileStruct.(sprintf('dir%s_files', dirNames{i})) = files;

        else
            % Handle non-existent directory
            warning('Directory %s does not exist.', dirNames{i});
            fileStruct.(sprintf('dir%s_files', dirNames{i})) = [];
        end
    end
end

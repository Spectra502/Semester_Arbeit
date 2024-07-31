function [fileStruct, folderPathStruct] = selectFolderAndListFiles()
    %Open windows file explorer and choose folder containing the following
    %folders: healthy & damaged
    msgbox('Please select the folder containing the "healthy" and "damaged" folders', 'Folder Selection');
    uiwait(msgbox('Please select the folder containing the "healthy" and "damaged" folders', 'Folder Selection'));

    %Select folder
    folderPath = uigetdir('Select Folder');

    %Check if no folder is selected
    if folderPath == 0
        disp('No folder selected');
        fileStruct.healthy = [];
        fileStruct.damaged = [];
        folderPathStruct.healthy = '';
        folderPathStruct.damaged = struct();
        return
    end

    fileStruct.healthy = {};
    fileStruct.damaged = {};
    folderPathStruct.healthy = fullfile(folderPath, 'healthy');
    folderPathStruct.damaged = struct();

    %Define paths for subfolders
    healthyFolderPath = fullfile(folderPath, 'healthy');
    damagedFolderPath = fullfile(folderPath, 'damaged');

    if isfolder(healthyFolderPath)
        healthyFiles = dir(fullfile(healthyFolderPath, '*.tdms'));
        fileStruct.healthy = {healthyFiles.name};
    else
        disp('No "healthy" subfolder found.')
    end

    if isfolder(damagedFolderPath)
        % damagedFiles = dir(fullfile(damagedFolderPath, '*.tdms'));
        % fileStruct.damaged = {damagedFiles.name};
        subfolders = dir(damagedFolderPath);
        subfolders = subfolders([subfolders.isdir] & ~ismember({subfolders.name}, {'.', '..'}));

        for k=1:length(subfolders)
            subfolderName = subfolders(k).name;
            subfolderPath = fullfile(damagedFolderPath, subfolderName);
            tdmsFiles = dir(fullfile(subfolderPath, '*.tdms'));
            fileStruct.damaged.(subfolderName) = {tdmsFiles.name}
            folderPathStruct.damaged.(subfolderName) = subfolderPath;
        end
    else
        disp('No "damaged" subfolder found');
    end

end
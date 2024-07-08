function [fileStruct, folderPath] = selectFolderAndListFiles()
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
        return
    end

    fileStruct.healthy = {};
    fileStruct.damaged = {};

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
        damagedFiles = dir(fullfile(damagedFolderPath, '*.tdms'));
        fileStruct.damaged = {damagedFiles.name};
    else
        disp('No "damaged" subfolder found');
    end

end
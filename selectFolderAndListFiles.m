function [fileList, folderPath] = selectFolderAndListFiles()
    msgbox('Please select a folder to list all files within it.', 'Folder Selection');
    uiwait(msgbox('Please select a folder to list all files within it.', 'Folder Selection'));
    folderPath = uigetdir('Select folder');

    if folderPath == 0
        disp('No folder selected');
        fileList = [];
        return
    end

    %files = dir(folderPath);
    %fileList = {files(~[files.isdir]).name};
    files = dir(fullfile(folderPath, '*.tdms'));
    fileList = {files.name};

    disp('Files in selected folder:');
    disp(fileList)

end
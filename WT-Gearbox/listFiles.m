function fileStruct = listFiles(folderPath)
    %folderPath = uigetdir('Select folder')
    fileList = dir(fullfile(folderPath, '*.csv'));
    fileStruct = {fileList.name};
end
function [fileStruct, folderPath] = gearboxFileStruct()
    folderPath = uigetdir();
    fileList = dir(fullfile(folderPath, '*.csv'));
    fileStruct = {fileList.name};
end

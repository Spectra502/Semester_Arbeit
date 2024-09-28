function fileStruct = selectFiles()
    %Select folder of data
    msgbox('Please select the folder containing the desired files', 'Folder Selection');
    uiwait(msgbox('Please select the folder containing the desired files', 'Folder Selection'));

    %Select folder
    folderPath = uigetdir('Select Folder');

    %Check if no folder is selected
    if folderPath == 0
        disp('No folder selected');
        fileStruct = [];
        return
    end

    if isfolder(folderPath)
        fileStruct = {};
        fileStruct.folderPath = folderPath;
        [~,folderName,~]= fileparts(folderPath);
        fileStruct.folderName = folderName;
        files = dir(fullfile(folderPath, '*.tdms'));
        fileStruct.files = {files.name}
        disp(folderName);
    else
        disp("No folder found")
    end

end
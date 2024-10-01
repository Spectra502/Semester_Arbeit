function extractFeaturesFolder(folderPath, fileStruct, targetPath, segment_length, overlap, fs)
    for i=182:length(fileStruct)
        fileName = fileStruct{i};
        
        if contains(fileName, 'speed')
            disp(fileStruct{i})
            exportFeaturesCSV(folderPath, fileStruct{i}, targetPath, segment_length, overlap, fs)
        end
        disp([num2str(i),' of ', num2str(length(fileStruct))])
    end
end
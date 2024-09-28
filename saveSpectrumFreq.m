function saveSpectrumFreq(tdmsStruct, folderPath)
    fields = fieldnames(tdmsStruct);
    for i=1:length(fields)
        %disp(tdmsStruct.(fields{i}));
        label = tdmsStruct.(fields{i}).label;
        torque = tdmsStruct.(fields{i}).torque;
        speed = tdmsStruct.(fields{i}).speed;
        % if any(isnan(torque))
        %     torque= 0;
        % end
        % if any(isnan(speed))
        %     speed = 0;
        % end
        dataTable = tdmsStruct.(fields{i}).data;
        %% 
        for j = 2:width(dataTable)
            signal = dataTable.(j);
            plotSpectrumFreq(signal, folderPath, label, torque, speed, j,i);
        end
    end
end
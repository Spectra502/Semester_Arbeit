function channelStruct = extractChannels(tdmsTable)
    channelStruct = struct();
    fields = fieldnames(tdmsTable);
    %disp(length(fields))
    for i=1:length(fields)
        label = tdmsTable.(fields{i}).label;
        torque = tdmsTable.(fields{i}).torque;
        fs = tdmsTable.(fields{i}).fs;
        speed = tdmsTable.(fields{i}).speed;
        for k=2:width(tdmsTable.(fields{i}).data)
            keyName = sprintf('ch_%i_%s_%i_Nm_%i_rpm_%i_Hz', k-1, label, torque, speed, fs);
            channelStruct.(keyName) = tdmsTable.(fields{i}).data.(k);
        end
    end
end

% function channelStruct = extractChannels(tdmsTable)
%     channelStruct = struct();
%     fields = fieldnames(tdmsTable);
% 
%     for i = 1:length(fields)
%         label = tdmsTable.(fields{i}).label;
%         torque = tdmsTable.(fields{i}).torque;
%         fs = tdmsTable.(fields{i}).fs;
%         speed = tdmsTable.(fields{i}).speed;
% 
%         dataWidth = size(tdmsTable.(fields{i}).data, 2);
%         for k = 2:dataWidth
%             keyName = sprintf('ch_%i_%s_%i_Nm_%i_rpm_%i_Hz', k-1, label, torque, speed, fs);
%             channelStruct.(keyName) = 2;
%         end
%     end
% end

function exportChannels(channelStruct)
    for i = 1:length(fields)
        key = fields{i};
        value = channelStruct.(key);
        assignin('base', key, value);
    end
end
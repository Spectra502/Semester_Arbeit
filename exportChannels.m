function exportChannels(channelStruct)
    channelFields = fieldnames(channelStruct)
    for i = 1:length(channelFields)
        key = channelFields{i};
        value = channelStruct.(key);
        assignin('base', key, value);
    end
end
function timeFeaturesFile = gearboxFileTimeFeatures(signal_channels, segment_length, overlap, decimateFactor, channelDescription)
    % If the signal needs to be decimated, apply decimation
    if decimateFactor > 1
        signal_channels = decimateSignal(signal_channels, decimateFactor);
    end
    
    % Define constants and initialize variables
    [numRows, numCols] = size(signal_channels);
    num_segments = floor((numRows - overlap) / (segment_length - overlap));

    % Initialize the output file to hold all features
    timeFeaturesFile = [];

    % Loop through each segment and extract features
    parfor seg = 1:num_segments
        % Define the start and end index for the current segment
        start_idx = (seg-1) * (segment_length - overlap) + 1;
        end_idx = start_idx + segment_length - 1;
        
        % Ensure we don't exceed the length of the signal
        if end_idx > numRows
            end_idx = numRows;  % Adjust the end index if it's out of bounds
        end

        % Extract the current segment
        segment = signal_channels(start_idx:end_idx, :);
        
        % Extract time-domain features from the segment
        timeFeatures = extractTimeFeatures(segment, channelDescription);
        
        % Append the features to timeFeaturesFile
        timeFeaturesFile = [timeFeaturesFile; timeFeatures];  
    end
end
function bandwidthFrequencyFeaturesFile = planetaryFileBandwidthFrequencyFeatures(signal_channels, sampleFrequency, segment_length, overlap, decimateFactor, frequency, sideband_length, label)
    % If the signal needs to be decimated, apply decimation
    if decimateFactor > 1
        signal_channels = decimateSignal(signal_channels, decimateFactor);
    end
    
    % Define constants and initialize variables
    [numRows, numCols] = size(signal_channels);
    num_segments = floor((numRows - overlap) / (segment_length - overlap));

    % Initialize the output file to hold all features
    bandwidthFrequencyFeaturesFile = [];

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
        
        % Extract frequency-domain features from the segment and frequency
        % specific
        bandwidthFrequencyFeatures = extractBandwidthFrequencyFeatures(segment, sampleFrequency, frequency, sideband_length, [1:2], label)
        
        % Append the features to timeFeaturesFile
        bandwidthFrequencyFeaturesFile = [bandwidthFrequencyFeaturesFile; bandwidthFrequencyFeatures];  
    end
end
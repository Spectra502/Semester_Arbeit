function decimatedSignal = decimateSignal(signal_channels, decimateFactor)
    [numRows, numCols] = size(signal_channels);  % Get the size of the input matrix
          
    % Loop through each column and apply the decimation
    for col = 1:numCols
        decimatedSignal(:, col) = decimate(signal_channels(:, col), decimateFactor);
    end
end

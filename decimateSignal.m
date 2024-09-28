function decimated_signal = decimateSignal(signal, decimateFactor)
    [numRows, numCols] = size(signal);  % Get the size of the input matrix
    
    % Initialize the decimated signal matrix
    decimated_signal = zeros(floor(numRows / decimateFactor), numCols);
    
    % Loop through each column and apply the decimation
    for col = 1:numCols
        decimated_signal(:, col) = decimate(signal(:, col), decimateFactor);
    end
end

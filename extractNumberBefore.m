function numberStr = extractNumberBefore(filename, index)
    % This helper function extracts the number before the specified index
    % 'index' is the starting point of 'Nm' or 'rpm'
    
    % Extract the part of the filename before the keyword (either 'Nm' or 'rpm')
    subStr = filename(1:index-2);
    %disp(subStr);

    % Find the last underscore before the keyword
    lastUnderscore = find(subStr == '_', 1, 'last');
    %disp(lastUnderscore);

    if isempty(lastUnderscore)
        % If no underscore is found, assume the number starts at the beginning
        numberStr = subStr;
    else
        % Extract the substring after the last underscore
        numberStr = subStr(lastUnderscore+1:end);
    end
end
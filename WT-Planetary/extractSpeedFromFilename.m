function speed = extractSpeedFromFilename(filename)
    % Use regular expression to find two digits before .MAT
    expr = '(\d{2})\.MAT';  % Regular expression to match two digits before .MAT
    tokens = regexp(filename, expr, 'tokens');
    
    % Check if the match was successful
    if ~isempty(tokens)
        number = str2double(tokens{1}{1});  % Convert the string to a number
        speed = number * 60;
    else
        error('No two digits found before .MAT');
    end
end
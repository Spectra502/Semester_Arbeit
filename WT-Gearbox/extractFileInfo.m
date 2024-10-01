function [speed, torque, damageType] = extractFileInfo(filename)
    % Define the pattern to extract information
    pattern = '(\w+?)_circulation_(\d+)Nm-(\d+)rpm';
    
    % Use regexp to match the pattern and extract tokens
    tokens = regexp(filename, pattern, 'tokens');
    
    if ~isempty(tokens)
        tokens = tokens{1};  % Extract the first match (cell array of tokens)
        
        % Assign values to variables
        damageType = tokens{1};    % Damage type (e.g., "gear_wear", "health", "miss_teeth")
        torque = str2double(tokens{2}); % Torque value in Nm
        speed = str2double(tokens{3});  % Speed value in rpm
    else
        % Handle case where pattern doesn't match (if needed)
        error('Filename does not match the expected pattern.');
    end
end

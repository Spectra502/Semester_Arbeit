function [label, rpm, torque] = gearbox_extract_labels_from_filename(filename)
    % Initialize outputs
    label = '';
    rpm = '';
    torque = '';
    
    % Check if the filename contains 'torque' or 'speed'
    if contains(filename, 'torque')
        % For filenames with 'torque', extract everything before 'rpm' as label
        % Extract label (before last '_rpm'), RPM (before 'rpm'), and torque (before 'Nm')
        pattern = '(?<label>.*)_torque_circulation_(?<rpm>\d+)rpm_(?<torque>\d+)Nm';
        tokens = regexp(filename, pattern, 'names');
        
        % Assign to outputs
        if ~isempty(tokens)
            label = tokens.label;
            rpm = str2double(tokens.rpm);
            torque = str2double(tokens.torque);
        end
    elseif contains(filename, 'speed')
        % For filenames with 'speed', extract everything before '_Nm' as label
        % Extract label (before '_Nm'), RPM (after '-'), and torque (before 'Nm')
        pattern = '(?<label>.*)_speed_circulation_(?<torque>\d+)Nm-(?<rpm>\d+)rpm';
        tokens = regexp(filename, pattern, 'names');
        
        % Assign to outputs
        if ~isempty(tokens)
            label = tokens.label;
            rpm = str2double(tokens.rpm);
            torque = str2double(tokens.torque);
        end
    else
        disp('Filename does not match known patterns for torque or speed.');
    end
end

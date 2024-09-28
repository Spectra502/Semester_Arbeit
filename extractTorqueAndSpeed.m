function [torque, speed] = extractTorqueAndSpeed(filename)
    % This function extracts torque (Nm) and speed (rpm) from a given filename
    % The function assumes that torque is followed by 'Nm' and speed by 'rpm'

    % Find the position of 'Nm' and 'rpm' in the filename
    NmIndex = strfind(filename, 'Nm');
    rpmIndex = strfind(filename, 'rpm');

    % Initialize variables for torque and speed
    torque = [];
    speed = [];

    % If 'Nm' is found, extract the torque value
    if ~isempty(NmIndex)
        % Find the preceding number
        torqueStr = extractNumberBefore(filename, NmIndex);
        torque = str2double(torqueStr);
    end

    % If 'rpm' is found, extract the speed value
    if ~isempty(rpmIndex)
        % Find the preceding number
        speedStr = extractNumberBefore(filename, rpmIndex);
        speed = str2double(speedStr);
    end

    % Display the extracted values (for debugging purposes)
    %disp(['Extracted Torque: ', num2str(torque), ' Nm']);
    %disp(['Extracted Speed: ', num2str(speed), ' rpm']);
end



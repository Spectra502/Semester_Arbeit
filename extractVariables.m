function [date, hour, torque, velocity] = extractVariables(inputString)
    date = inputString(1:8);
    hour = inputString(10:17);
    torque = extractBetween(inputString, '112_5_', '_Nm');
    velocity = extractBetween(inputString, '_Nm_', '_rpm');
end
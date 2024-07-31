function [label, torque, speed, damageLabel, damageType] = extractVariables(inputString)

    % Determine the label based on the presence of "GF"
    if contains(inputString, 'GF') || contains(inputString,'Gf')
        label = 'damaged';
        damageLabel = 1;
        damageType = 'micropitting';
    elseif contains(inputString, 'SIZA')
        label = 'damaged';
        damageLabel = 2;
        damageType = 'siza'
    else
        label = 'healthy';
        damageLabel = 0;
        damageType = 'none';
    end

   pattern = '-112_5_';
   length(pattern);
   startIndex = strfind(inputString, pattern);

   if ~isempty(startIndex)
       startIndex = startIndex + length(pattern);
       remainderString = inputString(startIndex:end);

       numPattern = '(\d+)';
       tokens = regexp(remainderString, numPattern, 'tokens');

       % Debug: Print the remainder string and tokens
        %disp('Remainder String:');
        %disp(remainderString);
        %disp('Tokens:');
        %disp(tokens);

        if length(tokens) >= 2
            torque = str2double(tokens{1});
            speed = str2double(tokens{2});
        else
            torque = NaN;
            speed = NaN;
        end
    else
        torque = NaN;
        speed = NaN;
        tokens = {};
    end

end

% 
% function [label, torque, speed, damageLabel, damageType] = extractVariables(inputString)
% 
%     % Determine the label based on the presence of "GF" or "SIZA"
%     if contains(inputString, 'GF') || contains(inputString,'Gf')
%         label = 'damaged';
%         damageLabel = 1;
%         damageType = 'micropitting';
%     elseif contains(inputString, 'SIZA')
%         label = '2';
%         damageLabel = 2;
%         damageType = 'siza';
%     else
%         label = 'healthy';
%         damageLabel = 0;
%         damageType = 'none';
%     end
% 
%     % Pattern to find the torque and speed in the input string
%     pattern = '-112_5_';
%     startIndex = strfind(inputString, pattern);
% 
%     if ~isempty(startIndex)
%         startIndex = startIndex + length(pattern);
%         remainderString = inputString(startIndex:end);
% 
%         % Pattern to match numeric values (for torque and speed)
%         numPattern = '(\d+)_Nm_(\d+)_rpm';
%         tokens = regexp(remainderString, numPattern, 'tokens');
% 
%         if ~isempty(tokens)
%             torque = str2double(tokens{1}{1});
%             speed = str2double(tokens{1}{2});
%         else
%             torque = NaN;
%             speed = NaN;
%         end
%     else
%         torque = NaN;
%         speed = NaN;
%     end
% end

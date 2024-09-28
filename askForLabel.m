function label = askForLabel(folderName)
    % This function displays a message and asks the user to confirm or enter a label
    message = "Is '" + folderName + "' an appropriate label?";
    prompt = "If it is, leave it blank. Otherwise, enter a new label:";

    % Display message to the user
    uiwait(msgbox(message, 'Input Request'));

    % Ask for user input (label)
    answer = inputdlg(prompt, 'Enter Label', [1 50]);

    % Check if user provided input or left it blank
    if isempty(answer) || isempty(answer{1})
        % No input or blank input, use the folder name as the label
        label = folderName;
    else
        % Use the user-provided label
        label = answer{1};
    end

    % Display the final label
    %disp(['The final label is: ', label]);
end

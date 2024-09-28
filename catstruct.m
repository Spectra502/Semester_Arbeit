function s = catstruct(varargin)
    s = struct();
    for i = 1:length(varargin)
        fields = fieldnames(varargin{i});
        for j = 1:length(fields)
            s.(fields{j}) = varargin{i}.(fields{j});
        end
    end
end

function timeFeatures = extractTimeFeatures(segment)
    timeFeatures = struct;
    for col = 1:size(segment, 2)
        timeFeatures.(['mean_val_ch' num2str(col)]) = mean(segment(:, col));
        timeFeatures.(['rms_val_ch' num2str(col)]) = rms(segment(:, col));
        timeFeatures.(['std_dev_ch' num2str(col)]) = std(segment(:, col));
        timeFeatures.(['skewness_val_ch' num2str(col)]) = skewness(segment(:, col));
        timeFeatures.(['kurtosis_val_ch' num2str(col)]) = kurtosis(segment(:, col));
        timeFeatures.(['peak_to_peak_val_ch' num2str(col)]) = peak2peak(segment(:, col));
        timeFeatures.(['crest_factor_ch' num2str(col)]) = max(abs(segment(:, col))) / rms(segment(:, col));
        timeFeatures.(['impulse_factor_ch' num2str(col)]) = max(abs(segment(:, col))) / mean(abs(segment(:, col)));
        timeFeatures.(['clearance_factor_ch' num2str(col)]) = max(abs(segment(:, col))) / mean(sqrt(abs(segment(:, col))));
        timeFeatures.(['shape_factor_ch' num2str(col)]) = rms(segment(:, col)) / mean(abs(segment(:, col)));
        timeFeatures.(['energy_val_ch' num2str(col)]) = sum(segment(:, col).^2);
        timeFeatures.(['entropy_val_ch' num2str(col)]) = wentropy(segment(:, col), 'shannon');
    end
end
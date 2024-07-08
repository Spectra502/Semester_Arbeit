function timeFeatures = extractTimeFeatures(segment)
    timeFeatures = struct;
    timeFeatures.mean_val = mean(segment);
    timeFeatures.rms_val = rms(segment);
    timeFeatures.std_dev = std(segment);
    timeFeatures.skewness_val = skewness(segment);
    timeFeatures.kurtosis_val = kurtosis(segment);
    timeFeatures.peak_to_peak_val = peak2peak(segment);
    timeFeatures.crest_factor = max(abs(segment)) ./ timeFeatures.rms_val;
    timeFeatures.impulse_factor = max(abs(segment)) ./ mean(abs(segment));
    timeFeatures.clearance_factor = max(abs(segment)) ./ mean(sqrt(abs(segment)));
    timeFeatures.shape_factor = timeFeatures.rms_val ./ mean(abs(segment));
    timeFeatures.energy_val = sum(segment.^2);
    timeFeatures.entropy_val = arrayfun(@(i) wentropy(segment(:, i), 'shannon'), 1:size(segment, 2));
end
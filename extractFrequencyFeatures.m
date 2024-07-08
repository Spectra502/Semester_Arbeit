function frequencyFeatures = extractFrequencyFeatures(segment, sampleFrequency)
    frequencyFeatures = struct();
    fs = sampleFrequency;

    frequencyFeatures.mean_freq = zeros(1, size(segment, 2));
    frequencyFeatures.median_freq = zeros(1, size(segment, 2));
    frequencyFeatures.bandwidth_val = zeros(1, size(segment, 2));
    frequencyFeatures.spectral_centroid = zeros(1, size(segment, 2));
    frequencyFeatures.spectral_flatness = zeros(1, size(segment, 2));
    frequencyFeatures.spectral_entropy = zeros(1, size(segment, 2));
    frequencyFeatures.spectral_skewness = zeros(1, size(segment, 2));
    frequencyFeatures.spectral_kurtosis = zeros(1, size(segment, 2));
    
    for ch = 1:size(segment, 2)
        [Pxx, f] = pwelch(segment(:, ch), [], [], [], fs);
        frequencyFeatures.mean_freq(ch) = sum(f .* Pxx) / sum(Pxx);
        frequencyFeatures.median_freq(ch) = medfreq(segment(:, ch), fs);
        frequencyFeatures.bandwidth_val(ch) = obw(segment(:, ch), fs);
        frequencyFeatures.spectral_centroid(ch) = sum(f .* Pxx) / sum(Pxx);
        frequencyFeatures.spectral_flatness(ch) = geomean(Pxx) / mean(Pxx);
        frequencyFeatures.spectral_entropy(ch) = -sum(Pxx .* log(Pxx));
        frequencyFeatures.spectral_skewness(ch) = skewness(Pxx);
        frequencyFeatures.spectral_kurtosis(ch) = kurtosis(Pxx);
    end
end
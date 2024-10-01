function frequencyFeatures = extractFrequencyFeatures(segment, sampleFrequency, channelDescription)
    frequencyFeatures = struct();
    fs = sampleFrequency;

    for ch = 1:size(segment, 2)
        [Pxx, f] = pwelch(segment(:, ch), [], [], [], fs);
        frequencyFeatures.(['mean_freq_ch' num2str(ch) '_' channelDescription{ch}]) = sum(f .* Pxx) / sum(Pxx);
        frequencyFeatures.(['median_freq_ch' num2str(ch) '_' channelDescription{ch}]) = medfreq(segment(:, ch), fs);
        frequencyFeatures.(['bandwidth_val_ch' num2str(ch) '_' channelDescription{ch}]) = obw(segment(:, ch), fs);
        frequencyFeatures.(['spectral_centroid_ch' num2str(ch) '_' channelDescription{ch}]) = sum(f .* Pxx) / sum(Pxx);
        frequencyFeatures.(['spectral_flatness_ch' num2str(ch) '_' channelDescription{ch}]) = geomean(Pxx) / mean(Pxx);
        frequencyFeatures.(['spectral_entropy_ch' num2str(ch) '_' channelDescription{ch}]) = -sum(Pxx .* log(Pxx));
        frequencyFeatures.(['spectral_skewness_ch' num2str(ch) '_' channelDescription{ch}]) = skewness(Pxx);
        frequencyFeatures.(['spectral_kurtosis_ch' num2str(ch) '_' channelDescription{ch}]) = kurtosis(Pxx);
    end
end
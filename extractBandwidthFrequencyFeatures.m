function frequencyFeatures = extractBandwidthFrequencyFeatures(segment, sampleFrequency, frequency, sideband_length, channel_selection)
    frequencyFeatures = struct();
    fs = sampleFrequency;
    freqBandLow = frequency - sideband_length;  % Lower frequency bound in Hz
    freqBandHigh = frequency + sideband_length; % Upper frequency bound in Hz
    %disp(freqBandLow);
    %disp(freqBandHigh);
    %disp(fs);

    for ch = 1:size(segment, 2)
        % Compute Power Spectral Density (PSD) using pwelch
        [Pxx, f] = pwelch(segment(:, ch), [], [], [], fs);

        % Limit Pxx and f to the frequency band of interest (500 Hz - 1 kHz)
        bandMask = (f >= freqBandLow) & (f <= freqBandHigh);
        f_band = f(bandMask);
        Pxx_band = Pxx(bandMask);

        % Compute features within the frequency band
        frequencyFeatures.(['mean_freq_ch' num2str(channel_selection(ch))]) = sum(f_band .* Pxx_band) / sum(Pxx_band);
        frequencyFeatures.(['median_freq_ch' num2str(channel_selection(ch))]) = medfreq(segment(:, ch), fs, [freqBandLow freqBandHigh]);
        frequencyFeatures.(['bandwidth_val_ch' num2str(channel_selection(ch))]) = obw(segment(:, ch), fs, [freqBandLow freqBandHigh]);
        frequencyFeatures.(['spectral_centroid_ch' num2str(channel_selection(ch))]) = sum(f_band .* Pxx_band) / sum(Pxx_band);
        frequencyFeatures.(['spectral_flatness_ch' num2str(channel_selection(ch))]) = geomean(Pxx_band) / mean(Pxx_band);
        frequencyFeatures.(['spectral_entropy_ch' num2str(channel_selection(ch))]) = -sum(Pxx_band .* log(Pxx_band + eps)); % Add eps to avoid log(0)
        frequencyFeatures.(['spectral_skewness_ch' num2str(channel_selection(ch))]) = skewness(Pxx_band);
        frequencyFeatures.(['spectral_kurtosis_ch' num2str(channel_selection(ch))]) = kurtosis(Pxx_band);

        % Peak Frequency in the band
        [~, idx] = max(Pxx_band);
        frequencyFeatures.(['peak_freq_ch' num2str(channel_selection(ch))]) = f_band(idx);
        % Energy in the band
        frequencyFeatures.(['energy_in_band_ch' num2str(channel_selection(ch))]) = sum(Pxx_band);
    end
end

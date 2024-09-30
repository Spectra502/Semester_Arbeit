function timeFrequencyFeatures = extractBandwidthTimeFrequencyFeatures(segment, sampleFrequency, frequency, sideband_length, channel_selection)
    fs = sampleFrequency;
    timeFrequencyFeatures = struct();
    freqBandLow = frequency - sideband_length;  % Lower frequency bound in Hz
    freqBandHigh = frequency + sideband_length; % Upper frequency bound in Hz

    for ch = 1:size(segment, 2)
        
        % --- Continuous Wavelet Transform ---
        % Perform CWT and get the frequency response
        [cfs, f] = cwt(segment(:, ch), 'amor', fs);
        
        % Limit to the frequency band of interest (500 Hz to 1 kHz)
        bandMask = (f >= freqBandLow) & (f <= freqBandHigh);
        cfs_band = cfs(bandMask, :);  % Select coefficients in the desired band
        
        % Calculate wavelet features within the frequency band
        timeFrequencyFeatures.(['mean_wavelet_ch' num2str(channel_selection(ch))]) = mean(abs(cfs_band(:)));
        timeFrequencyFeatures.(['var_wavelet_ch' num2str(channel_selection(ch))]) = var(abs(cfs_band(:)));
        timeFrequencyFeatures.(['entropy_wavelet_ch' num2str(channel_selection(ch))]) = wentropy(abs(cfs_band(:)), 'shannon');
        timeFrequencyFeatures.(['energy_wavelet_ch' num2str(channel_selection(ch))]) = sum(abs(cfs_band(:)).^2);

        % --- Spectrogram ---
        % Compute the spectrogram
        [S, f_spect, ~, P] = spectrogram(segment(:, ch), 128, 120, 128, fs);
        
        % Limit spectrogram to the frequency band of interest (500 Hz to 1 kHz)
        bandMask_spect = (f_spect >= freqBandLow) & (f_spect <= freqBandHigh);
        P_band = P(bandMask_spect, :);  % Select power values in the desired band
        
        % Calculate spectrogram features within the frequency band
        timeFrequencyFeatures.(['mean_spectrogram_ch' num2str(channel_selection(ch))]) = mean(abs(P_band(:)));
        timeFrequencyFeatures.(['var_spectrogram_ch' num2str(channel_selection(ch))]) = var(abs(P_band(:)));
        timeFrequencyFeatures.(['entropy_spectrogram_ch' num2str(channel_selection(ch))]) = wentropy(abs(P_band(:)), 'shannon');
        timeFrequencyFeatures.(['energy_spectrogram_ch' num2str(channel_selection(ch))]) = sum(abs(P_band(:)).^2);
    end
end

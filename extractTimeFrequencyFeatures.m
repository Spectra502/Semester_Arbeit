function timeFrequencyFeatures = extractTimeFrequencyFeatures(segment, sampleFrequency)
    fs = sampleFrequency;
    timeFrequencyFeatures = struct();

    timeFrequencyFeatures.mean_wavelet = zeros(1, size(segment, 2));
    timeFrequencyFeatures.var_wavelet = zeros(1, size(segment, 2));
    timeFrequencyFeatures.entropy_wavelet = zeros(1, size(segment, 2));
    timeFrequencyFeatures.energy_wavelet = zeros(1, size(segment, 2));
    timeFrequencyFeatures.mean_spectrogram = zeros(1, size(segment, 2));
    timeFrequencyFeatures.var_spectrogram = zeros(1, size(segment, 2));
    timeFrequencyFeatures.entropy_spectrogram = zeros(1, size(segment, 2));
    timeFrequencyFeatures.energy_spectrogram = zeros(1, size(segment, 2));
    
    for ch = 1:size(segment, 2)
        [cfs, ~] = cwt(segment(:, ch), 'amor', fs);
        timeFrequencyFeatures.mean_wavelet(ch) = mean(abs(cfs(:)));
        timeFrequencyFeatures.var_wavelet(ch) = var(abs(cfs(:)));
        timeFrequencyFeatures.entropy_wavelet(ch) = wentropy(abs(cfs(:)), 'shannon');
        timeFrequencyFeatures.energy_wavelet(ch) = sum(abs(cfs(:)).^2);
        
        [~, ~, ~, P] = spectrogram(segment(:, ch), 128, 120, 128, fs);
        timeFrequencyFeatures.mean_spectrogram(ch) = mean(abs(P(:)));
        timeFrequencyFeatures.var_spectrogram(ch) = var(abs(P(:)));
        timeFrequencyFeatures.entropy_spectrogram(ch) = wentropy(abs(P(:)), 'shannon');
        timeFrequencyFeatures.energy_spectrogram(ch) = sum(abs(P(:)).^2);
    end
end
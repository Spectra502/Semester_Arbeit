function timeFrequencyFeatures = extractTimeFrequencyFeatures(segment, sampleFrequency)
    fs = sampleFrequency;
    timeFrequencyFeatures = struct();

    for ch = 1:size(segment, 2)
        [cfs, ~] = cwt(segment(:, ch), 'amor', fs);
        timeFrequencyFeatures.(['mean_wavelet_ch' num2str(ch)]) = mean(abs(cfs(:)));
        timeFrequencyFeatures.(['var_wavelet_ch' num2str(ch)]) = var(abs(cfs(:)));
        timeFrequencyFeatures.(['entropy_wavelet_ch' num2str(ch)]) = wentropy(abs(cfs(:)), 'shannon');
        timeFrequencyFeatures.(['energy_wavelet_ch' num2str(ch)]) = sum(abs(cfs(:)).^2);
        
        [~, ~, ~, P] = spectrogram(segment(:, ch), 128, 120, 128, fs);
        timeFrequencyFeatures.(['mean_spectrogram_ch' num2str(ch)]) = mean(abs(P(:)));
        timeFrequencyFeatures.(['var_spectrogram_ch' num2str(ch)]) = var(abs(P(:)));
        timeFrequencyFeatures.(['entropy_spectrogram_ch' num2str(ch)]) = wentropy(abs(P(:)), 'shannon');
        timeFrequencyFeatures.(['energy_spectrogram_ch' num2str(ch)]) = sum(abs(P(:)).^2);
    end
end

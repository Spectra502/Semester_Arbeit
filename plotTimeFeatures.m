function plotTimeFeatures(features)
    time_features = features(1).timeFeatures
    % Plot time domain features
    figure;
    subplot(3, 1, 1);
    plot(time_features);
    title(['Time Domain Features for ', fieldName]);
    xlabel('Segment');
    ylabel('Value');
    legend('Mean', 'RMS', 'Std Dev', 'Skewness', 'Kurtosis', 'Peak-to-Peak', 'Crest Factor', ...
        'Impulse Factor', 'Clearance Factor', 'Shape Factor', 'Energy', 'Entropy');
end
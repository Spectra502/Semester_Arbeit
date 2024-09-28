function plotFrequencyComparison(signal1, fs1, signal2, fs2)
    % plotFrequencyComparison: Plots the amplitude spectra of two signals on the same figure
    %
    % Inputs:
    %   signal1 - The first input time-domain signal
    %   fs1 - The sampling frequency of the first signal in Hz
    %   signal2 - The second input time-domain signal
    %   fs2 - The sampling frequency of the second signal in Hz
    %
    % Example usage:
    %   plotFrequencyComparison(signal1, fs1, signal2, fs2)
    
    % Plot the first signal's frequency spectrum
    subplot(2,1,1);
    plotSingleSpectrum(signal1, fs1);
    title('Amplitude Spectrum of Signal 1');
    
    % Plot the second signal's frequency spectrum
    subplot(2,1,2);
    plotSingleSpectrum(signal2, fs2);
    title('Amplitude Spectrum of Signal 2');
    
    % Common x-axis label
    xlabel('Frequency (Hz)');
    
    % Function to plot a single signal's amplitude spectrum
    function plotSingleSpectrum(signal, fs)
        % Number of samples
        N = length(signal);
        
        % Compute the FFT of the signal
        signalFFT = fft(signal);
        
        % Compute the two-sided spectrum P2
        P2 = abs(signalFFT/N);
        
        % Compute the single-sided spectrum P1 based on P2 and even-valued N
        P1 = P2(1:N/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        
        % Frequency vector
        f = fs*(0:(N/2))/N;
        
        % Plot the amplitude spectrum
        plot(f, P1);
        ylabel('Amplitude');
        grid on;
    end
end

function plotFrequencyAmplitude(signal, fs)
    % plotFrequencyAmplitude: Plots the amplitude spectrum of a signal
    %
    % Inputs:
    %   signal - The input time-domain signal
    %   fs - The sampling frequency in Hz
    %
    % Example usage:
    %   plotFrequencyAmplitude(signal, fs)
    
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
    figure;
    plot(f, P1);
    title('Single-Sided Amplitude Spectrum of Signal');
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    grid on;
end
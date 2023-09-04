% Parameters for the sinusoidal signals
frequencies = [1000, 2000]; % Frequencies in Hz
duration = 0.005;     % Duration in seconds
time_rate = 100000; % Time 'analogic' rate in Hz
sample_rate = 2000; % Sample rate in Hz

% Time vector
time_vector = (0:1/time_rate:duration);

% Generate the sinusoidal signals
sinusoidal_signals = zeros(length(time_vector), length(frequencies));
for i = 1:length(frequencies)
    sinusoidal_signals(:, i) = sin(2 * pi * frequencies(i) * time_vector);
end

% Calculate the sum of sinusoidal signals
sum_signal = sum(sinusoidal_signals, 2);

% Create a new figure for plotting side by side
figure('CloseRequestFcn', @(src, event) close_all_figures());

for i = 1:length(frequencies)
    % Generate the sample rate sinusoidal signal
    time_vector_higher_rate = (0:1/sample_rate:duration);
    sinusoidal_signal_higher_rate = sin(2 * pi * frequencies(i) * time_vector_higher_rate);
    
    % Plot the original sinusoidal signal
    subplot(length(frequencies), 3, (i-1)*3+1);
    plot(time_vector, sinusoidal_signals(:, i), 'b');
    title(['Original Signal (' num2str(frequencies(i)/1000) ' kHz)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    grid on;
    
    % Plot the sample rate sinusoidal signal
    subplot(length(frequencies), 3, (i-1)*3+2);
    plot(time_vector_higher_rate, sinusoidal_signal_higher_rate, 'r');
    title(['Sample Rate Signal (' num2str(sample_rate/1000) ' kHz)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    grid on;
    
    % Perform FFT on the original signal
    fft_signal = abs(fft(sinusoidal_signals(:, i)));
    fft_frequencies = linspace(0, sample_rate, length(fft_signal));
    
    % Perform FFT on the sample rate signal
    fft_signal_higher_rate = abs(fft(sinusoidal_signal_higher_rate));
    fft_frequencies_higher_rate = linspace(0, sample_rate, length(fft_signal_higher_rate));
    
    % Plot the FFT magnitude spectra side by side
    subplot(length(frequencies), 3, (i-1)*3+3);
    plot(fft_frequencies, fft_signal, 'b');
    hold on;
    plot(fft_frequencies_higher_rate, fft_signal_higher_rate, 'r');
    hold off;
    title(['FFT Magnitude Spectrum (' num2str(frequencies(i)/1000) ' kHz)']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end

% Adjust subplot layout
title('Multiple Sinusoidal Signals and Their Fourier Perspective');

% Callback function to close all figures
function close_all_figures(main_figure)
    exit;
end

pause;

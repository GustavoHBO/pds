% Parameters
frequencies = [500, 1000, 2000]; % Frequencies in Hz
duration = 0.01;     % Duration in seconds
time_rate = 100000; % Time 'analogic' rate in Hz
sample_rate = 1000; % Sample rate in Hz

% Initialize figure
figure('CloseRequestFcn', @(src, event) close_all_figures());

for i = 1:length(frequencies)
    frequency = frequencies(i);
    
    % Time vector
    time_vector = (0:1/time_rate:duration);
    
    % Generate the sinusoidal signal
    sinusoidal_signal = sin(2 * pi * frequency * time_vector);
    
    % Perform PAM sampling
    # samples_per_cycle = sample_rate / frequency;
    samples_per_cycle = sample_rate;
    # sampled_signal = sinusoidal_signal(1:samples_per_cycle:end);
    sampled_signal = sinusoidal_signal(1:samples_per_cycle:end);
    
    % Compute FFT and magnitude spectrum
    fft_result = fft(sampled_signal);
    fft_magnitude = abs(fft_result);
    
    % Frequencies for the FFT plot
    fft_frequencies = sample_rate * (0:length(fft_magnitude)-1) / length(fft_magnitude);
    
    % Plot the original signal in the time domain
    subplot(length(frequencies), 3, (i-1)*3+1);
    plot(time_vector, sinusoidal_signal);
    title(['Original Signal (' num2str(frequency) ' Hz)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    grid on;
    
    % Plot the PAM sampled signal
    subplot(length(frequencies), 3, (i-1)*3+2);
    stem(sampled_signal);
    title(['PAM Sampled Signal (' num2str(sample_rate) ' Hz)']);
    xlabel('Sample Index');
    ylabel('Amplitude');
    grid on;
    
    % Plot the FFT magnitude spectrum
    subplot(length(frequencies), 3, (i-1)*3+3);
    plot(fft_frequencies, fft_magnitude);
    title(['FFT Magnitude Spectrum (' num2str(frequency) ' Hz)']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end

% Adjust subplot layout
title('PAM Sampling and FFT Spectrum for Different Frequencies');

% Callback function to close all figures
function close_all_figures(main_figure)
    exit;
end

pause;

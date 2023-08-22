% Parameters for the sinusoidal signals
frequencies = [1000, 2000, 3000]; % Frequencies in Hz
duration = 0.01;     % Duration in seconds
sample_rate = 48000; % Sample rate in Hz

% Time vector
time_vector = (0:1/sample_rate:duration-1/sample_rate);

% Generate the sinusoidal signals
sinusoidal_signals = zeros(length(time_vector), length(frequencies));
for i = 1:length(frequencies)
    sinusoidal_signals(:, i) = sin(2 * pi * frequencies(i) * time_vector);
end

% Calculate the sum of sinusoidal signals
sum_signal = sum(sinusoidal_signals, 2);

% Plot the individual sinusoidal signals in the time domain
figure;
for i = 1:length(frequencies)
    subplot(length(frequencies)+1, 2, (i-1)*2+1);
    plot(time_vector, sinusoidal_signals(:, i));
    title(['Sinusoidal Signal (' num2str(frequencies(i)/1000) ' kHz)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    grid on;
end

% Plot the sum of sinusoidal signals in the time domain
subplot(length(frequencies)+1, 2, length(frequencies)*2+1);
plot(time_vector, sum_signal);
title('Sum of Sinusoidal Signals');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Perform FFT on individual signals and their sum
fft_signals = abs(fft(sinusoidal_signals));
fft_sum_signal = abs(fft(sum_signal));

% Frequencies for the FFT plots
fft_frequencies = linspace(0, sample_rate, length(fft_signals));

% Plot the magnitude spectra of individual signals in the frequency domain
for i = 1:length(frequencies)
    subplot(length(frequencies)+1, 2, (i-1)*2+2);
    plot(fft_frequencies, fft_signals(:, i));
    title(['FFT Magnitude Spectrum (' num2str(frequencies(i)/1000) ' kHz)']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end

% Plot the magnitude spectrum of the sum signal in the frequency domain
subplot(length(frequencies)+1, 2, length(frequencies)*2+2);
plot(fft_frequencies, fft_sum_signal);
title('FFT Magnitude Spectrum (Sum of Signals)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Adjust subplot layout
title('Multiple Sinusoidal Signals and Their Fourier Perspective');


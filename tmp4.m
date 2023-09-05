% Define array of frequencies, amplitudes, orders, and cutoffs
freq_nyquist_fraction = 0.5; % Fraction of Nyquist frequency
frequencies = [3000, 5000]; % Frequencies of signals (in Hz)
amplitudes = [1, 1]; % Amplitudes of signals
orders = [2, 2]; % Order of filters
cutoffs = [4000, 6000]; % Cutoff frequencies of filters

min_frequecy = min(frequencies);
periods = 3; % Number of periods to plot

% Define parameters
Fs_real = 1000000; % Sampling frequency (real data)
Fs = 100000; % Sampling frequency
t = 0:1/Fs:periods/min_frequecy; % Time vector
t_real = 0:1/Fs_real:periods/min_frequecy; % Time vector (real data)


num_signals = length(frequencies);
signals = zeros(num_signals, length(t));

signals_real = zeros(num_signals, length(t_real));

% Generate and sum the signals
for i = 1:num_signals
    signals_real(i, :) = amplitudes(i) * sin(2*pi*frequencies(i)*t_real);
end

% Generate and sum the signals
for i = 1:num_signals
    signals(i, :) = amplitudes(i) * sin(2*pi*frequencies(i)*t);
end

summed_signal = sum(signals);

% Plot signals and FFTs
% Initialize figure
figure('CloseRequestFcn', @(src, event) close_all_figures());

for i = 1:num_signals
    subplot(num_signals, 4, 4*i-3);
    plot(t_real, signals_real(i, :), '.-');
    title(['Real Signal ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(num_signals, 4, 4*i-2); % FFT plot is on the right side
    fft_signal = fft(signals_real(i, :));
    frequencies_fft = linspace(0, Fs_real, length(fft_signal));
    plot(frequencies_fft, abs(fft_signal));
    title(['FFT of Signal ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');

    subplot(num_signals, 4, 4*i-1);
    # plot(t, signals(i, :), '.-');
    stem(t, signals(i, :), '.');
    title(['Signal ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(num_signals, 4, 4*i); % FFT plot is on the right side
    fft_signal = fft(signals(i, :));
    frequencies_fft = linspace(0, Fs, length(fft_signal));
    plot(frequencies_fft, abs(fft_signal));
    title(['FFT of Signal ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
end

% Plot summed signal and its FFT
% Initialize figure
figure('CloseRequestFcn', @(src, event) close_all_figures());
subplot(2, 1, 1);
plot(t, summed_signal);
title('Summed Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
fft_summed_signal = fft(summed_signal);
frequencies_fft_summed_signal = linspace(0, Fs, length(fft_summed_signal));
plot(frequencies_fft_summed_signal, abs(fft_summed_signal));
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Callback function to close all figures
function close_all_figures(main_figure)
    exit;
end

pause;
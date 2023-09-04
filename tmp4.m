% Define parameters
Fs_real = 1000000; % Sampling frequency (real data)
Fs = 10000; % Sampling frequency
t = 0:1/Fs:0.0004; % Time vector
t_real = 0:1/Fs_real:0.0004; % Time vector (real data)

% Define array of frequencies and amplitudes
frequencies = [1000, 3000, 5000]; % Frequencies of signals (in Hz)
amplitudes = [1, 1, 1]; % Amplitudes of signals

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
figure;

for i = 1:num_signals
    subplot(4, 4, 4*i-3);
    plot(t_real, signals_real(i, :), '.-');
    title(['Real Signal ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(4, 4, 4*i-2); % FFT plot is on the right side
    fft_signal = fft(signals_real(i, :));
    frequencies_fft = linspace(0, Fs_real, length(fft_signal));
    plot(frequencies_fft, abs(fft_signal));
    title(['FFT of Signal ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');

    subplot(4, 4, 4*i-1);
    plot(t, signals(i, :), '.-');
    title(['Signal ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(4, 4, 4*i); % FFT plot is on the right side
    fft_signal = fft(signals(i, :));
    frequencies_fft = linspace(0, Fs, length(fft_signal));
    plot(frequencies_fft, abs(fft_signal));
    title(['FFT of Signal ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
end

% Plot summed signal and its FFT
figure;
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

pause;
pkg load signal

% Define array of frequencies, amplitudes, orders, and cutoffs
freq_nyquist_fraction = 0.5; % Fraction of Nyquist frequency
frequencies = [10, 50, 90]; % Frequencies of signals (in Hz)
amplitudes = [1, 1, 1]; % Amplitudes of signals
%orders = [2, 2, 2]; % Order of filters
order = 10; % Order of filter
cutoffs = 25; % Cutoff frequency of filter

min_frequecy = min(frequencies);
max_frequency = max(frequencies);
periods = 1; % Number of periods to plot

% Define parameters
Fs_real = 1000 * max_frequency; % Sampling frequency (real data)
Fs = 10 * max_frequency; % Sampling frequency
t = 0:1/Fs:periods/min_frequecy; % Time vector
t_real = 0:1/Fs_real:periods/min_frequecy; % Time vector (real data)

num_signals = length(frequencies);
signals = zeros(num_signals, length(t));

signals_real = zeros(num_signals, length(t_real));

% Generate and sum the signals of real data.
for i = 1:num_signals
    signals_real(i, :) = amplitudes(i) * sin(2*pi*frequencies(i)*t_real);
end

% Generate and sum the signals of simulated data.
for i = 1:num_signals
    signals(i, :) = amplitudes(i) * sin(2*pi*frequencies(i)*t);
end

summed_signal = sum(signals);
summed_signal_real = sum(signals_real);

% Plot signals and FFTs
% Initialize figure
% figure('CloseRequestFcn', @(src, event) close_all_figures());

% for i = 1:num_signals
%     subplot(num_signals, 4, 4*i-3);
%     plot(t_real, signals_real(i, :));
%     title(['Real Signal ', num2str(i), ' (', num2str(frequencies(i)), ' Hz)']);
%     xlabel('Time (s)');
%     ylabel('Amplitude');
  
%     subplot(num_signals, 4, 4*i-2); % FFT plot is on the right side
%     fft_signal = fft(signals_real(i, :));
%     frequencies_fft = linspace(0, Fs_real, length(fft_signal));
%     %plot(frequencies_fft, abs(fft_signal));
%     stem(frequencies_fft, abs(fft_signal), '.');
%     title(['FFT of Real Signal ', num2str(i)]);
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
%     subplot(num_signals, 4, 4*i-1);
%     # plot(t, signals(i, :));
%     stem(t, signals(i, :), '.');
%     title(['Sampled Signal ', num2str(i)]);
%     xlabel('Time (s)');
%     ylabel('Amplitude');
%     subplot(num_signals, 4, 4*i); % FFT plot is on the right side
%     fft_signal = fft(signals(i, :));
%     frequencies_fft = linspace(0, Fs, length(fft_signal));
%     stem(frequencies_fft, abs(fft_signal), '.');
%     title(['FFT of Sampled Signal ', num2str(i)]);
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
% end

% Plot summed signal and its FFT
% Initialize figure

% Signal real
figure('CloseRequestFcn', @(src, event) close_all_figures());
ylim([-2, 2]);
plot(t_real, signals_real(1, :), 'b', 'LineWidth', 1.5); % Linha azul mais espessa
hold on;

% Adicione outras séries de dados (se houver) usando plot novamente com cores diferentes.

title('Sinal de Entrada Filtrado', 'FontSize', 25);
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);

grid on; % Habilitar a grade

legend('Sinal de Entrada', 'FontSize', 25); % Adicione legendas se necessário

figure('CloseRequestFcn', @(src, event) close_all_figures());
subplot(3, 1, 1);
plot(t, summed_signal);
title('Summed Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
fft_summed_signal = fft(summed_signal);
frequencies_fft_summed_signal = linspace(0, Fs, length(fft_summed_signal));
stem(frequencies_fft_summed_signal, abs(fft_summed_signal), '.');
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 1, 3);
fft_summed_signal = ifft(fft(summed_signal));
plot(t, fft_summed_signal);
frequencies_fft_summed_signal = linspace(0, Fs, length(fft_summed_signal));
%stem(frequencies_fft_summed_signal, abs(fft_summed_signal), '.');
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

figure('CloseRequestFcn', @(src, event) close_all_figures());
% Crie a função de transferência do filtro passa-baixa (Butterworth)
[b, a] = butter(order, cutoffs / (Fs/2), 'low');

% Aplicar o filtro passa-baixa ao sinal
sinal_filtrado = filter(b, a, summed_signal);

subplot(3, 1, 1);
plot(t, sinal_filtrado);
title('Sinal Filtrado (Passa-Baixa)');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
fft_summed_signal_filtrado = fft(sinal_filtrado);
frequencies_fft_summed_signal_filtrado = linspace(0, Fs, length(fft_summed_signal_filtrado));
stem(frequencies_fft_summed_signal_filtrado, abs(fft_summed_signal_filtrado), '.');
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 1, 3);
ifft_summed_signal_filtrado = ifft(fft_summed_signal_filtrado);
frequencies_ifft_summed_signal_filtrado = linspace(0, Fs, length(ifft_summed_signal_filtrado));
plot(frequencies_ifft_summed_signal_filtrado, ifft_summed_signal_filtrado);
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Filter the summed signal -----------------------------------------------------------
figure('CloseRequestFcn', @(src, event) close_all_figures());
subplot(3, 1, 1);
plot(t, summed_signal);
title('Summed Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
figure('CloseRequestFcn', @(src, event) close_all_figures());

fft_summed_signal = fft(summed_signal);
frequencies_fft_summed_signal = linspace(0, Fs, length(fft_summed_signal));
stem(frequencies_fft_summed_signal, abs(fft_summed_signal), '.');
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

figure('CloseRequestFcn', @(src, event) close_all_figures());

subplot(3, 1, 3);
fft_summed_signal = ifft(fft(summed_signal));
plot(t, fft_summed_signal);
frequencies_fft_summed_signal = linspace(0, Fs, length(fft_summed_signal));
%stem(frequencies_fft_summed_signal, abs(fft_summed_signal), '.');
title('FFT of Summed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
% Callback function to close all figures
function close_all_figures(main_figure)
    exit;
end

pause;
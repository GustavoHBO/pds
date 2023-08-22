% Load the audio package if needed
pkg load audio

% Load the signal package if needed
pkg load signal

% Set the sound play utility to 'aplay' on Linux.
global sound_play_utility = 'aplay';

% Get the full path of the script file
script_full_path = mfilename('fullpath');

% Extract the directory path of the script
script_directory = fileparts(script_full_path);

output_file_path = 'files/outputs/audios/'; % Output file path.

% Replace 'audio_file.wav' with the actual path to your audio file
% file_path = 'files/audios/Teste_audio_01.ogg';
% file_path = 'files/audios/Teste_audio_02.ogg'; % Only voice.
% file_path = 'files/audios/Teste_audio_03.ogg'; % Only noize.
% file_path = 'files/audios/Teste_audio_04.ogg'; % Voice and noize.
% file_path = 'files/audios/Teste_audio_05.ogg'; % Voice and noize(8kHz).
% file_path = 'files/audios/Teste_audio_06.ogg'; % noize(1760 Hz).
% file_path = 'files/audios/Teste_audio_07.ogg'; % Voice and noize(1760 Hz).
% file_path = 'files/audios/Teste_audio_08.ogg'; % Voice and noize(7040 Hz).
file_path = 'files/audios/Teste_audio_09.ogg'; % Voice and noize(200Hz and 7040 Hz).

file_path = fullfile(script_directory, file_path);

% Read the audio file
[audio_data, sample_rate] = audioread(file_path);

% Create a time vector based on the sample rate and audio length
time_vector = (0:length(audio_data)-1) / sample_rate;

% Create a new figure for the wave plot.
%figure;

% Plot the audio waveform
%plot(time_vector, audio_data);
%xlabel('Time (seconds)');
%ylabel('Amplitude');
%title('Audio Waveform');
%grid on;

% Adjust the plot to fit the waveform nicely
%axis tight;

% -------------------------------- Custom paramters --------------------------------
lowpass_cutoff = 2000;  % Adjust the cutoff frequency as needed
highpass_cutoff = 300;   % High-pass cutoff frequency in Hz
filter_order = 101;       % Adjust the filter order as needed

% -------------------------------- Design a low-pass filter --------------------------------

% Calculate the normalized low-pass cutoff frequency
normalized_lowpass_cutoff = lowpass_cutoff / (sample_rate / 2);

% Design the low-pass filter using the fir1 function
lowpass_filter_coefficients = fir1(filter_order, normalized_lowpass_cutoff, 'low');

% Apply the low-pass filter to the audio data
lowpass_filtered_audio = filter(lowpass_filter_coefficients, 1, audio_data);

% -------------------------------- Design a high-pass filter --------------------------------
% Calculate the normalized high-pass cutoff frequency
normalized_highpass_cutoff = highpass_cutoff / (sample_rate / 2);

% Design the high-pass filter using the fir1 function
highpass_filter_coefficients = fir1(filter_order, normalized_highpass_cutoff, 'high');

% Apply the high-pass filter to the audio data
highpass_filtered_audio = filter(highpass_filter_coefficients, 1, audio_data);

% -------------------------------- Design a band-pass filter -------------------------

% Design the band-pass filter using the fir1 function
bandpass_filter_coefficients = fir1(filter_order, normalized_highpass_cutoff, 'high');

% Apply the band-pass filter to the audio data
band_filtered_audio = filter(bandpass_filter_coefficients, 1, lowpass_filtered_audio);

% -------------------------------- Plot the FFT -------------------------

% Calculate the length of the audio signal
signal_length = length(audio_data);

% Compute the FFT of the audio signal.
fft_size = 2^nextpow2(signal_length);  % Choose the next power of 2 for efficient FFT
fft_result = fft(audio_data, fft_size);
frequencies_audio_signal = (0:fft_size-1) * (sample_rate / fft_size);
fft_magnitude_audio_signal = abs(fft_result); % Compute the magnitude of the FFT result

% Compute the FFT of the low-pass filtered audio signal.
signal_length = length(lowpass_filtered_audio);
fft_size = 2^nextpow2(signal_length);  % Choose the next power of 2 for efficient FFT
fft_result = fft(lowpass_filtered_audio, fft_size);
frequencies_lowpass = (0:fft_size-1) * (sample_rate / fft_size);
fft_magnitude_lowpass = abs(fft_result); % Compute the magnitude of the FFT result

% Compute the FFT of the high-pass filtered audio signal.
signal_length = length(highpass_filtered_audio);
fft_size = 2^nextpow2(signal_length);  % Choose the next power of 2 for efficient FFT
fft_result = fft(highpass_filtered_audio, fft_size);
frequencies_highpass = (0:fft_size-1) * (sample_rate / fft_size);
fft_magnitude_highpass = abs(fft_result); % Compute the magnitude of the FFT result

% Compute the FFT of the band-pass filtered audio signal.
signal_length = length(band_filtered_audio);
fft_size = 2^nextpow2(signal_length);  % Choose the next power of 2 for efficient FFT
fft_result = fft(band_filtered_audio, fft_size);
frequencies_bandpass = (0:fft_size-1) * (sample_rate / fft_size);
fft_magnitude_band = abs(fft_result); % Compute the magnitude of the FFT result

% Create a new figure for the FFT plot
figure('CloseRequestFcn', @(src, event) close_all_figures());

% Plot the FFT magnitude
subplot(4, 1, 1);
plot(frequencies_audio_signal, fft_magnitude_audio_signal);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain Representation Signal Audio');
grid on;

% Plot the low-pass filtered audio
subplot(4, 1, 2);
plot(frequencies_lowpass, fft_magnitude_lowpass);
xlabel('Time (seconds)');
ylabel('Magnitude');
title('Frequency Domain Representation Low-Pass Filtered Audio');
grid on;

% Plot the high-pass filtered audio
subplot(4, 1, 3);
plot(frequencies_highpass, fft_magnitude_highpass);
xlabel('Time (seconds)');
ylabel('Magnitude');
title('Frequency Domain Representation High-Pass Filtered Audio');
grid on;

% Plot the band-pass filtered audio

subplot(4, 1, 4);
plot(frequencies_bandpass, fft_magnitude_band);
xlabel('Time (seconds)');
ylabel('Magnitude');
title('Frequency Domain Representation Band-Pass Filtered Audio');
grid on;

% Adjust the subplots
% subplot(4, 1, 1);
% axis tight;
% subplot(4, 1, 2);
% axis tight;
% subplot(4, 1, 3);
% axis tight;
% subplot(4, 1, 4);
% axis tight;

% -------------------------------- Plot the filtered audio -------------------------

% Create a new figure for the filtered audio plot
figure('CloseRequestFcn', @(src, event) close_all_figures());

% Plot the original audio
subplot(4, 1, 1);
plot(time_vector, audio_data);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Original Audio');
grid on;

% Plot the low-pass filtered audio
subplot(4, 1, 2);
plot(time_vector, lowpass_filtered_audio);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Low-Pass Filtered Audio');
grid on;

% Plot the high-pass filtered audio
subplot(4, 1, 3);
plot(time_vector, highpass_filtered_audio);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('High-Pass Filtered Audio');
grid on;

% Plot the band-pass filtered audio
subplot(4, 1, 4);
plot(time_vector, band_filtered_audio);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Band-Pass Filtered Audio');
grid on;

% Adjust the subplots
subplot(4, 1, 1);
axis tight;
subplot(4, 1, 2);
axis tight;
subplot(4, 1, 3);
axis tight;
subplot(4, 1, 4);
axis tight;


% -------------------------------- Play the audio -------------------------
% Play the original audio
% disp('Playing original audio...');
% player = audioplayer(audio_data, sample_rate);
% play(player);

% Play the low-pass filtered audio
% disp('Playing low-pass filtered audio...');
% player = audioplayer(lowpass_filtered_audio, sample_rate);
% play(player);

% Play the high-pass filtered audio
% disp('Playing high-pass filtered audio...');
% player = audioplayer(highpass_filtered_audio, sample_rate);
% play(player);

% Play the band-pass filtered audio
disp('Playing band-pass filtered audio...');
player = audioplayer(band_filtered_audio, sample_rate);
play(player);

% -------------------------------- Save the audio -------------------------
% Save the low-pass filtered audio
disp('Saving low-pass filtered audio...');
audiowrite(fullfile(script_directory, strcat(output_file_path, 'lowpass_filtered_audio.ogg')), lowpass_filtered_audio, sample_rate);

% Save the high-pass filtered audio
disp('Saving high-pass filtered audio...');
audiowrite(fullfile(script_directory, strcat(output_file_path, 'highpass_filtered_audio.ogg')), highpass_filtered_audio, sample_rate);

% Save the band-pass filtered audio
disp('Saving band-pass filtered audio...');
audiowrite(fullfile(script_directory, strcat(output_file_path, 'bandpass_filtered_audio.ogg')), band_filtered_audio, sample_rate);

% -------------------------------- Configurations -------------------------

% Close all on figures on exit
% Set up a callback function to close all figures when the main figure is closed
% Callback function to close all figures
function close_all_figures(main_figure)
    % exit();
    close all force;
    % exit;
end
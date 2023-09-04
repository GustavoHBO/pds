% Parameters
duration = 1;       % Duration of the pulse train in seconds
frequency_sample = 16;
frequency = 4;
pulse_width = 1/frequency_sample;  % Width of each pulse in seconds
time_rate = 100000;   % Time rate in Hz
amplitude = 3;      % Amplitude of the sinusoidal signal

% Time vector
time_vector = (0:1/time_rate:duration);

% Generate the pulse train
pulse_train = zeros(size(time_vector));
pulse_indices = round(pulse_width * time_rate) : round(pulse_width * time_rate) : length(pulse_train);

% Set the impulses
pulse_train(pulse_indices) = 1;

% Generate the sinusoidal signal
sinusoidal_signal = amplitude * sin(2 * pi * frequency * time_vector);


% Plot the original signal in the time domain
subplot(3, 1, 1);
plot(time_vector, sinusoidal_signal);
title(['Original Signal (' num2str(frequency) ' Hz)']);
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Plot the pulse train
subplot(3, 1, 2);
plot(time_vector, pulse_train);
title('Pulse Train');
xlabel('Time (seconds)');
ylabel('Amplitude'); 
grid on;

% Plot the sample
subplot(3, 1, 3);
sampled_signal = pulse_train .* sinusoidal_signal;
% Find indices of non-zero elements
# non_zero_indices = sampled_signal ~= 0;
# sampled_signal = sampled_signal(non_zero_indices)
stem(sampled_signal);
title('Sampled Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Adjust the subplots
axis tight;

pause;

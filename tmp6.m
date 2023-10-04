pkg load signal;
% Parâmetros
Vpp = 5;            % Amplitude do sinal em volts
n_bits = 6;         % Número de bits do ADC
n_samples = 1000;   % Número de amostras a serem quantizadas

% Gerar um sinal triangular de teste
fs = 1000;           % Frequência de amostragem em Hz
t = (0:1/fs:(n_samples-1)/fs); % Vetor de tempo
signal = Vpp * sawtooth(2 * pi * 1 * t, 0.5); % Sinal triangular de 1 Hz

% Quantização
quantization_levels = 2^n_bits; % Número de níveis de quantização
step_size = Vpp / quantization_levels; % Tamanho do passo de quantização

% Quantizar o sinal
quantized_signal = round(signal / step_size) * step_size;

% Plotar o sinal original e o sinal quantizado com níveis de quantização
subplot(2, 1, 1);
plot(t, signal);
title('Sinal Triangular Original');
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
grid on;

subplot(2, 1, 2);
stem(t, quantized_signal, '.');
title('Sinal Triangular Quantizado com Níveis de Quantização');
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
grid on;

% Calcular o erro de quantização
quantization_error = signal - quantized_signal;

% Exibir o erro de quantização médio
mean_quantization_error = mean(quantization_error);
disp(['Erro de quantização médio: ', num2str(mean_quantization_error)]);

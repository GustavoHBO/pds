% Carregar o áudio
[y, fs] = audioread('/home/gntwo/Downloads/4000.wav');

% Verificar se o sinal é estéreo
if size(y, 2) > 1
    % Converter para sinal mono (média dos canais)
    y = y(:, 1); % Seleciona o primeiro canal (esquerdo) ou o segundo canal (direito)
end

% Plotar o sinal de áudio
t = (0:length(y)-1) / fs; % Vetor de tempo
figure;
plot(t, y);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal de Áudio');

% Calcular a FFT do sinal de áudio
N = length(y); % Comprimento do sinal
Y = fft(y); % Calcular a FFT
f = (0:N-1)*(fs/N); % Vetor de frequências

% Plotar a magnitude da FFT
figure;
plot(f, abs(Y));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('FFT do Sinal de Áudio');

% Exibir o espectrograma
window_length = round(fs * 0.03); % Comprimento da janela em amostras (30 ms)
overlap_length = round(window_length * 0.5); % Sobreposição entre janelas (50%)
nfft = 1024; % Número de pontos da FFT

figure;
specgram(y, nfft, fs, window_length, overlap_length);
xlabel('Tempo (s)');
ylabel('Frequência (Hz)');
title('Espectrograma');
colorbar; % Adiciona uma barra de cores


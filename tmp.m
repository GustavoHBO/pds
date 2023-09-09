% Crie um sinal de exemplo no domínio da frequência
fs = 1000; % Taxa de amostragem (Hz)
t = 0:1/fs:1; % Vetor de tempo de 0 a 1 segundo
f1 = 5; % Frequência da primeira senoide (Hz)
f2 = 20; % Frequência da segunda senoide (Hz)
sinal_no_tempo = sin(2*pi*f1*t) + sin(2*pi*f2*t); % Sinal composto de duas senoides no domínio do tempo

% Calcule a FFT do sinal no domínio da frequência
sinal_no_frequencia = fft(sinal_no_tempo);

% Realize a IFFT para recuperar o sinal no domínio do tempo
sinal_reconstruido = ifft(sinal_no_frequencia);

% Plote o sinal original e o sinal reconstruído
subplot(2, 1, 1);
plot(t, sinal_no_tempo);
title('Sinal Original no Domínio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, sinal_reconstruido);
title('Sinal Reconstruído a partir da IFFT');
xlabel('Tempo (s)');
ylabel('Amplitude');

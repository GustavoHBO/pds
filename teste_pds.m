% Carregando pacotes necessários
pkg load signal;

% Parametros
fs = 44100; % Taxa de amostragem (Hz)
duration = 1; % Duração da gravação (segundos)


% Parâmetros do filtro
fs = 44100; % Taxa de amostragem (Hz)
f1 = 3900; % Frequência de corte inferior do filtro (Hz)
f2 = 4100; % Frequência de corte superior do filtro (Hz)
pass_band = [f1, f2] / (fs / 2); % Normalização das frequências de corte para a faixa [0, 1]

% Ordem do filtro (número de coeficientes)
order = 100; % Ajuste conforme necessário para o desempenho do filtro

% Projetar o filtro passa faixa
b = fir1(order, pass_band, 'bandpass');

figure;
while true
    % Criar um objeto audiorecorder
    recorder = audiorecorder(fs, 16, 1); % fs: taxa de amostragem, 16 bits de profundidade, 1 canal de áudio
    
    % Iniciar a gravação
    disp('Iniciando gravação...');
    recordblocking(recorder, duration); % Gravação bloqueante por 'duration' segundos
    disp('Gravação concluída.');
    
    % Obter os dados gravados
    y = getaudiodata(recorder);
    
    % Verificar se o sinal é estéreo
    if size(y, 2) > 1
        % Converter para sinal mono (média dos canais)
        y = y(:, 1); % Seleciona o primeiro canal (esquerdo) ou o segundo canal (direito)
    end
    
    % Aplicar o filtro ao sinal
    y = filter(b, 1, y);
    
    % Exibir o espectrograma
    window_length = round(fs * 0.03); % Comprimento da janela em amostras (30 ms)
    overlap_length = round(window_length * 0.5); % Sobreposição entre janelas (50%)
    nfft = 1024; % Número de pontos da FFT

    %figure;
    specgram(y, nfft, fs, window_length, overlap_length);
    xlabel('Tempo (s)');
    ylabel('Frequência (Hz)');
    title('Espectrograma');
    colorbar; % Adiciona uma barra de cores
    
    pause(0.1); % Aguardar 1 segundo antes da próxima gravação
end
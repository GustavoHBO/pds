% Carregando pacotes necessários
pkg load signal;

% Parametros
fs = 44100; % Taxa de amostragem (Hz)
duration = 1; % Duração da gravação (segundos)
qtn_periodos_exibir = 2; % Quantidade de períodos a serem exibidos no último gráfico
audio_file = '/home/gntwo/Downloads/4000.wav'; % Endereço do áudio

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
    
    % Carregar o áudio
    [y, fs] = audioread(audio_file);
    
    % Verificar se o sinal é estéreo
    if size(y, 2) > 1
        % Converter para sinal mono (média dos canais)
        y = y(:, 1); % Seleciona o primeiro canal (esquerdo) ou o segundo canal (direito)
    end
    
    % Aplicar o filtro ao sinal
    %y = filter(b, 1, y);
    
    % Exibir o espectrograma
    window_length = round(fs * 0.03); % Comprimento da janela em amostras (30 ms)
    overlap_length = round(window_length * 0.5); % Sobreposição entre janelas (50%)
    nfft = 16000; % Número de pontos da FFT

    [S, F, T] = specgram(y, nfft, fs, window_length, overlap_length);
    
    % Limitar a exibição do espectrograma em uma determinada faixa de frequência
    f_min = 0; % Frequência mínima
    f_max = 5000; % Frequência máxima
    f_min_index = find(F <= f_min, 1, 'last'); % Índice correspondente à frequência mínima
    f_max_index = find(F >= f_max, 1, 'first'); % Índice correspondente à frequência máxima
    
    subplot(4, 1, 1);
    imagesc(T, F(f_min_index:f_max_index), 10*log10(abs(S(f_min_index:f_max_index,:))));
    axis xy; % Inverter o eixo y para corresponder à representação usual do espectrograma
    xlabel('Tempo (s)');
    ylabel('Frequência (Hz)');
    title('Espectrograma');
    %colorbar; % Adiciona uma barra de cores
    
    fft_audio = fft(y);
    % Calcular o vetor de frequências correspondentes
    N = length(y); % Número de amostras no sinal
    frequencies = (0:N-1) * (fs / N);
    subplot(4, 1, 2);
    % Plotar o espectro de frequência
    %plot(frequencies, abs(fft_audio));
    stem(frequencies - fs/2, fftshift(abs(fft_audio)), '.');
    xlabel('Frequência (Hz)');
    ylabel('Magnitude');
    title('Espectro de Frequência do Sinal de Áudio em Tempo Real');
    
    % Plotar o sinal de áudio
    t = (0:length(y)-1) / fs; % Vetor de tempo
    subplot(4, 1, 3);
    plot(t, y);
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    title('Sinal de Áudio');
    
    % Encontrar a maior frequência presente no sinal
    [~, max_index] = max(abs(fft_audio));
    max_frequency = frequencies(max_index);
    period_samples = qtn_periodos_exibir * round(fs / max_frequency);
    
    % Exibir apenas o primeiro período do sinal
    y_period = y(1:period_samples);
    t_period = (0:length(y_period)-1) / fs; % Vetor de tempo
    subplot(4, 1, 4);
    plot(t_period, y_period);
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    title('Primeiro Período do Sinal de Áudio');
    
    % Adicionar o valor da frequência à figura
    text(0.5, 0.9, sprintf('Frequência encontrada: %.2f Hz', max_frequency), 'Color', 'red', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Units', 'normalized');
    
    pause(1); % Aguardar 1 segundo antes da próxima gravação
    break;
end
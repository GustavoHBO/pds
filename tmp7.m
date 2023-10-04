% Parâmetros
center_time = 0.5;    % Tempo central do pulso retangular
width = 0.4;          % Largura do pulso retangular
fs = 1000;            % Frequência de amostragem

function pulse_signal = generate_unit_centered_rectangular_pulse(center_time, width, fs)
    % center_time: tempo central do pulso retangular
    % width: largura do pulso retangular
    % fs: frequência de amostragem

    % Crie um vetor de tempo
    t = (0:1/fs:1);

    % Calcule o tempo de início e fim do pulso com base no tempo central e na largura
    start_time = center_time - width/2;
    end_time = center_time + width/2;

    % Inicialize o sinal do pulso com zeros
    pulse_signal = zeros(size(t));

    % Encontre os índices do vetor de tempo que correspondem ao início e ao fim do pulso
    start_index = round(start_time * fs) + 1;
    end_index = round(end_time * fs);

    % Defina o pulso retangular (amplitude 1) dentro do intervalo desejado
    pulse_signal(start_index:end_index) = 1;
end


% Gerar o pulso retangular unitário e centralizado usando a função personalizada
pulse_signal = generate_unit_centered_rectangular_pulse(center_time, 0.1, 10);

% Plotar o pulso retangular
t = (0:1/fs:(length(pulse_signal)-1)/fs); % Vetor de tempo correspondente
plot(t, pulse_signal);
title('Pulso Retangular Unitário Centralizado');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;
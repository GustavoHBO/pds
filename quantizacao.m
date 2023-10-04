function y = funcao_triangular(x, frequencia, amplitude, dc)
    % Calcula a função triangular com amplitude configurável e nível DC
    periodo = 1 / frequencia;
    t = mod(x, periodo);
    y = (amplitude * (1 - 2 * abs(t - periodo / 2) / (periodo / 2))) + dc;
end


function y = generate_unit_centered_rectangular_pulse(x, center_time, width)
    % center_time: tempo central do pulso retangular
    % width: largura do pulso retangular
    % Calcule o tempo de início e fim do pulso com base no tempo central e na largura
    start_time = center_time - (width/2);
    end_time = center_time + (width/2);
    y = (x >= start_time) & (x <= end_time);
end

% Configuração de parâmetros
n = 4;
periodos = 2;
freq = 1;
amplitude_triangular = 1;
intervalos_quantizacao = 2^n;
delta_t = amplitude_triangular / intervalos_quantizacao; % Intervalo entre níveis de quantização.

% Nível DC desejado
dc_level = amplitude_triangular; % Altere para o valor desejado

% Criação do vetor de valores de x
x = linspace(0, periodos / freq, 100000);

% Cálculo das funções retangular e triangular
y_triangular = funcao_triangular(x, freq, amplitude_triangular, dc_level);

% Gráfico
subplot(5, 1, 1);
plot(x, y_triangular, 'r');
title('Função Triangular');
xlabel('x');
ylabel('y');
hold on;
tmpx = linspace(0, periodos / freq, intervalos_quantizacao);
tmpt = funcao_triangular(tmpx, freq, amplitude_triangular, dc_level);
stem(tmpx, tmpt, 'b.');
legend('Triangular', 'Pontos de Amostra');

% FFT da Função Triangular
subplot(5, 1, 2);
fft_triangular = fft(y_triangular);
shifted_fft_triangular = fftshift(fft_triangular);
stem(abs(shifted_fft_triangular), '.');
title('FFT da Função Triangular');
xlabel('x');
ylabel('y');

% IFFT da Função Triangular
subplot(5, 1, 3);
ifft_triangular = ifft(fft_triangular);
plot(x, ifft_triangular, 'r');
title('IFFT da Função Triangular');
xlabel('x');
ylabel('y');

% Função Triangular Quantizada
subplot(5, 1, 4);
triangular_quantizada = round(y_triangular * n);
triangular_quantizada = triangular_quantizada / max(triangular_quantizada);
plot(x, triangular_quantizada, 'r');
title('Função Triangular Quantizada');
xlabel('x');
ylabel('y');

% FFT da Função Triangular Quantizada
subplot(5, 1, 5);
fft_triangular_quantizada = fft(triangular_quantizada);
shifted_fft_triangular_quantizada = fftshift(fft_triangular_quantizada);
stem(abs(shifted_fft_triangular_quantizada), '.');
title('FFT da Função Triangular Quantizada');
xlabel('x');
ylabel('y');

% Função retangular em cada nível de quantização no mesmo gráfico
figure;
triangular_quantizada = round(y_triangular * n);
triangular_quantizada = triangular_quantizada / max(triangular_quantizada);
plot(x, triangular_quantizada, 'r');
for j = 0:intervalos_quantizacao:(intervalos_quantizacao*periodos)-1
    for i = 0:1:intervalos_quantizacao-1
        y = generate_unit_centered_rectangular_pulse(x, (j+i)*delta_t, delta_t/2);
        hold on;
        %plot(x, y);
        plot(x, y .* triangular_quantizada);
        
        %hold on;
        %plot(y);
        %plot(x, y);

        title(sprintf('Nível %d', i));
    endfor
endfor


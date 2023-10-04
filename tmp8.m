frequencia = 1;

function y = funcao_retangular_periodica(x, frequencia, duty_cycle)
    % Calcula a função retangular periódica com o ciclo de trabalho especificado
    start_time = 1 - (2/2);
    end_time = 1 + (2/2);
    y = x >= start_time & x<=end_time;
end

t = linspace(0, 100, 1000000);
sinal = funcao_retangular_periodica(t, 1, 0.5);
plot(t, sinal);
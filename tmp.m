% Parâmetros do filtro ideal
frequencia_de_corte = 1000; % Frequência de corte em Hz
taxa_de_amostragem = 5000; % Taxa de amostragem em Hz
ordem_do_filtro = 100; % Ordem do filtro

% Crie um vetor de frequências correspondentes à resposta do filtro
frequencias = linspace(0, taxa_de_amostragem, 1000);

% Crie a resposta em frequência do filtro ideal (passa-baixa)
filtro_ideal = zeros(size(frequencias));
filtro_ideal(frequencias <= frequencia_de_corte) = 1;

% Plote a resposta em frequência do filtro ideal
plot(frequencias, filtro_ideal);
title('Resposta em Frequência do Filtro Passa-Baixa Ideal');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% A resposta em frequência será uma caixa (1 para frequências abaixo da frequência de corte e 0 para frequências acima dela).

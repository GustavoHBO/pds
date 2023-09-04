%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analisador de frequências (utilizando FFT)
%
% autor: Elias J.
% data: 29/01/2020
% fs = frquencia de amostragem
% x = sinal de entrada
% X = vetor da resposta em frequência de x
% freq = vetor de frequências
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analisador de frequências (utilizando FFT)
%
% autor: Elias J.
% data: 23/07/2021
% fs = frquencia de amostragem
% x = sinal de entrada
% X = vetor da resposta em frequência de x
% freq = vetor de frequências
% use scale = true -> divide o vetor por 1/N (relação direta com a série de Fourier)
% use scale = false -> TDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [X, freq] = plot_fft (x, fs, scale=true, logscale=false, viewfase=false)

  N = length(x);
  T = N/fs; % período
  freq = linspace(0,N,N)/T;
  fc = ceil(N/2); % para ajustar os dados do vetor
  if scale
    X = fftn(x)/N;
    X = 2*X(1:fc);
  else
    X = fftn(x);
    X = X(1:fc);
  end

  if viewfase % visualização da fase
    subplot(2,1,1)
  end
  if logscale
    plot(freq(1:fc), 20*log10(abs(X*N)));
    ylabel('20log|X|')
  else
    plot(freq(1:fc), abs(X));
    ylabel('|X|')
  end
  title('Análise de Fourier')
  xlabel('freq (Hz)')
  grid on
  X = round(X*1000)/1000.0;
  if viewfase
    subplot(2,1,2)
    plot(freq(1:fc), atan2d(imag(X), real(X)),'.');
    ylabel('fase')
    xlabel('freq (Hz)')
    grid on
  end

end

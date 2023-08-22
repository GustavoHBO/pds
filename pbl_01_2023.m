clc;            %limpa a janela de comandos.
clear all;      %limpas as variáveis
close all;      %fecha todas as janelas


%%%%%%%%%%%%%%%%%%%%%% Equação da onda %%%%%%%%%

A = 1;      %amplitude da onda em Volts.
f = 1000;   %frequência da onda em Hetz.
P = 1/f;    %período em segudos.

% A frequencia de amostragem deve ser 2*f, segundo Nyquist.
fa = f*100000; %frequência de amostragem.
Ps = 1/fa;  %período de amostragem.

Pmax = 5*P - Ps;  %período de tempo máximo.
Omega = 2*pi*f;   %W = omega.
t = 0:Ps:Pmax;    %eixo do tempo.

y = A*sin(Omega*t);  %amplitudes | sinal de entrada.

%%%%%%%%%%%%%%%%%%%%%% Equação da onda no tempo %%%%%%%%%
figure(1);      %cria a figura 1
%plot(t,y, 'ro', t, y);      %desenha a figura 1
plot(t,y);      %desenha a figura 1

figure
[X,f] = plot_fft(y,fs);
axis([0 500 0 max(abs(X))])

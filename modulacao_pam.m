clc;            %limpa a janela de comandos.
clear all;      %limpas as variáveis
close all;      %fecha todas as janelas


%%%%%%%%%%%%%%%%%%%%%% Equação da onda %%%%%%%%%

A = 1;      %amplitude da onda em Volts.
f = 1000;   %frequência da onda em Hetz.
P = 1/f;    %período em segudos.
fa = f*100;   %frequência de amostragem.
Ps = 1/fa;  %período de amostragem.

Pmax = 5*P - Ps;  %período de tempo máximo.
t = 0:Ps:Pmax;    %eixo do tempo.

y = sin(2*pi*f*t);  %amplitudes | sinal de entrada.

%%%%%%%%%%%%%%%%%%%%%% Equação da onda no tempo %%%%%%%%%
figure(1);      %cria a figura 1
plot(t,y, 'ro', t, y);      %desenha a figura 1

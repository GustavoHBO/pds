clear all;
close all;
clc;

pkg load signal
pkg load symbolic

figure

w1 = 2*pi*10;
w2 = 2*pi*50;
w3 = 2*pi*90;

Fs = 1e3;

t = 0:1/Fs:1;

yb = sin(w1*t);
yt = yb + sin(w2*t) + sin(w3*t);

tam_yt = length(yt);
fre = (-tam_yt/2:tam_yt/2 - 1)/w1;
fft_yt = fft(yt, tam_yt);

filtro_low_pass = 150*((-1)*rectpuls(fre, 2*7.7) + rectpuls(fre, 2*8));

freqs_interesse = 0.007*(fft_yt.*filtro_low_pass);

yt_ifft = ifft(fft_yt);

yt_filtr = ifft(freqs_interesse);

subplot(6,1,1);
plot(t, yb);
title('Sinal esperado');

subplot(6,1,2);
plot(t, yt);
title('Sinal de entrada no tempo');

subplot(6,1,3);
stem(fre, abs(fftshift(fft_yt)), '.');
axis([-3 3]);
title('Sinal de entrada na frequência');

subplot(6,1,4);
plot(fre, fftshift(filtro_low_pass));
axis([-3 3]);
title('Filtro passa-baixa ideal');

subplot(6,1,5);
stem(fre, abs(fftshift(freqs_interesse)), '.');
axis([-3 3]);
title('Sinal de entrada filtrado na frequência');

subplot(6,1,6);
plot(t, yt_filtr);
axis([0 1 -1.1 1.1]);
title('Sinal de entrada filtrado reconstruído');

figure
ht = (1/2)*(square(40*2*pi*t) + 1);

ys = yt_filtr.*ht;

tam_ys = length(ys);
fre2 = (-tam_ys/2:tam_ys/2 - 1)/w1;

fft_ys = fft(ys, tam_ys);

filtro_reconstr = 250*((-1)*rectpuls(fre2, 2*7.5) + rectpuls(fre2, 2*8));

ys_filtr = (250/7e4)*(fft_ys.*filtro_reconstr);

ys_reconstr = ifft(fft_ys);

yb_reconstr = 2.1*(ifft(ys_filtr));

% subplot(6,1,1)
plot(t, ht, 'b', 'LineWidth', 1.5);
hold off;
title('Trem de pulsos retangulares', 'FontSize', 25);

xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);

grid on; % Habilitar a grade

legend('Trem de pulsos retangulares', 'FontSize', 25); % Adicione legendas se necessário

figure;
% stem(t, ys, '.', 'LineWidth', 1.5);
% hold on;
% plot(t, ys, 'b', 'LineWidth', 1.5);
axis([0 1 -1.1 1.1]);
% title('Sinal amostrado', 'FontSize', 25);

xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
% plot(t, yb);

stem(fre2, abs(fftshift(fft_ys)), '.', 'LineWidth', 1.5);
axis([-5 5]);
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
title('Sinal amostrado na frequência', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);


hold off;

figure;

plot(fre2, fftshift(filtro_reconstr), 'b', 'LineWidth', 1.5);
axis([-5 5]);
title('Filtro de reconstrução', 'FontSize', 25);
xlabel('Tempo (s)', 'FontSize', 25);
grid on; % Habilitar a grade
legend('Sinal do filtro de reconstrução', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);

figure;
stem(fre2, abs(fftshift(ys_filtr)), '.');
axis([-5 5]);
title('Sinal amostrado filtrado na frequência', 'FontSize', 25);
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);

legend('Sinal amostrado filtrado', 'FontSize', 25);



figure;

plot(t, yb_reconstr, 'b', 'LineWidth', 1.5);
axis([0 1 -1.1 1.1]);
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
title('Sinal amostrado reconstruído', 'FontSize', 25);
grid on; % Habilitar a grade
legend('Sinal amostrado reconstruído', 'FontSize', 25);
clear all;
close all;
clc;

pkg load signal
pkg load symbolic

figure('CloseRequestFcn', @(src, event) close_all_figures());

w1 = 2*pi*10;
w2 = 2*pi*50;
w3 = 2*pi*90;

Fs = 1e3;

t = 0:1/Fs:1;

yb = sin(w1*t);
yt = yb + sin(w2*t) + sin(w3*t);

tam_yt = length(yt);
fre = (-tam_yt/2:tam_yt/2 - 1)/1;
fft_yt = (1/500)*fft(yt, tam_yt);

filtro_low_pass = ((-1)*rectpuls(fre, 2*485) + rectpuls(fre, 2*600));

freqs_interesse = (fft_yt.*filtro_low_pass);

yt_ifft = ifft(fft_yt);

yt_filtr = 500*ifft(freqs_interesse);

figure('CloseRequestFcn', @(src, event) close_all_figures());
plot(t, yb);
title('Sinal esperado', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());
plot(t, yt);
title('Sinal de entrada no tempo', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());

stem(fre, abs(fftshift(fft_yt)), '.', 'LineWidth', 1.5);
axis([-200 200 0 1]);
title('Sinal de entrada na frequência', 'FontSize', 25);
grid on;
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());
plot(fre, fftshift(filtro_low_pass));
axis([-200 200 0 1]);
title('Filtro passa-baixa ideal', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());
stem(fre, abs(fftshift(freqs_interesse)), '.', 'LineWidth', 1.5);
axis([-200 200 0 1]);
title('Sinal de entrada filtrado na frequência', 'FontSize', 25);
grid on;
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());
plot(t, yt_filtr);
axis([0 1 -1 1]);
title('Sinal de entrada filtrado reconstruído', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal de entrada x(t) filtrado.', 'FontSize', 25);


ht = (1/2)*(square(0.5*w1*t) + 1);

ys = yt_filtr.*ht;

tam_ys = length(ys);
fre2 = (-tam_ys/2:tam_ys/2 - 1)/1;

fft_ys = (1/250)*fft(ys, tam_ys);

filtro_reconstr = ((-1)*rectpuls(fre2, 2*480) + rectpuls(fre2, 2*600));

ys_filtr = (fft_ys.*filtro_reconstr);

ys_reconstr = ifft(fft_ys);

yb_reconstr = 500*(ifft(ys_filtr));

% subplot(3,1,1)
figure('CloseRequestFcn', @(src, event) close_all_figures());
plot(t, ht);
title('Trem de pulsos retangulares', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Trem de pulsos h(t)', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());

plot(t, ys);
axis([0 1 -1.1 1.1]);
title('Sinal amostrado', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());

stem(fre2, abs(fftshift(fft_ys)), '.', 'LineWidth', 1.5);
axis([-200 200 0 1.1]);
title('Sinal amostrado na frequência', 'FontSize', 25);
grid on;
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado na frequência', 'FontSize', 25);
figure('CloseRequestFcn', @(src, event) close_all_figures());

plot(fre2, fftshift(filtro_reconstr));
axis([-200 200 0 1]);
title('Filtro de reconstrução', 'FontSize', 25);
grid on;
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Filtro de reconstrução δ(t)', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());
stem(fre2, abs(fftshift(ys_filtr)), '.', 'LineWidth', 1.5);
axis([-200 200 0 1.1]);
title('Sinal amostrado filtrado na frequência', 'FontSize', 25);
grid on;
xlabel('Frequência (Hz)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado e filtrado na frequência', 'FontSize', 25);

figure('CloseRequestFcn', @(src, event) close_all_figures());

plot(t, yb_reconstr);
hold on;
plot(t, sin(w1*t+0.5));
axis([0 1 -1 1]);
xlabel('Tempo (s)', 'FontSize', 25);
ylabel('Amplitude', 'FontSize', 25);
legend('Sinal amostrado reconstruído', 'Sinal Original', 'FontSize', 25);
title('Sinal amostrado reconstruído', 'FontSize', 25);
grid on;

% Callback function to close all figures
function close_all_figures(main_figure)
    % close all;
    exit;
end

pause;
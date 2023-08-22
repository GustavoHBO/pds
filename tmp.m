

fs = 5000;
n = -100:1/fs:100;

x = 0.8*cos(2*pi*100*n) + 2*sin(2*pi*200*n);

t = 0:1/2;
plot(x, t);

return;
figure
[X,f] = plot_fft(x,fs);
axis([0 500 0 max(abs(X))])

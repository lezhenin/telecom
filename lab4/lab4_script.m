close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

N = 1024;
Fs = 512;
Fc = 64;
F0 = 4;
M = 0.9;

t = (1:N)/Fs;
f = (-N/2:N/2-1) .* (Fs/N);

x = M * sin(2 * pi * F0 * t) - 0.5 * cos(2 * pi * F0/2 * t);

y_amod = ammod(x, Fc, Fs, 0, 1);
y_ssbm = ssbmod(x, Fc, Fs, 0, 'upper');

y_ademod = amdemod(y_amod, Fc, Fs, 0, 1);

s = fftshift(fft(x));
s_amod = fftshift(fft(y_amod));
s_ssbm = fftshift(fft(y_ssbm));

s_ademod = fftshift(fft(y_ademod));

figure(figure_properties{:})
hold on
plot(t, y_amod, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)

figure(figure_properties{:})
hold on
plot(f, abs(s_amod), 'r', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);

figure(figure_properties{:})
hold on
plot(t, y_ssbm, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)

figure(figure_properties{:})
hold on
plot(f, abs(s_ssbm), 'r', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);

figure(figure_properties{:})
hold on
plot(t, y_ademod, 'b', 'LineWidth', lw)
%plot(t, x, 'b', 'LineWidth', lw)

figure(figure_properties{:})
hold on
plot(f, abs(s_ademod), 'b', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);

close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

N = 512;
Fs = 512;
Fc = 48;
F0 = 4;
M = 1;

t = (1:N)/Fs;
f = (-N/2:N/2-1) .* (Fs/N);

x = M * cos(2 * pi * F0 * t); %- 0.5 * sin(2 * pi * F0/2 * t);

y_amod = ammod(x, Fc, Fs, 0, 1);
y_ssbm = ssbmod(x, Fc, Fs, 0, 'upper');

y_ademod = amdemod(y_amod, Fc, Fs, 0, 1);
y_ssbdemod = ssbdemod(y_ssbm, Fc, Fs);

s = fftshift(fft(x));
s_amod = fftshift(fft(y_amod));
s_ssbm = fftshift(fft(y_ssbm));

s_ademod = fftshift(fft(y_ademod));
s_ssbdemod = fftshift(fft(y_ssbdemod));

figure(figure_properties{:})
hold on
plot(t, y_amod, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s), 'b', 'LineWidth', lw)
plot(f, abs(s_amod), 'r', 'LineWidth', lw)
%xlim([-Fs/2, Fs/2]);
xlim([-Fc*2, Fc*2]);
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(t, y_ssbm, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s), 'b', 'LineWidth', lw)
plot(f, abs(s_ssbm), 'r', 'LineWidth', lw)
%xlim([-Fs/2, Fs/2]);
xlim([-Fc*2, Fc*2]);
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(t, y_ademod, 'b', 'LineWidth', lw)
% plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s_ademod), 'b', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(t, y_ssbdemod, 'b', 'LineWidth', lw)
% plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s_ssbdemod), 'b', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);
set(gca, 'FontSize', fs)

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

t = (1:N)/Fs;
f = (-N/2:N/2-1) .* (Fs/N);

x = cos(2 * pi * F0 * t);

y_pmod = pmmod(x, Fc, Fs, 5 * pi / 6);
y_fmod = fmmod(x, Fc, Fs, 12);

y_pdemod = pmdemod(y_pmod, Fc, Fs, 5 * pi / 6);
y_fdemod = fmdemod(y_fmod, Fc, Fs, 12);


s = fftshift(fft(x));
s_pmod = fftshift(fft(y_pmod));
s_fmod = fftshift(fft(y_fmod));

s_pdemod = fftshift(fft(y_pdemod));
s_fdemod = fftshift(fft(y_fdemod));

figure(figure_properties{:})
hold on
plot(t, y_pmod, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s), 'b', 'LineWidth', lw)
plot(f, abs(s_pmod), 'r', 'LineWidth', lw)
xlim([-Fc*2, Fc*2]);
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(t, y_fmod, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(s), 'b', 'LineWidth', lw)
plot(f, abs(s_fmod), 'r', 'LineWidth', lw)
xlim([-Fc*2, Fc*2]);
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(t, y_pdemod, 'b', 'LineWidth', lw)
%plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

% figure(figure_properties{:})
% hold on
% plot(f, abs(s_pdemod), 'b', 'LineWidth', lw)
% xlim([-Fc*2, Fc*2]);

figure(figure_properties{:})
hold on
plot(t, y_fdemod, 'b', 'LineWidth', lw)
%plot(t, x, 'b', 'LineWidth', lw)
set(gca, 'FontSize', fs)

% figure(figure_properties{:})
% hold on
% plot(f, abs(s_fdemod), 'b', 'LineWidth', lw)
% xlim([-Fc*2, Fc*2]);


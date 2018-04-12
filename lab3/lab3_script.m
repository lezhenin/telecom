close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

F0 = 5;
Fs = 512;
N = 2048;

t = (1:N)/Fs;
x = sin(2 * pi * F0 * t) - 0.5 * cos(2 * pi * F0/2 * t);
y = awgn(x, 3);

figure(figure_properties{:})
hold on
plot(t, y, 'r', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
xlim([min(t), max(t)]);
xlabel('t (s)')
legend('Noisy sginal', 'Signal')
set(gca, 'FontSize', fs)

X = fftshift(fft(x));
Y = fftshift(fft(y));
f = (-N/2:N/2-1) .* (Fs/N);

figure(figure_properties{:})
hold on
plot(f, abs(Y), 'r', 'LineWidth', lw)
plot(f, abs(X), 'b', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);
xlabel('f (Hz)')
legend('Noisy sginal spectrum', 'Signal spectrum')
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(Y), 'r', 'LineWidth', lw)
plot(f, abs(X), 'b', 'LineWidth', lw)
legend('Noisy sginal spectrum', 'Signal spectrum')
xlim([min(-F0*2), max(F0*2)]);
xlabel('f (Hz)')
set(gca, 'FontSize', fs)

% Filter design

Fpass = 6;               % Passband Frequency
Fstop = 12;              % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.01;            % Stopband Attenuation
flag  = 'scale';         % Sampling Flag

[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd = dfilt.dffir(b);

g = filter(b, 1, y);

figure(figure_properties{:})
hold on
plot(t, g, 'm', 'LineWidth', lw)
plot(t, x, 'b', 'LineWidth', lw)
xlim([min(t), max(t)]);
xlabel('t (s)')
legend('De-noised sginal', 'Signal')
set(gca, 'FontSize', fs)

G = fftshift(fft(g));

figure(figure_properties{:})
hold on
plot(f, abs(G), 'm', 'LineWidth', lw)
plot(f, abs(X), 'b', 'LineWidth', lw)
xlim([-Fs/2, Fs/2]);
xlabel('f (Hz)')
legend('De-noised sginal spectrum', 'Signal spectrum')
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
plot(f, abs(G), 'm', 'LineWidth', lw)
plot(f, abs(X), 'b', 'LineWidth', lw)
xlim([min(-F0*2), max(F0*2)]);
xlabel('f (Hz)')
legend('De-noised sginal spectrum', 'Signal spectrum')
set(gca, 'FontSize', fs)

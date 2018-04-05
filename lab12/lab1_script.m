close all
clear all

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

signal_type = 2;

N = 512;
Fs = 100;
Ts = 1/Fs;
F0 = 5;
T0 = 1/F0;

t = -Ts*(N-1)/2:Ts:Ts*(N-1)/2;

switch signal_type
    case 0
        x = sin(2*pi*F0*t) + 0.2*cos(2*pi*(F0/5)*t);
    case 1
        x = square(2*pi*F0*t, 30);
    case 2
        width = (Fs/F0)/2;
        t = [-Ts*((N-1)/2+width):Ts:-Ts*(N-1)/2, t];
        x = square(2*pi*F0*t);
        coeffs = ones(1, width)/width;
        x = filter(coeffs, 1, x);
        x = x(width+2:end);
        t = t(width+2:end);
    case 3
        x = double(mod(round(t/Ts), round((Fs/F0))) == 0);
    otherwise
        x = ones(0, length(t));
end

s = fft(x, N);
s = fftshift(s);
f = (Fs/N)*(-N/2:(N/2-1)); 

figure(figure_properties{:})
hold on
plot(t, x, 'LineWidth', lw)
xlim([min(t), max(t)])
ylim([-1.25, 1.25])
xlabel('t')
ylabel('x(t)')
set(gca, 'FontSize', fs)

figure(figure_properties{:})
plot(f, abs(s), 'LineWidth', lw)
ylim([0, max(abs(s)) * 1.1])
ylabel('|\Phi(f)|')
xlabel('f')
set(gca, 'FontSize', fs)


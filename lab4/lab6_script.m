close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

N = 512;

M = 8;

x = randi([0 M-1], N, 1);

% figure(figure_properties{:})
% hold on
% plot(x, '.');

y_pskmod = pskmod(x, M, pi/M);
y_pskmod_n = awgn(y_pskmod, 20); 

figure
scatter(real(y_pskmod), imag(y_pskmod), '.');

figure
scatter(real(y_pskmod_n), imag(y_pskmod_n), '.');

figure
eyediagram(y_pskmod, N/M)
close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 15, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;


t = 0:0.01:pi;

lpf = double(t < pi / 3);
hpf = double(t > 2 * pi / 3);
bpf = double(t > 1 * pi / 3) .* double(t < 2 * pi / 3); 
bsf = double(t < 1 * pi / 3) + double(t > 2 * pi / 3); 

figure(figure_properties{:})
plot(t, lpf, 'LineWidth', lw)
xticklabels({'0','\pi / 2','\pi'})
xticks([0 pi/2 pi])
axis([0, pi, 0, 1.5])
set(gca, 'FontSize', fs)

figure(figure_properties{:})
plot(t, hpf, 'LineWidth', lw)
xticklabels({'0','\pi / 2','\pi'})
xticks([0 pi/2 pi])
axis([0, pi, 0, 1.5])
set(gca, 'FontSize', fs)

figure(figure_properties{:})
plot(t, bpf, 'LineWidth', lw)
xticklabels({'0','\pi / 2','\pi'})
xticks([0 pi/2 pi])
axis([0, pi, 0, 1.5])
set(gca, 'FontSize', fs)

figure(figure_properties{:})
plot(t, bsf, 'LineWidth', lw)
xticklabels({'0','\pi / 2','\pi'})
xticks([0 pi/2 pi])
axis([0, pi, 0, 1.5])
set(gca, 'FontSize', fs)
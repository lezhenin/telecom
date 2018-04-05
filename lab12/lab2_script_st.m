close all
clear all

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

n = 10;

l = 50;
m = 10;

time = zeros(l, m);
time_fast = zeros(l, m);

for i = 1:l

i

x = (rand(1, i * 100) * 100) - 50;
y = (rand(1, i * 100) * 100) - 50;

for j = 1:m

tic
corr(x, y);
time(i, j) = toc;

tic
fast_corr(x, y);
time_fast(i, j) = toc;

end
end

mt = mean(time, 2);
mtf = mean(time_fast, 2);

figure(figure_properties{:})
hold on
semilogy(mt, 'LineWidth', lw)
semilogy(mtf, 'LineWidth', lw)
legend('Correlation', 'Fast Correlation', 'Location', 'northwest')
xlabel('N')
ylabel('t (s)')
xlim([1, length(mt)])
set(gca, 'FontSize', fs)


function r = corr(x, y)
    n = length(x);
    r = zeros(1, n);
    s_x = x;
    for i = 1:n
        r(i) = sum(s_x .* y) / n;
        s_x = circshift(s_x, 1);
    end
end

function r = fast_corr(x, y)
    r = ifft(conj(fft(x)) .* fft(y)) ./ length(x);

end
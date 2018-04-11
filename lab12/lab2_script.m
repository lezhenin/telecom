close all
clear all

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};
lw = 1.8;
fs = 16;

signal = [0 0 0 1 0 1 0 1 1 1 0 0 0 0 1 0];
sync = [1 0 1];

signal_len = length(signal);
sync_len = 3;
data_len = 8;

pos = 0:(signal_len-1);

[corr, lag] = xcorr(signal, sync);
corr = corr(signal_len:end);
lag = lag(signal_len:end);

max_corr_ind = (corr == max(corr));

figure(figure_properties{:})
stem(lag, corr, 'LineWidth', lw)
xticks(lag)
xlabel('Lag')
ylabel('Correlation')
set(gca, 'FontSize', fs)

figure(figure_properties{:})
hold on
stem(pos, signal, 'LineWidth', lw)
xticks(pos)
xlabel('t')
ylabel('s(t)')
set(gca, 'FontSize', fs)


for i = 1:length(max_corr_ind)
    if (max_corr_ind(i))
        lagged_sync = zeros(1, signal_len);
        sync_range = (lag(i):(lag(i)+sync_len-1)) + 1;
        lagged_sync(sync_range) = sync;
        figure(figure_properties{:})
        hold on
        stem(pos, signal, 'LineWidth', lw)
        stem(pos, lagged_sync, 'r.', 'LineWidth', lw)
        xticks(pos)
        xlabel('t')
        ylabel('s(t)')
        set(gca, 'FontSize', fs)
    end
end

data_start = min(lag(max_corr_ind));
data_range = (data_start+1:data_start+data_len) + sync_len;
data = signal(data_range)



close all

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10]};

signal_type = 0;

q = 1;

N = 2048 * q;
Fs = 256 * q;
Ts = 1/Fs;
F0 = 16;
T0 = 1/F0;

t = -Ts*(N-1)/2:Ts:Ts*(N-1)/2;

switch signal_type
    case 0
        x = sin(2*pi*F0*t);
    case 1
        x = square(2*pi*F0*t);
%         x = double((t > T0) & (t < (2*T0)));
    case 2
        x = square(2*pi*F0*t);
        width = (Fs/F0)/2;
        coeffs = ones(1, width)/width;
        init_state = ((1:(width-1)) / width) - 1;
        x = filter(coeffs, 1, x, init_state);
    case 3
        x = double(mod(round(t/Ts), round((Fs/F0))) == 0);
    otherwise
        x = ones(0, length(t));
end

[x, Fs] = audioread('/home/yurij/Загрузки/sfcwa.mp3');
x = x(:, 1)';
t = (0:(length(x)-1)) * (1/Fs);

N = length(x);

s = fft(x);
s = fftshift(s);
f = (Fs/N)*(-N/2:(N/2-1)); 


figure(figure_properties{:})
hold on
plot(t,x)
xlim([min(t), max(t)])
ylim([-1.25, 1.25])
xlabel('t (s)')
ylabel('f(t)')

figure(figure_properties{:})
plot(f, abs(s))
ylim([0, max(abs(s)) * 1.1])
xlabel('F (Hz)')

spectrogram(y, 481);

%sound(x, Fs)

y = filter(Num, 1, x);

s = fft(y);
s = fftshift(s);
f = (Fs/N)*(-N/2:(N/2-1)); 

figure(figure_properties{:})
hold on
plot(t,y)
xlim([min(t), max(t)])
ylim([-1.25, 1.25])
xlabel('t (s)')
ylabel('f(t)')

figure(figure_properties{:})
plot(f, abs(s))
ylim([0, max(abs(s)) * 1.1])
xlabel('F (Hz)')

sound(y, Fs)

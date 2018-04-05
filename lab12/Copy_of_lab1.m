close all

figure_properties = {'units', 'centimeters', 'position', [12, 10, 25, 8]};

signal_type = 2;

N = 1024;
Fs = 100;
Ts = 1/Fs;
F0 = 5;

t = 0:Ts:Ts*(N-1);

switch signal_type
    case 0
        x = sin(2*pi*F0*t);
    case 1
        x = square(2*pi*F0*t);
    case 2
        x = square(2*pi*F0*t);
        width = (Fs/F0)/2;
        coeffs = ones(1, width)/width;
        init_state = ((1:(width-1)) / width) - 1;
        x = filter(coeffs, 1, x, init_state);
    otherwise
        x = ones(0, length(t));
end

s = fft(x);
s = fftshift(s);
f = (Fs/N)*(-N/2:(N/2-1)); 


figure(figure_properties{:})
hold on
plot(t, x)
xlim([0, max(t)])
ylim([-1.25, 1.25])
xlabel('t (s)')
ylabel('sin(t)')

figure(figure_properties{:})
plot(f, abs(s))
ylim([0, max(abs(s)) * 1.1])
xlabel('F (Hz)')





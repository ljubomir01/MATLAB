clc 
clear all

%NF filtar 25 reda sa grani?nom u?estanoš?u od 2000 Hz koriš?enjem Hanovog prozora
fs = 11200;

N = 25
fn = 2000
hanov = hann(N+1);

b1 = fir1(N, fn/(fs/2), hanov);

N_fft = 1024;

B1 = fft(b1, N_fft)

B1a = abs(B1(1:N_fft/2));
F = angle(B1(1:N_fft/2));

n = 0:N_fft/2-1;

f = n*(fs/2)/(N_fft/2-1);
figure
subplot (3, 1, 1), plot (f, B1a), title ('NF filtar - Hanov prozor', 'FontSize', 14);
subplot (3, 1, 2), plot (f, 20*log10(B1a)), title ('NF filtar - Hanov prozor', 'FontSize', 14);
subplot(3, 1, 3),plot (f, F),title('Fazna karakteristika', 'FontSize', 14);
xlim([0 pi])

%PREKO FURIJEA

n = 0:1023;
x = cos(2*pi*1000/fs*n) + cos(2*pi*3000/fs*n)+ cos(2*pi*5000/fs*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

X = fft(x, N_fft)

y = ifft(X.*B1);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na LP ', 'FontSize', 14), xlim([0 100]);

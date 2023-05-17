clc 
clear all

%NF filtar 5 reda sa grani?nom u?estanoš?u od 2000 Hz koriš?enjem Hanovog prozora
fsr = 11200;

N = 5
fn = 2000
hanov = hann(N+1);

b1 = fir1(N, fn/(fsr/2), hanov);
a1 = 1;

N_fft = 1024;

B1 = fft(b1, N_fft)

B1a = abs(B1(1:N_fft/2));
F = angle(B1(1:N_fft/2));

n = 0:N_fft/2-1;

f = n*(fsr/2)/(N_fft/2-1);
figure
subplot (3, 1, 1), plot (f, B1a), title ('NF filtar - Hanov prozor', 'FontSize', 14);
subplot (3, 1, 2), plot (f, 20*log10(B1a)), title ('NF filtar - Hanov prozor', 'FontSize', 14);
subplot(3, 1, 3),plot (f, F),title('Fazna karakteristika', 'FontSize', 14);
xlim([0 pi])

%polovi i nule
% ovaj deo crta raspored polova i nula u odnosu na jedini?ni krug
figure
zplane (b1, a1);
%odredjivanje impulsnog odziva sistema
delta_impuls = [1 zeros(1, 99)];
g = filter (b1, a1, delta_impuls);
figure
stem (0: length(g)-1, g), title ('Impulsni odziv sistema');

%PREKO FURIJEA

n = 0:99;
x = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

X = fft(x, N_fft)

y = ifft(X.*B1);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na LP ', 'FontSize', 14), xlim([0 100]);

u_sim = [n;x]';

%kaskadna
%odredjivanje koeficijenata za kaskadnu realizaciju
zo = roots (b1);
sec1 = b1(1)* conv ([1 -zo(1)], [1 -zo(2)]);
sec2 =conv ([1 -zo(3)], [1 -zo(4)]);


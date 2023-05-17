M=34;

fs = 11200;
fn = [2000 4000];
blekmenov = blackman(M);

N = M-1; %potrebni red filtra
b = fir1 (N, fn/(fs/2), blekmenov);
%racunanje spektra u 1024 tacke koriscenjem FFT
N_fft = 1024;
B = fft (b, N_fft);

%odredjivanje amplitudskih karakteristika
Ba = abs(B(1:N_fft/2));
F = angle(B(1:N_fft/2));
%crtanje amplitudskih karakteristika na jednom grafiku
n = 0:N_fft/2-1;
f = n*(fs/2)/(N_fft/2-1);

subplot (3, 1, 1), plot (f, Ba), title ('NF filtar - Blekmenov prozor', 'FontSize', 14);
subplot (3, 1, 2), plot (f, 20*log10(Ba)), title ('NF filtar - Blekmenov prozor', 'FontSize', 14);
subplot(3, 1, 3),plot (f, F),title('Fazna karakteristika', 'FontSize', 14);
xlim([0 pi])

%PREKO FURIJEA

n = 0:1023;
x = cos(2*pi*1000/fs*n) + cos(2*pi*3000/fs*n)+ cos(2*pi*5000/fs*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

X = fft(x, N_fft)

y = ifft(X.*B);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na LP ', 'FontSize', 14), xlim([0 100]);
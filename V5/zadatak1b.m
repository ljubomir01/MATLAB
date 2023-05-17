clc
clear all

N=4;
fs = 11200;
fn = 4000; 
hamingov = hamming(N+1);

b = fir1 (N, fn/(fs/2),'high', hamingov);

%racunanje spektra u 1024 tacke koriscenjem FFT
N_fft = 1024;
B = fft (b, N_fft);
%odredjivanje amplitudskih karakteristika
Ba = abs(B(1:N_fft/2));
F = angle(B(1:N_fft/2));
%crtanje amplitudskih karakteristika na linearnoj skali
n = 0:N_fft/2-1;
f = n*(fs/2)/(N_fft/2-1);

figure
subplot (3, 1, 1), plot (f, Ba), title ('VF filtar - Hamingov prozor', 'FontSize', 14);
subplot (3, 1, 2), plot (f, 20*log10(Ba)), title ('VF filtar - Hamingov prozor', 'FontSize', 14);
subplot(3, 1, 3),plot (f, F),title('Fazna karakteristika', 'FontSize', 14);
xlim([0 pi])

%preko f-je filter

n = 0:99;
u = cos(2*pi*1000/fs*n) + cos(2*pi*3000/fs*n)+ cos(2*pi*5000/fs*n);

figure
subplot(2, 1, 1), plot(n, u), title ('Pobuda u', 'FontSize', 14);
xlim([0 100]);

y = filter(b,1,u);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na HP ', 'FontSize', 14), xlim([0 100]);
b %KOEFICIJENTI b !!!!!!!!!
u_sim = [n;u]';

%kaskadna realizacija

roots([0.0214 -0.232 0.4932 -0.232 0.0214])
%onda se zdruze odgovarajuci clanovi da imamo samo realne
%koeficijente... Drugog reda treba da bude sekcije!
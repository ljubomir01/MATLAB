%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija VF filtra
fp = 1500;
fs = 2500;
ap = 1;
as = 40;
%Projektovanje VF filtra
f = [fp fs];
a = [0 1];
dev = [10^(-as/20) (10^(ap/20)-1)/(10^(ap/20)+1)];%odredjivanje dozvoljenih odstupanja za svaki opseg
[n, fo, ao, w] = firpmord (f, a, dev, fsr);
n = 5; %5 red !!!!!!!
b = firpm (n, fo, ao, w);


%Odredjivanje amplitudskih karakteristika
N_fft = 1024;
B = fft (b, N_fft);
Ba = abs(B(1:N_fft/2));
F = angle(B(1:N_fft/2));
%crtanje amplitudskih karakteristika na jednom grafiku
n = 0:N_fft/2-1;
w = n*fsr/(2*(N_fft/2-1));
figure;
subplot (3, 1, 1); plot (w, Ba); axis ([0 fsr/2 0 1.2]);
title ('Amplitudska karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma - linearna osa', 'FontSize', 14);
subplot (3, 1, 2); plot (w, 20*log10(Ba)); axis ([0 fsr/2 -100 10]);
title ('Amplitudska karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma - logaritamska osa', 'FontSize', 14);
subplot (3, 1, 3); plot (w, F); title ('Fazna karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma');
xlim([0 pi])


%PREKO f-je filter

n = 0:99;
u = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, u), title ('Pobuda u', 'FontSize', 14);
xlim([0 100]);

y = filter(b,1,u);


subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na VF ', 'FontSize', 14), xlim([0 100]);

b %KOEFICIJENTI b !!!!!!!!!
u_sim = [n;u]';

%kaskadna realizacija

roots([0.1212 -0.1492 -0.302 0.6216 -0.302 -0.1492 0.1212])
%onda se zdruze odgovarajuci clanovi da imamo samo realne
%koeficijente... Drugog reda treba da budu sekcije!
%definisanje dva kompleksna eksponencijalna signala duzine 128 odbiraka
n = 0 : 127;
N = 128;
%prvi signal cija se ucestanost poklapa sa ucestanoscu na kojoj se racuna
%DFT
x = 10000*cos(2*pi*35.5/N*n)+100*cos(2*pi*40/N*n)+100*cos(2*pi*60/N*n);
%racunanje spektara oba signal koriscenjem DFT
X = 2*abs(fft(x))/N;
X = 20*log10(X);
%crtanje amplitudskih spektara u prirodnom redosledu
subplot (2, 1, 1), stem (n, (X));
title ('Spektar kompleksnog signala, x');
axis([0 64 0 130])

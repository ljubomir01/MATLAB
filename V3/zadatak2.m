%definisanje dva kompleksna eksponencijalna signala duzine 128 odbiraka
n = 0 : 127;
N = 128;
%prvi signal cija se ucestanost poklapa sa ucestanoscu na kojoj se racuna

x = 10000*cos(2*pi*35.5/N*n) + 100*cos(2*pi*40/N*n) + 100*cos(2*pi*60/N*n);
%racunanje spektara oba signal koriscenjem DFT
X1 = 2*abs(fft(x));
X1 = 20*log10(X1);
%crtanje amplitudskih spektara u prirodnom redosledu
X2 = 2*abs(fft(x,64));
X2 = 20*log10(X2);
X3 = 2*abs(fft(x,256));
X3 = 20*log10(X3);
X4 = 2*abs(fft(x,512));
X4 = 20*log10(X4);
% ISTO I ZA PREOSTALE VREDNOSTI N !!!
subplot (5, 1, 1), stem(0:length(x)-1, x), title ('Diskretni signal x(n)');
subplot (5, 1, 2), stem(0:length(X1)-1, abs(X1)), title ('Amplitudski spektar |X(k)|, za N=128');
subplot (5, 1, 3), stem(0:length(X2)-1, abs(X2)), title ('Amplitudski spektar |X(k)|, za N=64');
subplot (5, 1, 4), stem(0:length(X3)-1, abs(X3)), title ('Amplitudski spektar |X(k)|, za N=256');
subplot (5, 1, 5), stem(0:length(X4)-1, abs(X4)), title ('Amplitudski spektar |X(k)|, za N=512');
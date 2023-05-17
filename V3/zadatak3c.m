%Broj tacaka u kojima se racuna DFT
N=128;
n=0:N-1;
%Definicija signala ciji spektar racunamo
x1=10000*cos(2*pi*35.5*n/N)+100*cos(2*pi*37*n/N)+100*cos(2*pi*40*n/N);
%Odredjivanje amplitudske karakteristike, pravougaoni prozor
X1=2*abs(fft(x1))/N;
%Izracunavanje karakteristike u dB
X1=20*log10(X1);
%Crtanje karakteristike
subplot (2, 2, 1), stem(n, X1);
title('Spektar signala x_1(n)');
%Umesto da crtamo 64 odbirka crtacemo samo prvih 32 radi bolje
%ilustracije 
axis([0 128 0 80]);

%Modifikacija signala x1(n) tako da se ucestanost prve komponente nalazi
%izmedju dve tacke u kojima racunamo DFT
x2=10000*cos(2*pi*35.5*n/N)+100*cos(2*pi*37*n/N)+100*cos(2*pi*40*n/N);
%Odredjivanje amplitudske karakteristike, pravougaoni prozor
X2=2*abs(fft(x2))/N;
X2=20*log10(X2);
subplot (2, 2, 2), stem(n, X2);
title('Spektar signala x_2(n)');
axis([0 128 0 80]);
%Trougaoni prozor
w=triang(N)';
x3=x2.*w;
X3=2*abs(fft(x3))/N;
X3=20*log10(X3);
subplot (2, 2, 3), stem(n, X3);
title('Trougaoni prozor');
axis([0 128 0 80]);
%Hanov prozor
w=hanning(N)';
x4=x2.*w;
X4=2*abs(fft(x4))/N;
X4=20*log10(X4);
subplot (2, 2, 4), stem(n, X4);
title('Hanov prozor');
axis([0 128 0 80]);
figure
%Hemingov prozor
w=hamming(N)';
x5=x2.*w;
X5=2*abs(fft(x5))/N;
X5=20*log10(X5);
subplot (2, 2, 1), stem(n, X5);
title('Hemingov prozor');
axis([0 128 0 80]);
%Blekmenov prozor
w=blackman(N)';
x6=x2.*w;
X6=2*abs(fft(x6))/N;
X6=20*log10(X6);
subplot (2, 2, 2), stem(n, X6);
title('Blekmenov prozor');
axis([0 128 0 80]);
%Kajzerov prozor, beta = 4
w=kaiser(N,4)';
x7=x2.*w;
X7=2*abs(fft(x7))/N;
X7=20*log10(X7);
subplot (2, 2, 3), stem(n, X7);
title('Kajzerov prozor \beta=4');
axis([0 128 0 80]);
%Kajzerov prozor, beta = 9
w=kaiser(N,9)';
x8=x2.*w;
X8=2*abs(fft(x8))/N;
X8=20*log10(X8);
subplot (2, 2, 4), stem(n, X8);
title('Kajzerov prozor \beta=9');
axis([0 128 0 80]);


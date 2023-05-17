%Opis LVN DS pomocu opearatorskih polinoma
a = [0.96875 -1 0.96875 -0.53125];
b = [0.1094 0.1094 0.1094 0.1094];
%definisanje ulaznog signala duzine 64 odbiraka
n = 0 : 255;
fs = 48000;
f1 = 500;
f2 = 12000;
u = sin(2*pi*f1/fs*n)+0.1*sin(2*pi*f2/fs*n);
figure
stem (n, u); title ('Ulaz');
%izracunavanje odziva u vremenskom domenu
y1 = filter (b, a, u);
figure
subplot (3, 1, 1), stem (n, y1); title ('Izlaz racunat pomocu funkcije filter'); 

%vrednost amplitudske i fazne karakteristike na ucestanosti f1
w = 2*pi*f1/fs;
%prenosna karakteristika sistema u frekvencijskom domenu
G = (0.1094+0.1094*exp(-1i*w)+0.1094*exp(-1i*2*w)+0.1094*exp(-1i*3*w))./(0.96875-1*exp(-1i*w)+0.96875*exp(-1i*2*w)-0.53125*exp(-1i*3*w));
%amplitudska karakteristika
A_f1 = abs (G);
%fazna karakteristika
F_f1 = angle (G);
%vrednost amplitudske i fazne karakteristike na ucestanosti f2
w = 2*pi*f2/fs;
G = (0.1094+0.1094*exp(-1i*w)+0.1094*exp(-1i*2*w)+0.1094*exp(-1i*3*w))./(0.96875-1*exp(-1i*w)+0.96875*exp(-1i*2*w)-0.53125*exp(-1i*3*w));
A_f2 = abs (G);
F_f2 = angle (G);
%izracunavanje odziva na osnovu modikacije amplitude i faze komponenti
y2 = A_f1*sin(2*pi*f1/fs*n+F_f1)+A_f2*0.1*sin(2*pi*f2/fs*n+F_f2);
subplot (3, 1, 2), stem (n, y2); title ('Izlaz racunat modifikacijom amplitude i faze prisutnih komponenti');
%greska izmedju dva nacina racunanja
subplot (3, 1, 3), stem (n, y1-y2); title ('Greska izmedju dva pristupa'); 
clc
clear all

fsr = 11200;
n = 1:fsr
x = cos(2*pi*1000/11200 * n) + cos(2*pi*3000/11200 * n) + cos(2*pi*5000/11200 * n)

struct.mode = 'fixed'; 
struct.roundmode = 'floor'; 
struct.overflowmode = 'saturate'; 
struct.format = [4 3]; 
q1 = quantizer(struct);

struct.mode = 'fixed'; 
struct.roundmode = 'round'; 
struct.overflowmode = 'saturate'; 
struct.format = [4 3]; 
q2 = quantizer(struct);

x_q1 = quantize(q1, x);
x_q2 = quantize(q2, x);

fp1 = 3500;
fp2 = 4500;
fs1 = 3800;
fs2 = 4100;
ap1 = 1;
ap2 = 1;
as = 40;
%Projektovanje PO filtra
f = [fp1 fs1 fs2 fp2];

a = [1 0 1];
dev = [(10^(ap1/20)-1)/(10^(ap1/20)+1) 10^(-as/20) (10^(ap2/20)-1)/(10^(ap2/20)+1)];
[n_fir, fo, ao, w] = firpmord (f, a, dev, fsr);
b_fir = firpm (n_fir, fo, ao, w);
a_fir = 1;

%Racunanje amplitudske karakteristike NF filtra
B_nf = fft (b_fir, fsr);
Ba_nf = abs (B_nf(1:fsr/2));

%Odredjivanje odziva sistema na ulazni signal u slucaju da nema
%kvantizacije ulaznog signala
y1 = filter (b_fir, a_fir, x);
y1_q = filter(b_fir, a_fir, x_q1);
y2_q = filter(b_fir, a_fir, x_q2);

X = fft (x, fsr);
Xa = abs (X(1:fsr/2));

X1_q = fft (x_q1, fsr);
X1a_q = abs (X1_q(1:fsr/2));

X2_q = fft (x_q2, fsr);
X2a_q = abs (X2_q(1:fsr/2));

Y1 = fft (y1, fsr);
Y1a = abs (Y1(1:fsr/2));
Y1_q = fft (y1_q, fsr);
Y1a_q = abs (Y1_q(1:fsr/2));
Y2_q = fft (y2_q, fsr);
Y2a_q = abs (Y2_q(1:fsr/2));

figure
% title('PO fp = 3500 fs = 4000 ap = 1 as = 40');
subplot(4, 3, 1), plot(n, x), xlim([0 1024]);
subplot(4, 3, 2), plot(n, x_q1), xlim([0 1024]), title('Pobuda');
subplot(4, 3, 3), plot(n, x_q2), xlim([0 1024]);

subplot(4, 3, 4), plot(n, y1), xlim([0 1024]);
subplot(4, 3, 5), plot(n, y1_q), xlim([0 1024]), title('Odziv');
subplot(4, 3, 6), plot(n, y2_q), xlim([0 1024]);

subplot(4, 3, 7), plot(0:fsr/2-1, Xa(1:fsr/2));
hold on
plot((0:fsr/2-1), Ba_nf*max(Xa));
subplot(4, 3, 8), plot(0:fsr/2-1, X1a_q(1:fsr/2))
hold on
plot((0:fsr/2-1), Ba_nf*max(X1a_q)), title('Spektri pobuda');
subplot(4, 3, 9), plot(0:fsr/2-1, X2a_q(1:fsr/2));
hold on
plot((0:fsr/2-1), Ba_nf*max(X2a_q))

subplot(4, 3, 10), plot(0:fsr/2-1, Y1a(1:fsr/2));
subplot(4, 3, 11), plot(0:fsr/2-1, Y1a_q(1:fsr/2)), title('Spektri odziv');
subplot(4, 3, 12), plot(0:fsr/2-1, Y2a_q(1:fsr/2));

y1err = y1 - y1_q;
y2err = y1 - y2_q;

figure
subplot(2, 1, 1), plot(n, y1err), xlim([0 1024]), title('Greska kvantizacije 1');
subplot(2, 1, 2), plot(n, y2err), xlim([0 1024]), title('Greska kvantizacije 2');

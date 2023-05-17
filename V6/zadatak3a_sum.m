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


%Definisanje parametara ulaznog signala 
fsr = 11200;
n = 1:fsr
u = cos(2*pi*1000/11200 * n) + cos(2*pi*3000/11200 * n) + cos(2*pi*5000/11200 * n)

%Snaga ulaznog signala
u_fft = fft (u, 1024);
PS_u = u_fft.*conj(u_fft)/(1024^2);
P_u = sum (PS_u);

%Kvantizacija ulaznog signala
u8 = quantize (q1, u);
u16 = quantize (q2, u);

%Odredjivanje gresaka ulaznog signala
u_err8 = u - u8;
u_err16 = u - u16;

%Snaga suma kvantizacije
u_err8_fft = fft (u_err8, 1024);
PS_u_err8 = u_err8_fft.*conj(u_err8_fft)/(1024^2);
P_u_err8 = sum (PS_u_err8);
u_err16_fft = fft (u_err16, 1024);
PS_u_err16 = u_err16_fft.*conj(u_err16_fft)/(1024^2);
P_u_err16 = sum (PS_u_err16);

%Odnos signal/sum za kvantizovani ulazni signal
SNR_u8 = 10*log10(P_u/P_u_err8);
SNR_u16 = 10*log10(P_u/P_u_err16);

disp (sprintf ('SNR za ulazni signal u slucaju A/D konverzije 1: %f dB', SNR_u8));
disp (sprintf ('SNR za ulazni signal u slucaju A/D konverzije 2: %f dB', SNR_u16));

%Definisanje FIR LVN DS
%Specifikacija NF filtra
fp = 3500;
fs = 4000;
ap = 1;
as = 40;
%Projektovanje NF filtra
f = [fp fs];
a = [1 0];
dev = [(10^(ap/20)-1)/(10^(ap/20)+1) 10^(-as/20)];%odredjivanje dozvoljenih odstupanja za svaki opseg
[n_fir, fo, ao, w] = firpmord (f, a, dev, fsr);
b_fir = firpm (n_fir, fo, ao, w);
a_fir = 1;
%Racunanje amplitudske karakteristike NF filtra
B_nf = fft (b_fir, 1024);
Ba_nf = abs (B_nf(1:512));

%Odredjivanje odziva sistema na ulazni signal u slucaju da nema
%kvantizacije ulaznog signala
y = filter (b_fir, a_fir, u);

%Snaga izlaznog signala
y_fft = fft (y, 1024);
PS_y = y_fft.*conj(y_fft)/(1024^2);
P_y = sum (PS_y);

%Odredjivanje odziva sistema u slucaju kada ima kvantizacije ulaznog
%signala
y8 = filter (b_fir, a_fir, u8);
y16 = filter (b_fir, a_fir, u16);

%Odredjivanje gresaka izlaznog signala
y_err8 = y - y8;
y_err16 = y - y16;

%Snaga suma kvantizacije
y_err8_fft = fft (y_err8, 1024);
PS_y_err8 = y_err8_fft.*conj(y_err8_fft)/(1024^2);
P_y_err8 = sum (PS_y_err8);
y_err16_fft = fft (y_err16, 1024);
PS_y_err16 = y_err16_fft.*conj(y_err16_fft)/(1024^2);
P_y_err16 = sum (PS_y_err16);

%Odnos signal/sum za izlazni signal u slucaju koriscenja kvantiyovanog
%ulaznog signala
SNR_y8 = 10*log10(P_y/P_y_err8);
SNR_y16 = 10*log10(P_y/P_y_err16);

disp (sprintf ('SNR za izlazni signal u slucaju A/D konverzije 1: %f dB', SNR_y8));
disp (sprintf ('SNR za izlazni signal u slucaju A/D konverzije 2: %f dB', SNR_y16));

%Crtanje suma kvantizacije za ulazni i izlazni signal
title ('Sum kvantizacije');
subplot (4, 1, 1), plot (n, u_err8), title ('Ulazni signal sum kvantizacije 1', 'FontSize', 14);
subplot (4, 1, 2), plot (n, u_err16), title ('Ulazni signal sum kvantizacije 2', 'FontSize', 14);
subplot (4, 1, 3), plot (n, y_err8), title ('Izlazni signal sum kvantizacije 1', 'FontSize', 14);
subplot (4, 1, 4), plot (n, y_err16), title ('Izlazni signal sum kvantizacije 2', 'FontSize', 14);


figure;
%Crtanje spektra suma kvantizacije ulaznog signala za slucaj kada se
%koristi 8 bita
subplot (3, 1, 1), plot ([0 : fsr/1024 : 511*fsr/1024], PS_u_err8(1:512));
title ('Spektar signala greske kvantizacije ulaznog signala 1', 'FontSize', 14);
%Crtanje amplitudske karakteristike NF FIR filtra koji se koristi u primeru
subplot (3, 1, 2), plot ([0 : fsr/1024 : 511*fsr/1024], Ba_nf);
title ('Amplitudska karakteristika FIR NF filtra', 'FontSize', 14);
%Crtanje spektra suma koji se pojavljuje u izlaznom signalu kao posledica kvantizacije ulaznog signala za slucaj kada se
%koristi 8 bita
subplot (3, 1, 3), plot ([0 : fsr/1024 : 511*fsr/1024], PS_y_err8(1:512));
title ('Spektar suma u izlaznom signalu', 'FontSize', 14);

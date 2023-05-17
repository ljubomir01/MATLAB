%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija NF filtra
fp = 3500;
fs = 4000;
ap = 1;
as = 40;
%Projektovanje NF filtra
f = [fp fs];
a = [1 0];
dev = [(10^(ap/20)-1)/(10^(ap/20)+1) 10^(-as/20)];%odredjivanje dozvoljenih odstupanja za svaki opseg
[n, fo, ao, w] = firpmord (f, a, dev, fsr);
b_nf = firpm (n, fo, ao, w);
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
b_vf = firpm (n, fo, ao, w);
%Specifikacija PO filtra
fp1 = 1500;
fp2 = 2500;
fs1 = 1200;
fs2 = 2800;
ap = 1;
as1 = 40;
as2 = 40;
%Projektovanje PO filtra
f = [fs1 fp1 fp2 fs2];
a = [0 1 0];
%odredjivanje dozvoljenih odstupanja za svaki opseg
dev = [10^(-as1/20) (10^(ap/20)-1)/(10^(ap/20)+1) 10^(-as2/20)];
[n, fo, ao, w] = firpmord (f, a, dev, fsr);
b_po = firpm (n, fo, ao, w);
%Specifikacija NO filtra
fp1 = 3500;
fp2 = 4500;
fs1 = 3800;
fs2 = 4100;
ap1 = 1;
ap2 = 1;
as = 40;
%Projektovanje NO filtra
f = [fp1 fs1 fs2 fp2];
a = [1 0 1];
%odredjivanje dozvoljenih odstupanja za svaki opseg
dev = [(10^(ap1/20)-1)/(10^(ap1/20)+1) 10^(-as/20) (10^(ap2/20)-1)/(10^(ap2/20)+1)];
[n, fo, ao, w] = firpmord (f, a, dev, fsr);
b_no = firpm (n, fo, ao, w);
%Odredjivanje amplitudskih karakteristika
N_fft = 1024;
B_nf = fft (b_nf, N_fft);
B_vf = fft (b_vf, N_fft);
B_po = fft (b_po, N_fft);
B_no = fft (b_no, N_fft);
Ba_nf = abs(B_nf(1:N_fft/2));
Ba_vf = abs(B_vf(1:N_fft/2));
Ba_po = abs(B_po(1:N_fft/2));
Ba_no = abs(B_no(1:N_fft/2));
F_nf = angle(B_nf(1:N_fft/2));
F_vf = angle(B_vf(1:N_fft/2));
F_po = angle(B_po(1:N_fft/2));
F_no = angle(B_no(1:N_fft/2));
%crtanje amplitudskih karakteristika na jednom grafiku
n = 0:N_fft/2-1;
w = n*fsr/(2*(N_fft/2-1));
figure;
subplot (3, 1, 1); plot (w, Ba_nf); axis ([0 fsr/2 0 1.2]);
title ('Amplitudska karakteristika NF filtra projektovanog koriscenjem Parks-McClellan algoritma - linearna osa', 'FontSize', 14);
subplot (3, 1, 2); plot (w, 20*log10(Ba_nf)); axis ([0 fsr/2 -100 10]); 
title ('Amplitudska karakteristika NF filtra projektovanog koriscenjem Parks-McClellan algoritma - logaritamska osa', 'FontSize', 14);
subplot (3, 1, 3); plot (w, F_nf); 
title ('Fazna karakteristika NF filtra projektovanog koriscenjem Parks-McClellan algoritma');
xlim([0 pi]);
figure;
subplot (3, 1, 1); plot (w, Ba_vf); axis ([0 fsr/2 0 1.2]);
title ('Amplitudska karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma - linearna osa', 'FontSize', 14);
subplot (3, 1, 2); plot (w, 20*log10(Ba_vf)); axis ([0 fsr/2 -100 10]);
title ('Amplitudska karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma - logaritamska osa', 'FontSize', 14);
subplot (3, 1, 3); plot (w, F_vf); title ('Fazna karakteristika VF filtra projektovanog koriscenjem Parks-McClellan algoritma');
xlim([0 pi])
figure;
subplot (3, 1, 1); plot (w, Ba_po); axis ([0 fsr/2 0 1.2]); 
title ('Amplitudska karakteristika PO filtra projektovanog koriscenjem Parks-McClellan algoritma - linearna osa', 'FontSize', 14);
subplot (3, 1, 2); plot (w, 20*log10(Ba_po)); axis ([0 fsr/2 -100 10]); 
title ('Amplitudska karakteristika PO filtra projektovanog koriscenjem Parks-McClellan algoritma - logaritamska osa', 'FontSize', 14);
subplot (3, 1, 3); plot (w, F_po); title ('Fazna karakteristika PO filtra projektovanog koriscenjem Parks-McClellan algoritma');
xlim([0 pi])
figure;
subplot (3, 1, 1); plot (w, Ba_no); axis ([0 fsr/2 0 1.2]); 
title ('Amplitudska karakteristika NO filtra projektovanog koriscenjem Parks-McClellan algoritma - linearna osa', 'FontSize', 14);
subplot (3, 1, 2); plot (w, 20*log10(Ba_no)); axis ([0 fsr/2 -100 10]); 
title ('Amplitudska karakteristika NO filtra projektovanog koriscenjem Parks-McClellan algoritma - logaritamska osa', 'FontSize', 14);
subplot (3, 1, 3); plot (w, F_no); title ('Fazna karakteristika NO filtra projektovanog koriscenjem Parks-McClellan algoritma');
xlim([0 pi])


%PREKO FURIJEA

n = 0:1023;
x = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(5, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

X = fft(x, N_fft)

y_nf = ifft(X.*B_nf);
y_vf = ifft(X.*B_vf);
y_po = ifft(X.*B_po);
y_no = ifft(X.*B_no);

subplot(5, 1, 2), plot(1:numel(y), y_nf), title ('Odziv na NF ', 'FontSize', 14), xlim([0 100]);
subplot(5, 1, 3), plot(1:numel(y), y_vf), title ('Odziv na VF ', 'FontSize', 14), xlim([0 100]);
subplot(5, 1, 4), plot(1:numel(y), y_po), title ('Odziv na PO ', 'FontSize', 14), xlim([0 100]);
subplot(5, 1, 5), plot(1:numel(y), y_no), title ('Odziv na NO ', 'FontSize', 14), xlim([0 100]);
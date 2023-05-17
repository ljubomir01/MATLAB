%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija NF filtra
fp = 1500;
fs = 2500;
ap = 1;
as = 40;
%Odredjivanje minimalnog reda IIR filtra, Cebisevljeva aproksimacija prve vrste 
[n1, Wn1] = cheb1ord (fp/(fsr/2), fs/(fsr/2), ap, as);
%Projektovanje NF IIR filtra, Cebisevljeva aproksimacija prve vrste
[b1, a1] = cheby1 (n1, ap, Wn1, 'low');
%Crtanje amplitudskih i faznih karakteristika IIR filtara
freqz(b1,a1,1024,fsr);


n = 0:1023;
x = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

y = filter(b,a,x);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na NF ', 'FontSize', 14), xlim([0 100]);
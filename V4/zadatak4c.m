%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija PO filtra
fp = [1500 3500];
fs = [500 4500];
ap = 1;
as = 40;
%Odredjivanje minimalnog reda IIR filtra, Cebisevljeva aproksimacija druge vrste 
[n2, Wn2] = cheb2ord (fp/(fsr/2), fs/(fsr/2), ap, as);
%Projektovanje NF IIR filtra, Cebisevljeva aproksimacija druge vrste
[b2, a2] = cheby2 (n2, as, Wn2);
%Crtanje amplitudskih i faznih karakteristika IIR filtara
freqz(b2,a2,1024,fsr);

n = 0:1023;
x = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

y = filter(b,a,x);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na PO ', 'FontSize', 14), xlim([0 100]);
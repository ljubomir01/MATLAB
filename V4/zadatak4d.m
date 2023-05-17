%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija NO filtra
fp = [500 4500];
fs = [1500 3500];
ap = 1;
as = 40;
%Odredjivanje minimalnog reda IIR filtra
[n, Wn] = buttord (fp/(fsr/2), fs/(fsr/2), ap, as);
%Projektovanje NF IIR filtra
[b, a] = butter (n, Wn, 'stop');
%Crtanje amplitudske i fazne karakteristike IIR filtra
freqz(b,a,1024,fsr);

n = 0:1023;
x = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

y = filter(b,a,x);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na NO ', 'FontSize', 14), xlim([0 100]);
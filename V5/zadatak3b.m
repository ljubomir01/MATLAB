%Ucestanost odabiranja u sistemu
fsr = 11200;
%Specifikacija VF filtra
fp = 4500;
fs = 3500;
ap = 1;
as = 40;
%Odredjivanje minimalnog reda IIR filtra, elipticka aproksimacija
[n, Wn] = ellipord (fp/(fsr/2), fs/(fsr/2), ap, as);
%Projektovanje PO IIR filtra, elipticka aproksimacija prve vrste
[b, a] = ellip (n, ap, as, Wn,'high')
%Crtanje amplitudske i fazne karakteristike IIR filtra
freqz(b,a,1024,fsr);

n = 0:299;
u = cos(2*pi*1000/fsr*n) + cos(2*pi*3000/fsr*n)+ cos(2*pi*5000/fsr*n);

figure
subplot(2, 1, 1), plot(n, u), title ('Pobuda u', 'FontSize', 14);
xlim([0 100]);

y = filter(b,a,u);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na VF ', 'FontSize', 14), xlim([0 100]);

u_sim = [n;u]';

roots([0.0193 0.018 0.0333 0.018 0.0193])
roots([1 3.0561 3.8539 2.3188 0.5612])
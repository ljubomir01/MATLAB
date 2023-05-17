%Definisanje trajanja intervala na kojem se posmatra signal u sekundama
Tmax=0.02;
%Definisanje ucestanosti na kojima se nalaze komponente u signalu
fk=[100 1200 1930];
%Definisanje kontinualnog signala, trajanja 5 ms
tk = 0 : 0.00001: Tmax;
Xk = 10*sin (2*pi*fk(1)*tk) -2*sin (2*pi*fk(2)*tk) + 5*cos (2*pi*fk(3)*tk);
%Odredjivanje maksimalne ucestanosti koja je prisutna u signalu
fk_max = max(fk);
%Definisanje ucestanosti odabiranja
fs = 2*fk_max; Ts = 1/fs;
%Formiranje diskretnog signala
td = 0 : Ts: Tmax;
Xd = 10*sin (2*pi*fk(1)*td) - 2*sin (2*pi*fk(2)*td) + 5*cos (2*pi*fk(3)*td);
%Crtanje kontinualnog signala
subplot (2, 1, 1), plot (tk, Xk,'k');
ylim ([-25 25]); % ogranici opseg y-ose
title ('Kontinualni signal'); % daj ime grafiku
xlabel ('Vreme'); % komentarisi prirodu x-ose
%Crtanje diskretnog signala
subplot (2, 1, 2), stem (0:length(td)-1, Xd);
ylim ([-25 25]); % ogranici opseg y-ose
title ('Diskretni signal'); % daj ime grafiku
xlabel ('Odbirci'); % komentarisi prirodu x-ose

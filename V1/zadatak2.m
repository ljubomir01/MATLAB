%Definisanje trajanja intervala na kojem se posmatra signal u sekundama
Tmax=0.02;
%Definisanje ucestanosti na kojima se nalaze komponente u signalu
fk=[100 1500 2500];
%Definisanje amplituda prisutnih komponenti
Ak=[10 4 7];
%Definisanje kontinualnog signala, trajanja 5 ms
tk = 0 : 0.00001: Tmax;
Xk = Ak(1)*cos (2*pi*fk(1)*tk) - Ak(2)*cos (2*pi*fk(2)*tk) + Ak(3)*sin (2*pi*fk(3)*tk);
%Odredjivanje snage pojedinih komponenti prisutnih u signalu
Pk = Ak.*Ak/2;
%Ukupna snaga signala Xk
Ptotal = sum (Pk)
%Procenat snage koja otpada na pojedine komponente
Pperc = Pk/Ptotal
%Obzirom da su procenti ukupne snage po pojedinim komponentama u ovom
%slucaju 80%, 12.8%, 7.2%, komponenta na ucestanosti f=2500 Hz nosi manje
%od 10% ukupne snage pa je komponenta na najvisoj ucestanosti koja pri tome
%nosi vise od 10% ukupne snage ona na 1500 Hz
fmax = 2500;
%Definisanje ucestanosti odabiranja
fs = 2*fmax; Ts = 1/fs;
%Formiranje diskretnog signala
td = 0 : Ts: Tmax;
Xd = Ak(1)*cos (2*pi*fk(1)*td) + Ak(3)*cos (2*pi*fk(3)*td);
%Crtanje kontinualnog signala
subplot (2, 1, 1), plot (tk, Xk,'k');
%ylim ([-25 25]); % ogranici opseg y-ose
title ('Kontinualni signal'); % daj ime grafiku
xlabel ('Vreme'); % komentarisi prirodu x-ose
%Crtanje diskretnog signala
subplot (2, 1, 2), stem (0:length(td)-1, Xd);
%ylim ([-25 25]); % ogranici opseg y-ose
title ('Diskretni signal'); % daj ime grafiku
xlabel ('Odbirci'); % komentarisi prirodu x-ose 
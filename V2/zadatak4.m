brojilac = [3 -7 5];		% zadavanje polinoma u brojiocu G(Z)
imenilac = [1 -5/2 1];		% zadavanje polinoma u imeniocu G(Z)
zo = roots (brojilac);		% izracunavanje nula funkcije G(Z)
zp = roots (imenilac);		% izracunavanje polova funkcije G(Z)
k = brojilac(1)/imenilac(1);% izracunavanje pojacanja
disp ('Nule funkcije prenosa su:');
disp (zo);
disp ('Polovi funkcije prenosa su:');
disp (zp);
disp ('Pojacanje k je:');
disp (k);

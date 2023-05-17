%operatorski polinomi b i a
b = [0.1094 0.1094 0.1094 0.1094];
a = [0.96875 -1 0.96875 -0.53125];
%definisanje ulaznog signala u trajanju od 100 odbiraka
n = 0 : 99;
u = sin( 2*500*pi*n/48000) + 0.1* sin(2*12000*pi*n/48000);
y = filter (b, a, u);
%crtanje analitickog i numerickog resenja kao i greske koja je nastala
%prilikom numerickog resavanja
%analiticko resenje
subplot (2, 1, 1), stem (n, u), title ('Pobuda');
subplot (2, 1, 2), stem (n, y), title ('Numericko resenje');
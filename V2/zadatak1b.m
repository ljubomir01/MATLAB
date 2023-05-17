%operatorski polinomi b i a
b = [1];
a = [1 0 -4];
%definisanje ulaznog signala u trajanju od 100 odbiraka
n = 0 : 99;
u = ones(1,100);
y = filter (b, a, u);
%crtanje analitickog i numerickog resenja kao i greske koja je nastala
%prilikom numerickog resavanja
%analiticko resenje
subplot (2, 1, 1), stem (n, u), title ('Pobuda');
subplot (2, 1, 2), stem (n, y), title ('Numericko resenje');
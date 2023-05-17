%operatorski polinomi b i a
%r = 0.95;
%theta = pi/10;
b = [0.3 0.6 0.3];
%a = [1 -2*r*cos(theta) r^2];
a = [1 0 0.9 -0.3];
%definisanje delta impulsa i hevisajdnove funkcije u trajanju od 100 odbiraka
n = 0 : 63;
delta_impuls = [1 zeros(1, 63)];
hevisajdova_fja = [ones(1, 64)];
%odredjivanje impulsnog odziva LVN DS numerickim putem
g = filter (b, a, delta_impuls);
%odredjivanje jedinicnog odziva LVN DS numerickim putem
i = filter (b, a, hevisajdova_fja);
%crtanje impulsnog i jedinicnog odziva
subplot (2, 1, 1), stem (n, g), title ('Impulsni odziv sistema racunat po definiciji');
subplot (2, 1, 2), stem (n, i), title ('Jedinicni odziv sistema racunat po definiciji');
%racunanje impulsnog odziva na osnovu jedinicnog odziva
i_pom = [0 i(1:63)];
g1 = i-i_pom;
%racunanje jedinicnog odziva na osnovu impulsnog odziva
i1 = 0;
for k = 1 : 64
    g_pom = [zeros(1,k-1) g(1:64-k+1)];
    i1=i1 + g_pom;
end
%crtanje impulsnog i jedinicnog odziva
figure
subplot (2, 1, 1), stem (n, g1), title ('Impulsni odziv sistema racunat na osnovu jedinicnog odziva');
subplot (2, 1, 2), stem (n, i1), title ('Jedinicni odziv sistema racunat na osnovu impulsnog odziva');
%racunanje greske 
g_delta = g - g1;
i_delta = i - i1;
%crtanje greske
figure
subplot (2, 1, 1), stem (n, g_delta), title ('Impulsni odziv sistema, greska dva pristupa');
subplot (2, 1, 2), stem (n, i_delta), title ('Jedinicni odziv sistema, greska dva pristupa');

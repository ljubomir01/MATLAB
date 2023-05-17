% dužina sekvenci
L = 21;
% delta impuls u koordinatnom pocetku
x1 = [zeros(1, 5) 1 zeros(1, 15)];
% delta impuls zakašnjen za m trenutaka
x2 = [zeros(1, 7) 1 zeros(1, 13)];
% definisanje dela diskretne ose koja je od interesa prilikom crtanja
% diskretnih signala
n = -5 : 15;
% crtanje diskretnih signala
stem (n, x1), title ('Delta impuls u 0');
figure;
stem (n, x2), title ('Delta impuls u n-2')

y1 = x1 + x2;
figure;
stem (n, y1), title ('Y1');
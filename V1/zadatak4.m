%diskretno vreme
n = 0 : 49;
%definicija polinomijalno-stepeno-trigonometrijskog signala
x = (-3*n.^3+10*n.^2-7*n+15).*(0.9.^n).*cos(2*pi*0.01*n);
stem (n, x), title ('Polinomijalno-stepeno-trigonometrijska funkcija');

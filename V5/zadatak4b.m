% LVN DS sa dva ulaza i dva izlaza opisan preko jednacina stanja
A = [0.25 0.1; 5 0.3];
B = [1 0; 0 1];
C = [1 1; -1 -1];
D = [0 1; 1 0];
% definisanje dva ulazna signala
fs = 11200;
f1 = 1000;
f2 = 2000;
n = 0 : 99;
u1 = sin(2*pi*f1/fs*n);
u2 = sin(2*pi*f2/fs*n);
u = [u1; u2];
% odredjivanje odziva sistema, poc uslovi su nula
x(1:2, 1:101) = 0;
y(1:2, 1:101) = 0;
for i = 2 : 101
    x(:,i) = A*x(:,i-1)+B*u(:,i-1);
end
for i = 1 : 100
    y(:,i) = C*x(:,i)+D*u(:,i);
end
%formiranje dva odvojena izlazna signala radi kasnijeg lakseg poredjenja
y1 = y(1, 1:100);
y2 = y(2, 1:100);
%crtanje ulaznih i izlaznih signala
subplot (2, 2, 1), stem (n, u(1,:)), title ('Ulazni signal u1');
subplot (2, 2, 2), stem (n, u(2,:)), title ('Ulazni signal u2');
subplot (2, 2, 3), stem (n, y1), title ('Odziv sistema y1');
subplot (2, 2, 4), stem (n, y2), title ('Odziv sistema y2');
%definisanje posebnih signala za potrebe simulacije u Simulinku
u1_sim = [n;u1]';
u2_sim = [n;u2]';

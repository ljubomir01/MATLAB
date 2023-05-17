%definisanje tri diskretna signala
x1 = [ones(1,3) zeros(1,12)];
x2 = x1;
n = 0 : 14;
%crtanje signala
subplot (3, 1, 1), stem (n, x1), title ('Signal x1(n)');
subplot (3, 1, 2), stem (n, x2), title ('Signal x2(n)');
%provera komutativnosti
w1 = conv (x1, x2);
%crtanje signala
figure
subplot (2, 1, 1), stem (0:length(w1)-1, w1), title ('x1(n)*x2(n)');

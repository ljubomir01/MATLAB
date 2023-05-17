%definisanje tri diskretna signala
x11 = [ones(1,5) zeros(1,10)];
x22 = [ones(1,5) zeros(1,10)];
n = 0 : 14;
x1 = -n/2 .* x11;
x2 = n/2 .* x22;
%crtanje signala
subplot (3, 1, 1), stem (n, x1), title ('Signal x1(n)');
subplot (3, 1, 2), stem (n, x2), title ('Signal x2(n)');
%provera komutativnosti
w1 = conv (x1, x2);
%crtanje signala
figure
subplot (2, 1, 1), stem (0:length(w1)-1, w1), title ('x1(n)*x2(n)');

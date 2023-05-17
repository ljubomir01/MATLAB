n = 0:99;
temp = 2.^n;
a = [1 -1];
b = [1];

u = [temp(1:5) zeros(1, 95)];

y = filter(b, a, u);

figure

subplot(2, 1, 1), stem(0:length(u)-1, u),  title ('Pobuda1');
subplot(2, 1, 2), stem(0:length(y)-1, y),  title ('Odziv1');

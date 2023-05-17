%Opis LVN DS pomocu opearatorskih polinoma
a = [0.96875 -1 0.96875 -0.53125];
N = 256;
b = [0.1094 0.1094 0.1094 0.1094];
dirak = [1, zeros(1,1000)];
    
g = filter (b, a, dirak)
G = fft(g, N)
%amplitudska karakteristika
A1 = 2*abs(G)/N ;
%fazna karakteristika
F1 = angle(G);

figure
subplot(3, 2, 1), stem(pi*(0:length(A1)/2-1)/(N/2-1), A1(1:length(A1)/2))
title('Amplitudska 1')
xlim([0 pi])
subplot(3, 2, 2), stem(pi*(0:length(F1)/2-1)/(N/2-1), F1(1:length(F1)/2))
title('Fazna 1')
xlim([0 pi])
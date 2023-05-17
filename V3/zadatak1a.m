%definisanje diskretnog signala
n = 0 : 127;
N = 128;
x = [n(1:16) 31-n(17:32) zeros(1, 128-32)];

%racunanje spektra u istom broju tacaka kolika je duzina signala
X1 = 2*abs(fft(x))/N;
X1 = 20*log10(X1);
figure
subplot (3, 1, 1), stem(0:length(x)-1, x), title ('Diskretni signal x(n)');
subplot (3, 1, 2), stem(0:length(X1)-1, X1), title ('X1');
axis([0 64 0 20])
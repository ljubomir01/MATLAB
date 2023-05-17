%Specifikacija PO filtra
fp1 = 1700;
fp2 = 3500;
fs1 = 1200;
fs2 = 4000;
ap = 1;
as = 40;
%korak 1: odredjivanje dw, wc, delta_s i delta_p
df = min (fp1-fs1, fs2-fp2);
fc1 = fp1+df/2;
fc2 = fp2-df/2;
delta_s = 10^(-0.05*as);
delta_p = (10^(0.05*ap)-1)/(10^(0.05*ap)+1);
%korak 2: odredjivanje delta
delta = min (delta_s, delta_p);
if delta ~= delta_s
    delta_s = -20*log10(delta);
end
%korak 3: odredjivanje beta
beta = 0;
if (as >= 21 & as <= 50)
    beta = 0.5842*(as-21)^0.4+0.07886*(as-21);
end
if as > 50
    beta = 0.1102*(as-8.7);
end
%korak 4: odredjivanje M
D = 0.9222;
if as > 21
    D = (as-7.95)/14.36;
end
M = ceil (fo*D/df+1);
%ukoliko je M paran dodaj jedan da bi smo dobili neparan broj
%ovo je neophodno da bi projektovani filtar imao celobrojno kasnjenje
if mod(M, 2) == 0
    M = M + 1;
end;
%korak 5: generisanje odbiraka kajzerovog prozora duzine M
wk = kaiser (M, beta);
%korak 6: projektovanje FIR filtra
N = M-1; %potrebni red filtra
Fn = [fc1/(fo/2) fc2/(fo/2)]; %specifikacija nepropusnog opsega
b = fir1 (N, Fn, wk);
%racunanje spektra u 1024 tacke koriscenjem FFT
N_fft = 1024;
B = fft (b, N_fft);
%odredjivanje amplitudske karakteristike
Ba = abs(B(1:N_fft/2));
F = angle(B(1:N_fft/2));
%crtanje amplitudskih karakteristika na jednom grafiku
n = 0:N_fft/2-1;
f = n*(fo/2)/(N_fft/2-1);
subplot (3, 1, 1); plot (f, Ba); title ('Amplitudska karakteristika NO filtra projektovanog koriscenjem Kajzerovog prozora - linearna osa');
subplot (3, 1, 2); plot (f, 20*log10(Ba)); title ('Amplitudska karakteristika NO filtra projektovanog koriscenjem Kajzerovog prozora - logaritamska osa');
subplot (3, 1, 3); plot (f, F); title ('Fazna karakteristika NO filtra projektovanog koriscenjem Kajzerovog prozora');
xlim([0 pi])

%PREKO FURIJEA

n = 0:1023;
x = cos(2*pi*1000/fo*n) + cos(2*pi*3000/fo*n)+ cos(2*pi*5000/fo*n);

figure
subplot(2, 1, 1), plot(n, x), title ('Pobuda x', 'FontSize', 14);
xlim([0 100]);

X = fft(x, N_fft)

y = ifft(X.*B);

subplot(2, 1, 2), plot(1:numel(y), y), title ('Odziv na LP ', 'FontSize', 14), xlim([0 100]);
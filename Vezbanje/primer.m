a = 1;
b = [1 -0.9744 0.024574 -0.97245 0.99601];
%definisanje parametara ulaznog signala
fs = 44100;
f1 = 1102;
f2 = 4586;
%diskretno vreme
n = 0:99;
%definisanje ulaznog signala u trajanju od 100 odbiraka
u = 10*cos(2*pi*f1/fs*n) + cos(2*pi*f2/fs*n);
%odredjivanje odziva sistema na ulazni signal
y = filter(b, a, u);
%crtanje
subplot(2, 1, 1), stem(n, u), title('Ulaz');
subplot(2, 1, 2), stem(n, y), title('izlaz');
u_sim = [n;u]';
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela direktne realizacije
%sistema
delta_dir = y - out.y_dir_sim;
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela transponovane direktne
%realizacije sistema
delta_tran = y - out.y_tran_sim;
%racunanje greske izmedju odziva dobijenih simulacijom
delta_dir_tran = out.y_dir_sim' - out.y_tran_sim';
%crtanje sva tri odziva
figure;
subplot (3, 1, 1), stem (0:length(y)-1, y), title ('Odziv sistema racunat pomocu funkcije filter');
subplot (3, 1, 2), stem (0:length(out.y_dir_sim)-1, out.y_dir_sim'), title ('Odziv sistema dobijen simulacijom modela direktne realizacije');
subplot (3, 1, 3), stem (0:length(out.y_tran_sim)-1, out.y_tran_sim'), title ('Odziv sistema dobijen simulacijom modela transponovane direktne realizacije');
%crtanje gresaka
%subplot (3, 1, 1), stem (0:length(delta_dir)-1, delta_dir), title ('Greska racunata kao y-y\_dir\_sim');
%subplot (3, 1, 2), stem (0:length(delta_tran)-1, delta_tran), title ('Greska racunata kao y-y\_tran\_sim');
%subplot (3, 1, 3), stem (0:length(delta_dir_tran)-1, delta_dir_tran), title ('Greska racunata kao y\_dir\_sim-y\_tran\_sim');
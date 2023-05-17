%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom kaskadnog modela sistema, 
%celije realizovane pomocu direktne realizacije
delta_dir = y - y_dir_sim';
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom kaskadnog modela sistema, celije 
%realizovane pomocu transponovane direktne realizacije 
delta_tran = y - y_tran_sim';
%racunanje greske izmedju odziva dobijenih simulacijom
delta_dir_tran = y_dir_sim' - y_tran_sim';
%crtanje sva tri odziva
subplot (3, 1, 1), stem (0:length(y)-1, y), title ('Odziv sistema racunat pomocu funkcije filter');
subplot (3, 1, 2), stem (0:length(y)-1, y_dir_sim'), title ('Odziv sistema dobijen simulacijom direktnog modela');
subplot (3, 1, 3), stem (0:length(y)-1, y_tran_sim'), title ('Odziv sistema dobijen simulacijom transponovanog modela');
%crtanje gresaka
figure
subplot (3, 1, 1), stem (0:length(delta_dir)-1, delta_dir), title ('Greska racunata kao y-y\_dir\_sim');
subplot (3, 1, 2), stem (0:length(delta_tran)-1, delta_tran), title ('Greska racunata kao y-y\_tran\_sim');
subplot (3, 1, 3), stem (0:length(delta_dir_tran)-1, delta_dir_tran), title ('Greska racunata kao y\_dir\_sim-y\_tran\_sim');

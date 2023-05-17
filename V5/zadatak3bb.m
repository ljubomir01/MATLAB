%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela direktne realizacije I 
%sistema, 
delta_dir_1 = y - y_dir_1_sim';
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela direktne realizacije II 
%sistema, 
delta_dir_2 = y - y_dir_2_sim';
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela transponovane direktne 
%realizacije I sistema, 
delta_trans_dir_1 = y - y_trans_dir_1_sim';
%racunanje greske izmedju odziva izracunatog koriscenjem funkcije filter,
%y, i odziva dobijenog Simulink simulacijom modela transponovane direktne 
%realizacije II sistema, 
delta_trans_dir_2 = y - y_trans_dir_2_sim';
%crtanje sva tri odziva
subplot (3, 2, 1), stem (0:length(y)-1, y_dir_1_sim'), title ('Odziv modela direktne realizacije I');
subplot (3, 2, 2), stem (0:length(y)-1, y_dir_2_sim'), title ('Odziv modela direktne realizacije II');
subplot (3, 2, 3), stem (0:length(y)-1, y_trans_dir_1_sim'), title ('Odziv modela transponovane direktne realizacije I');
subplot (3, 2, 4), stem (0:length(y)-1, y_trans_dir_2_sim'), title ('Odziv modela transponovane direktne realizacije II');
subplot (3, 2, 5), stem (0:length(y)-1, y'), title ('Odziv preko f-je filter');
%crtanje gresaka
figure
subplot (2, 2, 1), stem (0:length(delta_dir_1)-1, delta_dir_1), title ('Greska kao y-y\_dir\_1\_sim');
subplot (2, 2, 2), stem (0:length(delta_dir_2)-1, delta_dir_2), title ('Greska kao y-y\_dir\_2\_sim');
subplot (2, 2, 3), stem (0:length(delta_trans_dir_1)-1, delta_trans_dir_1), title ('Greska kao y-y\_trans\_dir\_1\_sim');
subplot (2, 2, 4), stem (0:length(delta_trans_dir_2)-1, delta_trans_dir_2), title ('Greska kao y-y\_trans\_dir\_2\_sim');

%racunanje greske izmedju odziva izracunatog u MATLAB-u,y1 i y2, i
%odziva dobijenog Simulink simulacijom modela u prostoru stanja 
delta_y1 = y1 - y1_sim';
delta_y2 = y2 - y2_sim';
%crtanje odziva
subplot (2, 2, 1), stem (0:length(y1)-1, y1), title ('Odziv MATLAB modela, y1');
subplot (2, 2, 2), stem (0:length(y2)-1, y2), title ('Odziv MATLAB modela, y2');
subplot (2, 2, 3), stem (0:length(y1)-1, y1_sim'), title ('Odziv SIMULINK modela, y1\_sim');
subplot (2, 2, 4), stem (0:length(y2)-1, y2_sim'), title ('Odziv SIMULINK modela, y2\_sim');
%crtanje gresaka
figure
subplot (2, 1, 1), stem (0:length(delta_y1)-1, delta_y1), title ('Greska racunata kao y1-y1\_sim');
subplot (2, 1, 2), stem (0:length(delta_y2)-1, delta_y2), title ('Greska racunata kao y2-y2\_sim');
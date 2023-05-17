% dužina sekvence
L = 16;
% Hevisajdova f-ja
h_funkc1 = [zeros(1, 5) ones(1, 11)];
h_funkc2 = [zeros(1, 10) ones(1, 6)];
h_funkc = h_funkc1 - h_funkc2;
% vremenska osa za crtanje signala
n = -5 : 10;						
stem (n, h_funkc), title ('Diskretna Hevisajdova funkcija')

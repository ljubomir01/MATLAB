%Definisanje dve vrste kvantizacije koje se koriste u ovom primeru
%Kvantizacija1:
struct.mode = 'fixed'; 
struct.roundmode = 'floor'; 
struct.overflowmode = 'saturate'; 
struct.format = [4 3]; 
q1 = quantizer(struct);

%Kvantizacija2:
struct.mode = 'fixed'; 
struct.roundmode = 'floor'; 
struct.overflowmode = 'saturate'; 
struct.format = [8 7]; 
q2 = quantizer(struct);

%Kvantizacija3:
struct.mode = 'fixed'; 
struct.roundmode = 'round'; 
struct.overflowmode = 'saturate'; 
struct.format = [4 3]; 
q3 = quantizer(struct);

%Kvantizacija4:
struct.mode = 'fixed'; 
struct.roundmode = 'round'; 
struct.overflowmode = 'saturate'; 
struct.format = [8 7]; 
q4 = quantizer(struct);

%Definisanje niza realnih brojeva koje je potrebno kvantizovati. Brojevi su
%iz opsega [-1 1] sa korakom 0.1
realni_broj = -1 : 0.05 : 1;


%Kvantizacija prethodnog niza pomocu dva kvantizera
masinski_broj_q1 = quantize (q1, realni_broj);
masinski_broj_q2 = quantize (q2, realni_broj);
masinski_broj_q3 = quantize (q3, realni_broj);
masinski_broj_q4 = quantize (q4, realni_broj);

%Crtanje karakteristika kvantizacije
plot(realni_broj, masinski_broj_q1);
title(tostring(q1)); xlabel ('Realni broj'); ylabel ('Mašinski broj');
figure;
plot(realni_broj, masinski_broj_q2);
title(tostring(q2)); xlabel ('Realni broj'); ylabel ('Mašinski broj');
figure;
plot(realni_broj, masinski_broj_q3);
title(tostring(q3)); xlabel ('Realni broj'); ylabel ('Mašinski broj');
figure;
plot(realni_broj, masinski_broj_q4);
title(tostring(q4)); xlabel ('Realni broj'); ylabel ('Mašinski broj');
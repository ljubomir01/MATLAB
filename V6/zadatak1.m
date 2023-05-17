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
realni_broj = 2*rand(1,100) - 1 %da dobijemo brojeve izmedju -1 1 


%Kvantizacija prethodnog niza pomocu dva kvantizera
masinski_broj_q1 = quantize (q1, realni_broj);
masinski_broj_q2 = quantize (q2, realni_broj);
masinski_broj_q3 = quantize (q3, realni_broj);
masinski_broj_q4 = quantize (q4, realni_broj);

%Racunanje gresaka kvantizacije
delta_q1 = masinski_broj_q1 - realni_broj;
delta_q2 = masinski_broj_q2 - realni_broj;
delta_q3 = masinski_broj_q3 - realni_broj;
delta_q4 = masinski_broj_q4 - realni_broj;

%Ispis tacnih i kvantizovanih vrednosti
    disp (sprintf ('Realni broj     Masinski broj q1   Greška      Masinski broj q2   Greška      Masinski broj q3   Greška      Masinski broj q4   Greška'));
for i = 1 : length (realni_broj)
    disp (sprintf ('  %6.3f            %6.3f        %6.3f         %6.3f          %6.3f         %6.3f          %6.3f         %6.3f          %6.3f', realni_broj(i), masinski_broj_q1(i), delta_q1(i), masinski_broj_q2(i), delta_q2(i), masinski_broj_q3(i), delta_q3(i), masinski_broj_q4(i), delta_q4(i)));
end

disp (sprintf ('Prosecna apsolutna greska kvantizacije:\nKvantizacija odsecanjem = %f\nKvantizacija odsecanje = %f\nKvantizacija zaokruživanjem = %f\nKvantizacija zaokruživanjem = %f', mean (abs (delta_q1)), mean (abs (delta_q2)), mean (abs (delta_q3)), mean (abs (delta_q4))));
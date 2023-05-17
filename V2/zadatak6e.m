%definisanje diskretnog sistema
%b = [0.08632 0.055706 0.14939 0.055706 0.08632];
%a = [1 -1.6992	2.1371 -1.3258	0.50014];
b = [-5.5 0 2.7];
a = [1 0.2 0.7 0.3];
nule = roots (b); 
polovi = roots (a);
disp ('Polovi funkcije prenosa su:');
disp (polovi);
% ovaj deo ispituje sa li se svi polovi nalaze unutar jedini?nog kruga
if abs (polovi) < 1
	disp ('Sistem je stabilan.');
else
	disp ('Sistem je nestabilan');
end
% ovaj deo crta raspored polova i nula u odnosu na jedini?ni krug
zplane (b, a);
%odredjivanje impulsnog odziva sistema
delta_impuls = [1 zeros(1, 99)];
g = filter (b, a, delta_impuls);
figure
stem (0: length(g)-1, g), title ('Impulsni odziv sistema');
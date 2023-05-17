%FIR filtar Furije
N=7;
f=1800;
fsr=11200;
wi=hanning(N+1);

b=fir1(N,f/fsr/2,wi);
%amplitudska i fazna kka
N_fft = 1024;
B=fft(b,N_fft);
Ba=abs(B(1:N_fft/2));
Bf=180*unwrap(angle(B(1:N_fft/2)))/pi;

n1=0:N_fft/2-1;
w = n1*fsr/(2*(N_fft/2-1));
figure,subplot(2,1,1),plot(w,20*log10(Ba)),title("Amplitudska");
subplot(2,1,2),plot(w,Bf),title("Fazna");
figure
zplane(b,1,fsr);

%odziv

n=0:99;
x = sin(2*pi*900*n/fsr) + sin(2*pi*2800*n/fsr) + sin(2*pi*4800*n/fsr) ;
%promenljiva za simulink
ulaz=[n;x]';

filter_odziv=filter(b,1,x);
figure,plot(n,filter_odziv),title("Odziv pomocu funkcije filter");

%odziv putem simulinka
greska1=filter_odziv - out.dir';
greska2=filter_odziv - out.transp';


figure,subplot(4,1,1),plot(0:length(out.dir)-1,out.dir'),title("Direktna forma");
subplot(4,1,2),stem(0:length(out.dir)-1,greska1),title("greska");
subplot(4,1,3),plot(0:length(out.transp)-1,out.transp'),title("Transp forma");
subplot(4,1,4),stem(0:length(out.transp)-1,greska2),title("greska");


%c amplitudska i fazna kka
%prenosna gja odziv na delta
ulaz1=[1 zeros(1,99)];
ulaz1=[n;ulaz1]';

B_dir=fft(out.dir_kvant',N_fft);
B1a=abs(B_dir(1:N_fft/2));
B1f=180*unwrap(angle(B(1:N_fft/2)))/pi;
figure,subplot(2,1,1),plot(w,20*log10(Ba)),title("Amplitudska"),hold on;

subplot(2,1,1),plot(w,20*log10(B1a),'r'),title("Amplitudska ");
subplot(2,1,2),plot(w,Bf),title("Fazna"),hold on;
subplot(2,1,2),plot(w,B1f,'r'),title("Fazna");

figure, zplane(out.dir_kvant',1,fsr),title("direktna");
%c amplitudska i fazna kka transponovani

B_transp=fft(out.transp_kvant',N_fft);
B1a=abs(B_transp(1:N_fft/2));
B1f=180*unwrap(angle(B(1:N_fft/2)))/pi;
figure,subplot(2,1,1),plot(w,20*log10(Ba)),title("Amplitudska"),hold on;


subplot(2,1,1),plot(w,20*log10(B1a),'r'),title("Amplitudska");
subplot(2,1,2),plot(w,Bf),title("Fazna"),hold on;
subplot(2,1,2),plot(w,B1f,'r'),title("Fazna");

figure, zplane(out.transp_kvant',1,fsr),title("transponovana");



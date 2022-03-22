%Exercise 8
clear all 
close all
clc
%% Que 4
t1 = 0:0.01:10; %sec - 100 Hz
x1 = sin(2*pi*t1) + sin(2*pi*t1+pi/4);
a = max(abs(x1));
p = pi*0.5 + angle(x1);
p = p(1);
figure
plot(t1,x1);
xlabel('Time(sec)');
ylabel('Amplitude');
%% Que 3

T2=0.5;
fs2 = 32;
t1=0:1/32:T2-1/fs2; 
x1 = sin(2*pi*3*t1);
N2=16;
n = 0:N2-1;
X1=fft(x1)/8;
X1 = abs(X1);
figure
stem(0:2:30,X1);
xlabel('Frequecy (Hz)');

%% Que5 - section a
figure
T1 = 2;
fs1 = 105;
N1 = 210;
n1 = 0:N1-1;
t1 = 0:1/fs1:T1-1/fs1;
x1 = 2*sin(6*pi*t1+0.5*pi) + 5*cos(15*pi*t1);
X1=fft(x1)/(N1/2);  
real_1 = real(X1);
imaginary_1 = imag(X1);
power_1 = abs(X1);
phase_1 = angle(X1);
frange1 = 1/T1.*n1;
w1 = 0:209;
subplot(2,2,1)
hold on
stem(w1,real_1);
title('Real');
xlabel('Frequency (Hz)');
xlim([0 210]);
set(gca,'xtick',[0:40:210]+1,'xticklabel',[0:20:105]);
subplot(2,2,2)
stem(w1,imaginary_1);
title('Imaginary');
xlabel('Frequency (Hz)');
xlim([0 210]);
set(gca,'xtick',[0:40:210]+1,'xticklabel',[0:20:105]);
subplot(2,2,3)
stem(w1,power_1);
title('Power');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 210]);
set(gca,'xtick',[0:40:210]+1,'xticklabel',[0:20:105]);
subplot(2,2,4)
stem(w1,phase_1);
title('Phase');
xlabel('Frequency (Hz)');
xlim([0 210]);
set(gca,'xtick',[0:40:210]+1,'xticklabel',[0:20:105]);

%% Que 5 - section b 
figure 

T2 = 3;
fs2 = 7;
N2 = 21;
n2 = 0:N2-1;
t2 = 0:1/fs2:T2-1/fs2;
x2 = 2*sin(6*pi*t2+0.5*pi) + 5*cos(15*pi*t2);
X2=fft(x2)/(N2/2);  
real_2 = real(X2);
imaginary_2 = imag(X2);
power_2 = abs(X2);
phase_2 = angle(X2);
w2 = 0:20;
subplot(2,2,1)
hold on
stem(w2,real_2);
title('Real');
xlabel('Frequency (Hz)');
xlim([0 21]);
set(gca,'xtick',[0:3:21]+1,'xticklabel',[0:7]);
subplot(2,2,2)
stem(w2,imaginary_2);
title('Imaginary');
xlabel('Frequency (Hz)');
xlim([0 21]);
set(gca,'xtick',[0:3:21]+1,'xticklabel',[0:7]);
subplot(2,2,3)
stem(w2,power_2);
title('Power');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 21]);
set(gca,'xtick',[0:3:21]+1,'xticklabel',[0:7]);
subplot(2,2,4)
stem(w2,phase_2);
title('Phase');
xlabel('Frequency (Hz)');
xlim([0 21]);
set(gca,'xtick',[0:3:21]+1,'xticklabel',[0:7]);

clear all
close all
clc

t1 = 0:0.001:5;
x1 = 4+3*cos(pi*t1)+2*cos(2*pi*t1)+cos(3*pi*t1);

figure;
subplot(3,1,1);
plot(t1,x1);
title('Original signal');

t2 = 0:2/3:5;
x2 = 4+3*cos(pi*t2)+2*cos(2*pi*t2)+cos(3*pi*t2);

subplot(3,1,2);
plot(t2,x2);
title('1.5 hertz sampling signal');

x3 = 5+5*cos(pi*t1);

subplot(3,1,3);
plot(t1,x3);
title('Calculated signal');
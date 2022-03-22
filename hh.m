%% Question 2.3 

D = 0:0.01:1;
Kyz = 0.5;
Tyz = log10(1/(1-Kyz));
Z_max = zeros(1,101);

for i = 1:length(Z_max)
    
    % while D is shorter than minimal pulse needed
    if D(i) < Tyz
        Z_max(i) = 0;
    % while D is longer than minimal pulse needed
    else
        t = D(i);
        Z_max(i) = 1-exp(-t);   
    end
    
end

figure
plot(D, Z_max, 'LineWidth', 1.5);
title('Maximum level of Z as a function of pulse duration D');
xlabel('D');
ylabel('Maximum level of Z');

%% Question 5

x1 = 0:0.1:10;
x21 = 5 - 2*x1;
x22 = 3 - 0.25*x1;
x23 = 10 - x1;

figure
plot(x1, x21, 'LineWidth', 1.5);
hold on
plot(x1, x22, 'LineWidth', 1.5);
plot(x1, x23, 'LineWidth', 1.5);
legend('2X_1 + X_2 = 5','X_1 + 4X_2 = 12','X_1 + X_2 = 10')
xlabel('X1 plane');
ylabel('X2 plane');
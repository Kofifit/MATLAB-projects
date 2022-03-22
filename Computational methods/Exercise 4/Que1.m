%% Change Cpos and Cneg, check how t affects the figures
C_diff = [1, Inf; Inf, 1];
for i = 1:2
    SVMtrial(6,C_diff(i,:));
end
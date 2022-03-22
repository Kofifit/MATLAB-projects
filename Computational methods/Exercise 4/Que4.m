%% Bonus - run all data sets to get figures

% Polynomial kernel
for i = 1:6
    a = SVMtrial_bonus(i);
end

% RBf kernel
for j = 1:6
    a = SVMtrial(j);
end

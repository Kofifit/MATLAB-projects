function [] = plotScatter(data_train)

% The functions gets one input which is a table of the training data. it
% plots with scatter the data with three variables (axis).
% Normal weight (0) in blue and obese (1) in red.

figure
xPre = table2array(data_train(:,5)); % vec of variable I
x = [];
y = table2array(data_train(:,8)); % vec of variable II
z = table2array(data_train(:,13));% vec of variable III

IndexNo = strcmp(table2array(data_train(:,5)), 'no');
IndexYes = strcmp(table2array(data_train(:,5)), 'yes');
x(IndexNo) = 0;
x(IndexYes) = 1;

train_labels = table2array(data_train(:,17)); % vec of obesity level
labels = {'Normal Weight','Overweight'}; % labels for obesity level

% scatter data in different color for each label
for i = 1:2
    vec_index = find(train_labels == (i-1)); % Find current label (0 or 1)
    scatter3(x(vec_index),y(vec_index),z(vec_index)); % Plot data
    hold on
end

xlabel('Family history of obesity'); % set x axis label
ylabel('Number of main meals a day'); % set y axis label
zlabel('Frequency of physical activity'); % set z axis label
title('Obesity level scatter based on three variables'); % set figure title
legend(labels{:}); % set legened for colored dots
    
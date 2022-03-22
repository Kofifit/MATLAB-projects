%% clean

clear all;
close all;
clc;

%% Questions 1 & 2 - Load data

load('geodata.mat');
load('data_ex4.mat');

%% Question 3 - Plot gene No. 25

geneNum = 25; % define number of gene to plot

% plot gene with time as x axis
plot(times, yeastvalues(geneNum,:))
title(genes{geneNum})
xlabel('Time (Hours)');
ylabel('Expression level (log2)');

%% Question 4 - histogram of non normalized samples

% define empty cell array for legend values
name = cell(1,length(times)); 
% create new figure
figure; 

% plot a histogram for each sample separately (col in matrix)
for i = 1:length(times)
   histogram(yeastvalues(:,i),'DisplayStyle','stairs')
   name{i} = sprintf('Sample No. %d',i);
   hold on
end

% plot a histogram for all samples combined
histogram(yeastvalues,'DisplayStyle','stairs');
name{i+1} = 'All samples';

% define values for figure
legend(name{:});
title('Histogram of samples BEFORE quantile normalization');
xlabel('Expression level (log2)');
ylabel('No. of genes');
hold off

%% Question 4 - normalization of samples and histogram

% normalize the data and assign to new variable
yeastvaluesNormalized = quantilenorm(yeastvalues);
% create new figure
figure;

% plot a histogram for each sample separately (col in matrix)
for i = 1:length(times)
   histogram(yeastvaluesNormalized(:,i),'DisplayStyle','stairs')
   name{i} = sprintf('Sample No. %d',i);
   hold on
end

% plot a histogram for all samples combined
histogram(yeastvaluesNormalized,'DisplayStyle','stairs');

% define values for figure
legend(name{:});
title('Histogram of samples AFTER quantile normalization');
xlabel('Expression level (log2)');
ylabel('No. of genes');
hold off

%% Question 5 - data filtering

% Assign data and names to new variables
Fdata = yeastvaluesNormalized;
Fgenes = genes;

% Remove empty genes from data
emptyIndex = find(contains(Fgenes,'EMPTY'));
Fdata(emptyIndex,:) = [];
Fgenes(emptyIndex) = [];

% print message that declares number of genes left after flitering step
genesLeft = length(Fgenes);
message = 'After filtering out empty genes, %d genes were left\n';
fprintf(message,genesLeft);

% Remove genes with Nan values in one or more samples
nanIndex = find(sum(isnan(Fdata),2)>0);
Fdata(nanIndex,:) = [];
Fgenes(nanIndex) = [];

% print message that declares number of genes left after flitering step
genesLeft = length(Fgenes);
message = 'After filtering out genes with Nan values, %d genes were left\n';
fprintf(message,genesLeft);

% Remove genes with low variance
[~,Fdata, Fgenes] = genevarfilter(Fdata, Fgenes);

% print message that declares number of genes left after flitering step
genesLeft = length(Fgenes);
message = 'After filtering out genes with low variance, %d genes were left\n';
fprintf(message,genesLeft);

% Remove genes with low absolute value of expression
[~,Fdata, Fgenes] = genelowvalfilter(Fdata, Fgenes, 'AbsValue',log2(3));

% print message that declares number of genes left after flitering step
genesLeft = length(Fgenes);
message = 'After filtering out genes with low expression, %d genes were left\n';
fprintf(message,genesLeft);

%% Question 6 - Plot Heat map

% create new figure
figure;

% create heat map
H = HeatMap(Fdata);

% define values for figure
addTitle(H,'Heat map - filtered data');
addXLabel(H,'Samples');
addYLabel(H,'Genes');

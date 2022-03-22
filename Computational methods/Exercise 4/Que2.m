%% Plot Different training set sizes

clear 
clc
train_size = [2, 4, 8, 16, 20, 30,50,70,100];
accuracy_vec = zeros(1,length(train_size));
k_num = 3;
dataSet_choice = 4;
lambda = 0;
for i = 1:length(train_size)
    accuracy_vec(i) = SVMevaluation(dataSet_choice,k_num,train_size(i),lambda);
end
figure
plot(train_size,accuracy_vec,'-*');
xlabel('Training set size');
ylabel('Accuracy');

%% Plot different lambda

clear 
clc
train_size = 10;
lambda = [0.001, 0.05, 0.5, 1, 5, 20, 50 ,150];
accuracy_vec = zeros(1,length(lambda));
k_num = 3;
dataSet_choice = 4;

for i = 1:length(lambda)
    accuracy_vec(i) = SVMevaluation(dataSet_choice,k_num,train_size,lambda(i));
end
figure
plot(lambda,accuracy_vec,'-*');
xlabel('Lambda');
ylabel('Accuracy');


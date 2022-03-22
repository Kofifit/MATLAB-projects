function [k_validation, k_train] = k_fold(x,y,k_num,train_size)

% This function splits the data into K groups. each group will be used once
% as a validation set. The train_size will determine the size of the 
% x = input is the samples
% y = labels for he samples in x
% k_num = number of groups desired
% train_size = wanted size for training set. For default size the input
% shall be 0, which results in training size = num of samples - size of 
% validation set.

counter = 0;
m = length(x);
set_size = floor(m/k_num);
data_mat = [x,y];
data_mat = data_mat(randperm(m),:);
k_train = cell(1,k_num);
k_validation = cell(1,k_num);

for i = 1:k_num
    
    if train_size == 0
        k_validation{i} = data_mat(counter+1:counter+set_size,:);
        if i == 1
            train = [data_mat(counter+set_size+1:end,:)];
            k_train{i} = train;
        else
            train = [data_mat(1:counter,:) ; data_mat(counter+set_size+1:end,:)];
            k_train{i} = train;
        end 
        counter = counter + set_size;
        
    elseif train_size ~= 0 
        val_index = counter + set_size;
        k_validation{i} = data_mat(counter+1:val_index,:);
        train = [data_mat(1:counter,:) ; data_mat(val_index+1:end,:)];
        n = size(train,1);
        train = train(randperm(n),:);
        k_train{i} = train(1:train_size,:);
        counter = val_index;
    end        
    
end


        
        

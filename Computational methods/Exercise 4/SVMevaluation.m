function accuracy = SVMevaluation(dataSet_choice, k_num, train_size,new_lambda)

% This function uses the function k_fold to split the data to validation
% sets and training sets. With the data sets we get from the k_fold
% function, the function trains a model on the training sets with the
% SVMtrial function. To evualte the model we got, we used built in "func"
% function that tests the model with the validation sets. 
% The inputs for the function are:
% dataSet_choice = an integer 1 to 6 which chooses one of the data sets
% k_num = number of groups desired
% train_size = wanted size for training set. For default size the input
% shall be 0, which results in training size = num of samples - size of 
% validation set.
% new_lambda = wanted lambda for the training process. For default lambda
% the input shall be 0, and the lambda will be as the code states for each
% data set.

% CHOOSE TRAINING SETS

rng(1)

clc;
fprintf('Welcome to SVM Trials!\n');
if nargin == 4
    fprintf('[1] TYPICAL\n');
    fprintf('[2] SADDLE\n');
    fprintf('[3] RANDOM\n');
    fprintf('[4] RANDOM, IN ELLIPSE W/ 1 OUTLIER\n');
    fprintf('[5] SPIRAL\n');
    fprintf('[6] IMBALANCED + OVERLAP\n')
%     ch = input('Choose dataset: ');             % Let the user choose
    ch = dataSet_choice;
    
    switch ch
        case 1
            % Set 1: TYPICAL
            kw = 0.8;   % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = [4,5,2,2,4,9,7,8,8,9;
                7,8,2,5,5,2,1,1,5,4]';
            y = [1 1 1 1 1 -1 -1 -1 -1 -1]';
            
        case 2
            % Set 2: SADDLE
            kw = 1;     % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = [4,4,2,3,8,9,7,7,5,4,6,5,8,9,6,7;
                4,6,6,3,2,3,2,0,1,0,1,2,7,8,7,5]';
            y = [1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1]';
            
        case 3
            % Set 3: RANDOM
            kw = 0.1;   % Recommended RBF kernel width
            Lambda = 1;      % Recommended box constraint
            x = 10*rand(50,2);
            y = ones(50,1); y(1:25) = -1;
            
        case 4
            % Set 4: RANDOM, IN ELLIPSE W/ 1 OUTLIER
            kw = 0.25;  % Recommended RBF kernel width
            Lambda = 10;     % Recommended box constraint
            x = 10*rand(150,2);
            y = (x(:,1) - 6).^2 + 3*(x(:,2) - 5).^2 - 8;
            y(y > 0) = 1; y(y ~= 1) = -1;
%             outlr = randi(150);
%             y(outlr) = -y(outlr); % Outlier (this is removable)
            
        case 5
            % Set 5: SPIRAL
            kw = 0.2;   % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = importdata('myspiral.mat');
            y = x(:,3); x = x(:,1:2);
            
        case 6
            % Set 6: IMBALANCED + OVERLAP
            kw = 0.5;   % Recommended RBF kernel width
            Cpos = 1;   % Recommended box constraint (red)
            Cneg = Inf; % Recommended box constraint (blue)
            x = importdata('imba.mat');
            y = x(:,3); x = x(:,1:2);
            Lambda = zeros(size(y));
            Lambda(y == 1) = Cpos; Lambda(y == -1) = Cneg;
            % Remark: Try switching Cpos and Cneg.
    end
    
end
if new_lambda ~= 0
    Lambda = new_lambda;
end
% Divide to K training and validation sets
[validation_data, train_data] = k_fold(x,y,k_num,train_size);
total_hits = zeros(1,length(validation_data));
for i = 1:length(train_data)
    hit_set = zeros(length(validation_data{1}),1);
    all = train_data{i};
    x = all(:,1:2);
    y = all(:,3);
    F = SVMtrial(dataSet_choice,0,x,y,kw,Lambda);
    xT = F.xT; y = F.y; a = F.a; b = F.b; new_kw = F.kw; sv = F.sv;
    all_test = validation_data{i};
    x_test = all_test(:,1:2);
    y_test = all_test(:,3);
    N = length(y_test);                                  % Let N = no. of samples
    xm = mean(x_test); xs = std(x_test);                      % Mean and Std. Dev.
    x_test = (x_test - xm(ones(N,1),:))./xs(ones(N,1),:);     % Center and scale data
    for j = 1:length(all_test)
        prediction = func(x_test(j,:),xT,y,a,b,new_kw,sv);
        prediction = sign(prediction);
        hit_set(j) = (prediction == y_test(j));
    end
    total_hits(i) = mean(hit_set);       
end

accuracy = 100*mean(total_hits);

% FUNCTION TO EVALUATE ANY UNSEEN DATA, x
%  [xT,y,a,b,kw,sv] are fixed after solving the QP.
%  f(x) = SUM_{i=sv}(y(i)*a(i)*K(x,xT(i))) + b;
    function F = func(x,xT,y,a,b,kw,sv)
        K = repmat(x,size(sv)) - xT(sv,:);      % d = (x - x')
        K = exp(-sum(K.^2,2)/kw);               % RBF: exp(-d^2/kw)
        F = sum(y(sv).*a(sv).*K) + b;           % f(x)
    end    
end



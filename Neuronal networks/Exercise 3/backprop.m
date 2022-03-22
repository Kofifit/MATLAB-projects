function [wInputHidden, wHiddenOutput, total_error_train, total_error_test] =backprop(x_train, y_train, x_test, y_test, num_hidden, lambda, alpha, num_cycles)
% this function runs the backpropogation algorithm on a training data set
% (x_train,y_train) updates the weights and calculates the
% training error on the traning set and the test error on the test set.

% inputs:

%         x_train - a matrix of training digits. each row is a 28*28 pixel digit either 0 or 3
%         y_train - a vector of labels of the training data 0 is for digits 0 and 1 for digits 3
%         x_test - a matrix of test digits. each row is a 28*28 pixel digit either 0 or 3
%         y_test - a vector of labels of the test data 0 is for digits 0 and 1 for digits 3
%         num_hidden - number of neurons in the hidden layer
%         lambda - rate of change of the gradient descent
%         alpha - weight decay (regularization) coefficient
%         num_cycles - number of cycles to run over all training examples
        
% % outputs:
% 
%          wInputHidden - new weights from input layer to hidden layer
%          wHiddenOutput -  new weights from hidden layer to output
%          total_error_train - total training error at the end
%          total_error_train - total test error at the end
         
% Add a constant one for the bias         
x_train = [ones(size(x_train,1),1), x_train ];
x_test = [ones(size(x_test,1),1), x_test];

[num_samples_train, inputDim] = size(x_train);
[num_samples_test, testDim] = size(x_test);

if inputDim ~=testDim
  error('input dimension mismatch');
end

if any(y_train~=0 & y_train~=1)
  error('Illegal labels in y_train');
end

if any(y_test~=0 & y_test~=1)
  error('Illegal labels in y_test');
end


% Intialize the weights, and randomize the data

rng(1)
%   rng is a function that recieves a number that determines the 
%   initiation point of the random proccess
wInputHidden = randn(num_hidden, inputDim)*0.1;
wHiddenOutput = randn(1,num_hidden)*0.1;

% Shuffle the training data
inds = randperm(num_samples_train);
x_train = x_train(inds,:);
y_train = y_train(inds);

for i_cycle = 1:num_cycles 
       for i=1:num_samples_train
           x = x_train(i,:); % take example i
           y_expected = y_train(i); % expected is 1 or 0 
           
           % calc the forward solution
           yHidden = CalcForward(wInputHidden, x);
           yOutput = CalcForward(wHiddenOutput, yHidden');

           % Update the weights
           [wInputHidden, wHiddenOutput] = UpdateWeights(wInputHidden, wHiddenOutput, lambda,x, yOutput, yHidden, y_expected, alpha);
       end;

  total_error_train(i_cycle) = CalcError(wInputHidden, wHiddenOutput, x_train, y_train, alpha);
  total_error_test(i_cycle) = CalcError(wInputHidden, wHiddenOutput, x_test, y_test, alpha);
  fprintf('cycle %d is done \n',i_cycle);
end;

figure; 
plot(total_error_train);
hold on; plot(total_error_test,'r');
xlabel('iteration');
ylabel('error');
legend('training error','test error');

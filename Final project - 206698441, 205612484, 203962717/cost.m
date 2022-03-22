function [th, trainingError,validationError] = cost(theta, xtrain,ytrain,xVal,yVal,alpha,iter)

% This function calculates the cost function for logistic regression without
% regularization (lambda). 

th=theta;
m=size(xtrain,1);
for i=1:iter
    
    % Train model
    h=sigmoid(xtrain*th);
    hV=sigmoid(xVal*th); % Validation prediction with current weights
    J = -alpha*(1/m)*sum((h-ytrain).*xtrain);
    th=th+J';
    
    % Calculate training error
    yT = zeros(size(ytrain));
    yT(h>=0.5)=1;
    trainingError(i)= sum(yT ~= ytrain)/length(yT);
    
    % Calculate validation error
    yV = zeros(size(yVal));
    yV(hV>=0.5)=1;
    validationError(i) = sum(yV ~= yVal)/length(yV);
end

grad=zeros(size(theta,1),1);

for i=1:size(grad)
    grad(i)=(1/m)*sum((h-ytrain)'*xtrain(:,i));
end

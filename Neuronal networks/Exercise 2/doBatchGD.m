function [error, W] = doBatchGD(X,t,W,lambda,epoch)
    m = length(X);
    
    % Add code: Calculate the predictions y
    y = [];
    for i = 1:m
        y = [y,W(2)*X(i)+W(1)];
    end
    
    % Add code: Calculate error function
    error = 0;
    for i = 1:m
        error = error + (y(i)-t(i))^2;
    end
    error = error/(2*m);
    
    % Add code: Calculate gradients
    grad0 = 0;
    grad1 = 0;
    for i = 1:m
        grad0 = grad0 + (y(i)-t(i));
        grad1 = grad1 + (y(i)-t(i))*X(i);
    end
    grad0 = grad0/m;
    grad1 = grad1/m;
    
    % Add code: Calculate delta weights
    delta_w0 = grad0*-1*lambda;
    delta_w1 = grad1*-1*lambda;
    
    % Add code: Calculate new weights
    W(1) = W(1)+delta_w0;
    W(2) = W(2)+delta_w1;
    
    if (mod(epoch,10)==0)
        figure;
        plotWithPrediction(X,t,W);
    end
end

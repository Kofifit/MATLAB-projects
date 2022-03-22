function [wInputHidden, wHiddenOutput] = UpdateWeights(wInputHidden, wHiddenOutput, lambda, x, yOutput, yHidden, y_expected, alpha)
    deltaOutput = (y_expected - yOutput);
    deltaHidden = yHidden.*(1 - yHidden).* deltaOutput .* wHiddenOutput';
    
    % TODO: add regularization (weight decay) here :
    wInputHidden = wInputHidden + lambda * ((deltaHidden * x))-lambda*alpha*wInputHidden;
    wHiddenOutput = wHiddenOutput +  lambda * ((deltaOutput * yHidden'))-lambda*alpha*wHiddenOutput;
end


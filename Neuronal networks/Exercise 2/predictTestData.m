function test_error = predictTestData(test_X, test_t, W)
    m = length(test_X);
    % Add code - Calculate the prediction y
    y = [];
    for i = 1:m
        y = [y,W(2)*test_X(i)+W(1)];
    end
    % Add code - Calculate test error function
    test_error = 0;
    for i = 1:m
        test_error = test_error + (y(i)-test_t(i))^2;
    end
    test_error = test_error/(2*m);
    
    figure;
    plotWithPrediction(test_X,test_t,W);
end
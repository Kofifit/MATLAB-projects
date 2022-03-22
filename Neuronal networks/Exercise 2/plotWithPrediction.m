function plotWithPrediction(X, Y, W)
    hold on;
    scatter(X,Y)
    ylabel('House Price (in 1M$)');
    xlabel('Salary (in 1K$)');
    title(['W1=',num2str(W(2),3),', W0=',num2str(W(1),3)]);    
    
    % Add Code - Plot the predicted linear function
    y_predict = X*W(2)+W(1);
    plot(X,y_predict,'r');
end
function total_error=CalcError(wInputHidden, wHiddenOutput, xall, y_expected, alpha)
    for i=1:size(xall,1); % over all examples
        x = xall(i,:);% take example i of digit 0
        yHidden = CalcForward(wInputHidden, x);
        yOutput = CalcForward(wHiddenOutput, yHidden');
        
        y_predicted(i,1)=yOutput;
    end
    
    total_error=-(1/length(y_expected))*sum(y_expected.*log(y_predicted)+(1-y_expected).*log(1-y_predicted));
end

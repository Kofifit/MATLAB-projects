function [xtrainCurrent,ytrainCurrent, xtest, ytest] = convertData(subSets_validation,data_test)

% This function converts data from cells and strings to double matrix. This
% is done for the function 'logisticRegressionModel.m', which is able to
% process only double as input.

xtrainCurrent=cell(1,5); % divide to 5 fold sets
ytrainCurrent=cell(1,5); % divide to 5 fold sets

for i = 1:5
    yTrain = subSets_validation{i};
    ytrainCurrent{i} = yTrain{:,17};
end
ytest = data_test{:,17};

% Convert input data from table to double
for j = 1:6
    
    if j < 6
        all = subSets_validation{j};
    else
        all = data_test;
    end
    
    x = table2cell(all(:,5:16)); % input data
    m=size(x,1);

    % Convert x cell array into a double matrix
    c5 = x(:,1);
    C5 = zeros(m,1);

    for i=1:m
        if strcmp(c5(i,1),'yes')
          C5(i)=1;
        elseif strcmp(c5(i,1),'no')
            C5(i,1)=2;
        end
    end

    c6 = x(:,2);
    C6 = zeros(m,1);

    for i=1:m
        if strcmp(c6(i,1),'yes')
          C6(i)=1;
        elseif strcmp(c6(i,1),'no')
            C6(i)=2;
        end
    end

    C7 = cell2mat(x(:,3));

    C8 = cell2mat(x(:,4));

    c9 = x(:,5);
    C9 = zeros(m,1);

    for i=1:m
        if strcmp(c9(i,1),'Sometimes')
          C9(i)=1;
        elseif strcmp(c9(i,1),'no')
            C9(i)=2;
        elseif strcmp(c9(i,1),'Always')
            C9(i)=3;
        elseif strcmp(c9(i,1),'Frequently')
            C9(i)=4;
        end
    end

    c10 = x(:,6);
    C10 = zeros(m,1);

    for i=1:m
        if strcmp(c10(i,1),'yes')
          C10(i)=1;
        elseif strcmp(c10(i,1),'no')
            C10(i)=2;
        end
    end

    C11 = cell2mat(x(:,7));

    c12 = x(:,8);
    C12 = zeros(m,1);

    for i=1:m
        if strcmp(c12(i,1),'yes')
          C12(i)=1;
        elseif strcmp(c12(i,1),'no')
            C12(i)=2;
        end
    end

    C13 = cell2mat(x(:,9));

    C14 = cell2mat(x(:,10));

    c15 = x(:,11);
    C15 = zeros(m,1);

    for i=1:m
        if strcmp(c15(i,1),'Sometimes')
          C15(i)=1;
        elseif strcmp(c15(i,1),'no')
            C15(i)=2;
        elseif strcmp(c15(i,1),'Always')
            C15(i)=3;
        elseif strcmp(c15(i,1),'Frequently')
            C15(i)=4;
        end
    end


    c16 = x(:,12);
    C16 = zeros(m,1);

    for i=1:m
        if strcmp(c16(i,1),'Public_Transportation')
          C16(i)=1;
        elseif strcmp(c16(i,1),'Walking')
            C16(i)=2;
        elseif strcmp(c16(i,1),'Automobile')
            C16(i)=3;
        elseif strcmp(c16(i,1),'Motorbike')
            C16(i)=4;
        elseif strcmp(c16(i,1),'Bike')
            C16(i)=5;    
        end
    end

    x = [];
    x(:,1) = C5;
    x(:,2) = C6;
    x(:,3) = C7;
    x(:,4) = C8;
    x(:,5) = C9;
    x(:,6) = C10;
    x(:,7) = C11;
    x(:,8) = C12;
    x(:,9) = C13;
    x(:,10) = C14;
    x(:,11) = C15;
    x(:,12) = C16;
    
    if j < 6
        xtrainCurrent{j} = x;
    else
        xtest = x;
    end
    
end




   

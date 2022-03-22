function [thetaTest,xtest,ytest] = logisticRegressionModel(subSets_validation,data_test)

% This function get 2 inputs - an array of 5 cells with validation subset
% table in each, a table with test set data.
% The output is a double vector of thetas (weights), a double marix with
% predictorsof test set and a vector with real labels of test set.
% The function create logistic regression models for the training data.
% Section 1 - The models are created with regularization. The following
% function are used 'cost', 'sigmoid'.
% Section 2 - the regularization is added to the creation of the
% models (lambda is added to the cost function). The following functions
% function are used 'costRegu', 'sigmoid'.
% Section 3 - The models are trained with grid search in order to find the
% optimized hyperparameters: number of iterations, alpha (learning
% parameter), lambda (regularization parameter). The following functions
% were used 'gridSearch'.

%% convert data fom cells and strings to double matrices

[xtrainCurrent,ytrainCurrent,xtest,ytest] = convertData(subSets_validation,data_test);

%% cross validation - question 4

for i=1:5
    
    % Creating data sets for use
    XvalidSet=xtrainCurrent{1,i};
    YvalidSet=ytrainCurrent{1,i};
    vec15 = (1:5);
    vec15(vec15==i)=[];
    XtrainSet=[xtrainCurrent{vec15(1)};xtrainCurrent{vec15(2)};xtrainCurrent{vec15(3)};xtrainCurrent{vec15(4)}];
    YtrainSet=[ytrainCurrent{vec15(1)};ytrainCurrent{vec15(2)};ytrainCurrent{vec15(3)};ytrainCurrent{vec15(4)}];
    
    % Setting hyperparameters
    iter=1000; % number of iterations for weight updation 
    theta=zeros(size(XtrainSet,2),1); % Initial weights 
    alpha=0.1; % Learning parameter 
    
    % Training model
    [~, JvecT,JvecV]=cost(theta,XtrainSet, YtrainSet,XvalidSet,YvalidSet,alpha,iter); % Cost function training set
    figure;
    plot(JvecT*100)
    hold on
    plot(JvecV*100)
    xlabel('Number of iterations');
    ylabel('Error (percentage)');
    ylim([0 80]);
    title_fig = sprintf('Error for %d Fold',i);
    title(title_fig);
    legend({'Training error','Validation error'});

end


%% regularization - question 5

for i=1:5
    
    % Creating data sets for use
    XvalidSet=[xtrainCurrent{1,i}];
    YvalidSet=[ytrainCurrent{1,i}];
    vec15=(1:5);
    vec15(vec15==i)=[];
    XtrainSet=[xtrainCurrent{1,vec15(1,1)};xtrainCurrent{1,vec15(1,2)};xtrainCurrent{1,vec15(1,3)};xtrainCurrent{1,vec15(1,4)}(:,:)];
    YtrainSet=[ytrainCurrent{1,vec15(1,1)};ytrainCurrent{1,vec15(1,2)};ytrainCurrent{1,vec15(1,3)};ytrainCurrent{1,vec15(1,4)}(:,:)];
    
    % Setting hyperparameters
    iter=1000; % number of iterations for weight updation 
    theta=zeros(size(XtrainSet,2),1); % Initial weights 
    alpha=0.1; % Learning parameter 
    lambda=0.5; % Regularization parameter
    
    % Training model with regularization (lambda)
    [~, JvecT, JvecV]=costRegu(theta,XtrainSet, YtrainSet,XvalidSet,YvalidSet,alpha,iter,lambda); % Cost function training set
    figure;
    plot(JvecT*100)
    hold on
    plot(JvecV*100)
    xlabel('Number of iterations');
    ylabel('Error (percentage)');
    ylim([0 80]);
    title_fig = sprintf('Error for %d Fold with regularization',i);
    title(title_fig);
    legend({'Training error','Validation error'});
end


%% Grid search - question 6


for j=1:5
    XvalidSet=[xtrainCurrent{1,j}];
    YvalidSet=[ytrainCurrent{1,j}];
    vec15=[1:5];
    vec15(vec15==j)=[];
    XtrainSet=[xtrainCurrent{1,vec15(1,1)};xtrainCurrent{1,vec15(1,2)};xtrainCurrent{1,vec15(1,3)};xtrainCurrent{1,vec15(1,4)}(:,:)];
    YtrainSet=[ytrainCurrent{1,vec15(1,1)};ytrainCurrent{1,vec15(1,2)};ytrainCurrent{1,vec15(1,3)};ytrainCurrent{1,vec15(1,4)}(:,:)];
    theta=zeros(size(XtrainSet,2),1); % Initial weights 
   lambdaVec=[0.2:0.2:2]; %lambda hyperparameter vector
   alphaVec=[0.1:0.1:1]; %alpha hyperparameter vector
   iterVec=[100:100:1000]; % number of iteractions vector
   %all hyperparameter vectors must have the same length
   [iter, alpha, lambda, Jf, TH]= gridSearch(theta, XtrainSet,YtrainSet,alphaVec,iterVec,lambdaVec); %grid search for optimal hyperparameter for the training set
   matGridT(j,:)=[iter, alpha, lambda Jf]; %the best hyperparameter for every fold- training set
   THtr(:,j)=TH;
end
disp(matGridT);


%% Choose best model with minimal validation error - for questions 9 & 10

%thetaTest variable is the theta vector for the best model of the VALIDATION SET.

[~, minInd] = min(matGridT(:,4));
thetaTest = THtr(:,minInd);




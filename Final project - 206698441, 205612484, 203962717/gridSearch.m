function [iter2, alpha2, lambda2, Jf, TH2]= gridSearch(theta, xtrain,ytrain,alpha,iter,lambda)

% This function finds the best hyperparameters - number of iterations,
% learning parameters alpha, regularization parameter lambda.

th=theta;
m=size(xtrain,1);
coVec=combvec(lambda,alpha);

for ii=1:length(iter)  
    iter1=iter(ii);
    
    for i=1:iter1
        
        h=sigmoid(xtrain*th);
        Jnon=-(1/m)*sum(ytrain.*log(h)+(1-ytrain).*log(1-h));
        th=th+(coVec(2,ii)/length(xtrain))*xtrain'*(ytrain-h);
        regu=(1/m).*coVec(1,ii).*sum(th(2:end).^2);
        J=Jnon+regu;
        Jvec(i)=J;
        
        if Jvec(i)==min(Jvec)
            iter2=iter1;
            alpha2=coVec(2,ii);
            lambda2=coVec(1,ii);
            Jf=J;
            TH2=th;
        end
    end
end




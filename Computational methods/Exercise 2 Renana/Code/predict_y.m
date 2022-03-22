function predicted = predict_y(X, theta)

num_samples = size(X,1);
predicted = zeros(num_samples,1);

for index = 1:num_samples
    t = dot(X(index,:),theta);
    if t > 0 
        predicted(index) = 1;
    else
        predicted(index) = -1;
    end
end
        
end
k = 0;
trainSet = []; % Matrix
centroidMat = zeros(size(trainSet,1),k);
distanceMat = zeros(k,size(trainSet,2));
assignments_new = zeros(1,size(trainSet,2));
s = false;

% randomly selecting centroids
for i = 1:k
    x = randi(1:length(trainSet));
    centroidMat(:,i) = trainSet(:,x);
end
    
while s == false 

    % update assign_points_old
    assignments_old = assignments_new;
    
    dis_sum = 0;
    % create distance matrix
    for j = 1:size(trainSet,2)
        for i = 1:k
            for d = 1:size(trainSet,1)
                dis_sum = dis_sum + (trainSet(d,j)-centroidMat(d,i))^2;
            end
            distanceMat(i,j) = sqrt(dis_sum);
        end
    end

    % assign points to centroids
    for i = 1:size(distanceMat,2)
        vector = distanceMat(:,i);
        min_centroid = find(vector == min(vector));
        assignments_new(i) = min_centroid;
    end
    
    sumMat = zeros(size(trainSet,1),k);
    % update centroids
    for j = 1:length(assignments_new)
       for i = 1:size(trainSet,1)
           sumMat(i,assignments_new(j)) = sumMat(i,assignments_new(j)) + trainSet(i,j);
       end
    end
    for i = 1:k
        num_points = find(assignments_new == i);
        centroidMat(:,i) = sumMat(:,i)/num_points;
    end
    
    % check for changes
    if assignments_old == assignments_new
        s = true;
    end
end



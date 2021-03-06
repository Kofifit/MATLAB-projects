k_num_points = 0;
training_set = []; % Matrix - rows are parameters, cols are samples.
centroids = [];
distance = [];
points_new = [];
stop = 0;

% assign starting centroids
for i = 1:k_num_points
    x = randi(1:length(training_set));
    centroids(:,i) = training_set(:,x);
end
    
while stop == 0
    points_old = points_new;

    % assuming we only have two parameters
    for j = 1:size(training_set,2)
        for i = 1:k_num_points
            distance(i,j) = sqrt((training_set(1,j)-centroids(1,i))^2+(training_set(2,j)-centroids(2,j))^2);
        end
    end
    
    % Find distances
    for i = 1:size(distance,2)
        vec = distance(:,i);
        a = find(vec == min(vec));
        points_new(i) = a;
    end
    
    sumMat = zeros(size(training_set,1),k_num_points);
    % update centroids
    for j = 1:length(points_new)
       for i = 1:size(training_set,1)
           sumMat(i,points_new(j)) = sumMat(i,points_new(j)) + training_set(i,j);
       end
    end
    for i = 1:k_num_points
        num_points = find(points_new == i);
        centroids(:,i) = sumMat(:,i)/num_points;
    end
    
    % stopping the algorithm
    if points_old == points_new
        stop = 1;
    end
end



function model = train_model_sigmoid(data, params,title_fig)
%% Initialize
rng(params.seed)

[num_samples, num_features] = size(data.X);
% initialize W to random values

theta =  rand(1,num_features);

%% SGD with Sigmoid
figure;
clf; hold on
title(title_fig);
xlabel('learning epoch'); ylabel('train error');
error = [];
counter = 0;
for epoch = 1:params.max_epoch
    fprintf('\nEpoch #%i: ', epoch)
    
    % Arrange samples in random order for each learning epoch
    epoch_order = randperm(num_samples);
    % Initialize the error
    error(epoch) = 0;
    
    % we will use gradient descent to train our model
    for iter = 1:num_samples
        % Get current sample
        sample_index = epoch_order(iter);
        current_sample = data.X(sample_index,:); 
        current_label = data.Y(sample_index); 
        % Change label -1 to 0
        for i = 1:length(current_label)
            if current_label(i) == -1
                current_label(i) = 0;
            end
        end
        % Update weights
        Gx = sigmf(dot(theta,current_sample), [1,0]);
        cost = -current_label.*log(Gx)+ (current_label-1).*log(1-Gx);
        change_vec = params.alpha*(Gx - current_label)*current_sample;
        theta = theta - change_vec;
        error(epoch) = error(epoch) + cost;
    end
    
    error(epoch) = error(epoch)/num_samples; % normalize error
    % Plot average error
    if epoch>params.convergence_window
        plot(epoch, mean(error(epoch-params.convergence_window:epoch)), '.', 'MarkerSize', 10)
        drawnow
    else
        plot(epoch,error(epoch),'.','MarkerSize',10);
        drawnow
    end
    
     % Stopping criteria
    if epoch > 100 && length(params.max_epoch) == 1
        new_mean_error = mean(error((epoch-params.convergence_window):epoch));
        old_mean_error = mean(error(epoch-2*params.convergence_window:epoch-params.convergence_window));
        if old_mean_error < new_mean_error 
            counter = counter + 1;
        end
        if counter > 10
            disp(sprintf('Training stopped on %d epoch',epoch));
            break
        end
    end

end

%% Output model
model.theta = theta;
model.training_error = error;
model.num_of_epochs = epoch;
end
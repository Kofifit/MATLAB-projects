function [settings, params] = load_settings_params()

    %%  SETTINGS
    settings.dataset_file = 'Neurons.txt';
    settings.path2data = fullfile('..', 'Data',settings.dataset_file);

    %% MODEL PARAMETERS
    params.seed = 1;
    params.alpha = [0.1,0.001,0.01,0.05,0.5,1,5,50];   
    params.lambda = [0.1,0.001,0.005,0.01,0.2,0.5,3,5];
    params.max_epoch = [500,50,100,150,200,300,1000,2000];
    params.convergence_window = 50;
    params.CV_k = 5;                 

end
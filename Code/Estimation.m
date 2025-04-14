
% Simulate observed valence (0-100 scale)
V_obs = [10, 0, 70, 0, 100] / 100;                                          % Normalize to 0-1

% Simulate rewards (R) and trials
R = [0, 2, 8, 4, 10];

% Define the loss function
loss_function = @(params) compute_loss(params, R, V_obs);

% Initial guesses for alpha and pi
initial_params = [0.1, 0.1];

% Bounds: alpha ∈ [0,1], pi ∈ [0,2]
lb = [0, 0];
ub = [1, 2];

% Optimize using fmincon (MATLAB's constrained optimizer)
options = optimoptions('fmincon', 'Display', 'iter');
result = fmincon(loss_function, initial_params, [], [], [], [], lb, ub, [], options);

% Extract optimal parameters
alpha_opt = result(1);
pi_opt = result(2);

fprintf('Optimal α: %.2f, Optimal π: %.2f\n', alpha_opt, pi_opt)
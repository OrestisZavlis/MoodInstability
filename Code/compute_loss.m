
% Loss function definition
function mse = compute_loss(params, R, V_obs)
         
         % Initialize
         alpha = params(1);
         pi_param = params(2); mu = 0;
         V_pred = zeros(1, length(R));
         
         % Estimate model
         for t = 1:length(R)
             delta = R(t) - mu;
             V_pred(t) = 1 / (1 + exp(-pi_param * delta));
             mu = mu + alpha * delta;
         end
        
         % Compute mean squared error
         mse = mean((V_obs - V_pred).^2);
         
end
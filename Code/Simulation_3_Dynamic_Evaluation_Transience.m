

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%% A FORMAL THEORY OF MOOD INSTABILITY %%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% SIMULATION 3 EMOTIONAL TRANSIENCE %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%   R  -  Objective  value   (stimuli as such: $100)
% V(R) -  Subjective value   (stimuli as perceived: cheap)
% m=μ  -  Reference point    (baseline standard/wish for rewards)
% p=π  -  Weight             (weight of the prediction error R-μ)
% α=a  -  Learning rate      (learning of reference based on R-μ)

% Simulation 2 involves tuning these parameters to generate:
% 1. Healthy              evaluation  (μ=60, π=1/20, α=0.2)
% 2. Transient            evaluation  (μ=60, π=1/20, α=0.99)
% 3. Transient & Reactive evaluation  (μ=60, π>1/20, α=0.99)

% Simulations are based on a dynamic evaluation model, outlined in:
% Zavlis Bentall Fonagy Rigoli (2024) A formal theory of mood instability




clear all                                                                   % Clear all variables
rng(6969)                                                                   % Random seed to ensure reproducibility




% ---------------------------------------------------------------------- % 
% ------------------------------ REALITY ------------------------------- % 
% ---------------------------------------------------------------------- % 
for i=1:300                                                                 % For loop running from 1 to 300 R outcomes
    [r index] = max(mnrnd(1,[0.33 0.34 .33]));                              % Randomly select index (1-3) from a multinomial distribution with probabilities [0.33 0.34 .33]
    index_T(1,i) = (index-2)*10;                                            % Maps the chosen index (1-3) onto a scaled value: -10 (index=1), 0 (index=2), +10 (index=3)
end                                                                         % Outcome is vector with 300 raw reality (R) values

% Moderate Reality
for i = [1:50 151:200]                                                      % For loop on R outcomes (1:50) and (151:200)
    outcome(1,i) = index_T(1,i) + 60;                                       % Add +60 to these outcomes to create moderate reality
end                                                                         % Outcome is 100 trials representing moderate reality

% Positive Reality
for i = [51:100 201:250]                                                    % For loop on R outcomes (51:100) and (201:250)
    outcome(1,i) = index_T(1,i) + 100;                                      % Add +100 to these outcomes to create positive reality
end                                                                         % Outcome is 100 trials representing positive reality

% Negative Reality
for i = [101:150 251:300]                                                   % For loop on R outcomes (101:150) and (251:300)
    outcome(1,i) = index_T(1,i) + 20;                                       % Add +20 to these outcomes to create negative reality
end                                                                         % Outcome is 100 trials representing negative reality

subplot(4,1,1)                                                              % (4rows, 1cols, plot 1st panel)
plot(outcome)                                                               % Plot reality (raw values)
title(['(A) Objective Value History'], 'FontSize', 10.8)                    % Title reality function
ylabel ('R', 'FontSize', 10)                                                % Plot y axis only
ax = gca;                                                                   % Get existing axes handle
ax.YTick = 0:20:100;                                                        % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% --------------------------- HEALTHY AFFECT --------------------------- % 
% ---------------------------------------------------------------------- % 
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.2;                                                                % Adaptive learning rate: 0.2
p = 1/20;                                                                   % Adaptive weight-precision: 1/20
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vh(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 healthy values
subplot(4,1,2)                                                              % (4rows, 1cols, plot 2nd panel)
plot(Vh)                                                                    % Plot healthy affective values
title(['(B) Healthy Evaluation (μ{_0}=60, π=0.05, α=0.2)'], ...             % Plot healthy affective title
       'FontSize', 10.8)                                                    % Adjust font size
ylabel ('V(R)', 'FontSize', 10)                                             % Plot y axis only
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% ------------------------ EMOTIONAL TRANSIENCE ------------------------ % 
% ---------------------------------------------------------------------- % 
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.99;                                                               % Maladaptively high learning: 0.99
p = 1/20;                                                                   % Adaptive weight-precision: 1/20
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vt(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 transient values
subplot(4,1,3)                                                              % (4rows, 1cols, plot 3rd panel)
plot(Vt)                                                                    % Plot transient affective values
title(['(C) Emotional Transience (μ{_0}=60, π=0.05, α=0.99)'], ...          % Plot transient affective title
       'FontSize', 10.8)                                                    % Adjust font size
ylabel ('V(R)', 'FontSize', 10)                                             % Plot y axis only
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% ---------------------- TRANSIENCE & REACTIVITY ----------------------- % 
% ---------------------------------------------------------------------- % 
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.99;                                                               % Maladaptively high learning: 0.99
p = 1/10;                                                                   % Maladaptively low weight-precision: 1/10
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vtr(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                             % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 trans-react values
subplot(4,1,4)                                                              % (4rows, 1cols, plot 4th panel)
plot(Vtr)                                                                   % Plot transient-reactive values
title(['(D) Emotional Transience & ' ...                                    % Plot transient affective title
       'Emotional Reactivity (μ{_0}=60, π=0.1, α=0.99)'], ...               % As well as reactivity affective title
       'FontSize', 10.8)                                                    % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% --------------------------- PRINT FIGURE 3 --------------------------- % 
% ---------------------------------------------------------------------- % 
printfigure(10, 10, 'Figure 3.pdf')                                         % See function printfigure


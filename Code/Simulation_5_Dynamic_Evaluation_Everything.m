

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%% A FORMAL THEORY OF MOOD INSTABILITY %%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%% SIMULATION 2 AFFECTIVE RIGIDITY %%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%   R  -  Objective  value   (stimuli as such: $100)
% V(R) -  Subjective value   (stimuli as perceived: cheap)
% m=μ  -  Reference point    (baseline standard/wish for rewards)
% p=π  -  Weight             (weight of the prediction error R-μ)
% α=a  -  Learning rate      (learning of reference based on R-μ)

% Simulation 2 involves tuning these parameters to generate:
% 1. Bipolar     evaluation  (μ=60, π=1/20, α=0.001)
% 2. Depressive  evaluation  (μ>60, π=1/20, α=0.001)
% 3. (Hypo)Manic evaluation  (μ<60, π=1/20, α=0.001)
% 4. Transient            evaluation  (μ=60, π=1/20, α=0.99)
% 5. Transient & Reactive evaluation  (μ=60, π>1/20, α=0.99)
% 6. Reactive             evaluation  (μ=60, π>1/20, α=0.2)
% 7. Reactive  & Bipolar  evaluation  (μ=60, π>1/20, α=0.001)

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


% ---------------------------------------------------------------------- %
% -------------------------- BIPOLAR RIGIDITY -------------------------- %
% ---------------------------------------------------------------------- %
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.001;                                                              % Maladaptively low learning rate: 0.001
p = 1/20;                                                                   % Adaptive weight-precision: 1/20
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vb(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 bipolar values
subplot(2,3,1)                                                              % (2rows, 3cols, plot 1st panel)
plot(Vb)                                                                    % Plot bipolar affective values
title(['Bipolar Rigidity (μ{_0}=60, π=0.05, α=0.001)'], ...                 % Plot bipolar affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
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
subplot(2,3,2)                                                              % (2rows, 3cols, plot 2nd panel)
plot(Vt)                                                                    % Plot transient affective values
title(['Emotional Transience (μ{_0}=60, π=0.05, α=0.99)'], ...              % Plot transient affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% ------------------------ EMOTIONAL REACTIVITY ------------------------ % 
% ---------------------------------------------------------------------- % 
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.2;                                                                % Adaptive learning rate: 0.2
p = 1/10;                                                                   % Maladaptively low weight-precision: 1/10
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vr(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 reactive values
subplot(2,3,3)                                                              % (2rows, 3cols, plot 3rd panel)
plot(Vr)                                                                    % Plot reactive affective values
title(['Emotional Reactivity (μ{_0}=60, π=0.1, α=0.2)'], ...                % Plot reactive affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- %
% ------------------------- DEPRESSIVE RIGIDITY ------------------------ %
% ---------------------------------------------------------------------- %
mu = 100;                                                                   % Maladaptively high reference point: 100
alpha = 0.001;                                                              % Maladaptively low learning rate: 0.001
p = 1/20;                                                                   % Adaptive weight-precision: 1/20
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vd(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 depressive values
subplot(2,3,4)                                                              % (2rows, 3cols, plot 4th panel)
plot(Vd)                                                                    % Plot depressive affective values
title({'Manic Rigidity (μ{_0}=20, π=0.05, α=0.001) &', ...                  % Plot manic affective title
       'Depressive Rigidity (μ{_0}=100, π=0.05, α=0.001)'}, ...             % Plot depressive affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20
hold on                                                                     % Keep current figure (4th panel) open...


% ---------------------------------------------------------------------- % 
% --------------------------- MANIC RIGIDITY --------------------------- % 
% ---------------------------------------------------------------------- % 
mu = 20;                                                                    % Maladaptively low reference point: 20
alpha = 0.001;                                                              % Maladaptive low learning rate: 0.001
p = 1/20;                                                                   % Adaptive weight-precision: 1/20
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vm(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                              % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 manic values
plot(Vm)                                                                    % Plot manic affective values
hold off                                                                    % ...Close current figure (4th panel)


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
subplot(2,3,5)                                                              % (2rows, 3cols, plot 5th panel)
plot(Vtr)                                                                   % Plot transient-reactive values
title({'Emotional Transience & ', ...                                       % Plot transient affective title
       'Emotional Reactivity (μ{_0}=60, π=0.1, α=0.99)'}, ...               % As well as reactivity affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% ------------------------- BIPOLAR REACTIVITY ------------------------- % 
% ---------------------------------------------------------------------- % 
mu = 60;                                                                    % Adaptive reference: 60
alpha = 0.001;                                                              % Maladaptively low learning rate: 0.001
p = 1/10;                                                                   % Maladaptively low weight-precision: 1/10
for i=1:300                                                                 % For loop running from 1 to 300 trials
    Vrb(1,i) = 1 / (1+exp(p*(-outcome(i)+mu)));                             % Dynamic evaluation equation 1 (see manuscript)
    mu = mu + alpha * (outcome(i)-mu);                                      % Dynamic evaluation equation 2 (see manuscript)
end                                                                         % Outcome is vector with 300 react-bipolar values
subplot(2,3,6)                                                              % (2rows, 3cols, plot 6th panel)
plot(Vrb)                                                                   % Plot reactive-bipolar values
title({'Emotional Reactivity & ', ...                                       % Plot reactive affective title
       'Bipolar Rigidity (μ{_0}=60, π=0.1, α=0.001)'}, ...                  % As well as bipolar affective title
       'FontSize', 14)                                                      % Adjust font size
xlabel ('Trial', 'FontSize', 10); ylabel ('V(R)', 'FontSize', 10)           % Plot both x & y axes
ax = gca;                                                                   % Get current axes handle
ax.YTick = 0:0.2:1;                                                         % Set y-axis ticks at intervals of 20


% ---------------------------------------------------------------------- % 
% --------------------------- PRINT FIGURE 5 --------------------------- % 
% ---------------------------------------------------------------------- % 
printfigure(26, 12, 'Figure 5.pdf')                                         % See function printfigure

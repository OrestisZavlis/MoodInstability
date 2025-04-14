

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%% A FORMAL THEORY OF MOOD INSTABILITY %%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%% SIMULATION 1 Static Evaluation %%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%   R  -  Objective  value   (stimuli as such: $100)
% V(R) -  Subjective value   (stimuli as perceived: cheap)
% m=μ  -  Reference point    (baseline standard/wish for rewards)
% p=π  -  Precision          (weight of the prediction error R-μ)

% Simulation 1 involves tuning these parameters to generate:
% 1. Healthy     evaluation  (based on μ=mean(R) and π=1/SD(R))
% 2. Hypomanic   evaluation  (based on μ<mean(R) and π=1/SD(R))
% 3. Depressive  evaluation  (based on μ>mean(R) and π=1/SD(R))
% 4. Apathetic   evaluation  (based on μ=mean(R) and π>1/SD(R))
% 5. Reactive    evaluation  (based on μ=mean(R) and π<1/SD(R))

% Simulations are based on a static evaluation model, outlined in:
% Zavlis Bentall Fonagy Rigoli (2024) A formal theory of mood instability




clear all                                                                   % Clear all variables
R=[10:10:70];                                                               % Reality consists of stimuli ranging from 10 to 70




% ---------------------------------------------------------------------- % 
% ----------------------------- FIGURE 1A ------------------------------ % 
% ---------------------------------------------------------------------- % 
% ----- Maladaptive evaluation based on aberrant reference points ------ % 
% ---------------------------------------------------------------------- %  

subplot(1,2,1); hold on;                                                    % (1row, 2cols, plot 1st panel)
pbaspect([1 1 1]);                                                          % Equal scaling of axes (square)
xlabel ('R'); ylabel ('V(R)');                                              % R on x axis and V(R) on y axis
title('(A) Reference effects', FontSize=12)                                 % Add title to the first subplot

% Healthy Evaluation                                                        % True parameters:
m=mean(R);                                                                  % Reference is average of rewards: 40
p=1/std(R);                                                                 % Precision is 1/SD    of rewards: 0.05
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Static evaluation equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p0 = plot(RSmooth, VRSmooth);                                          % Plot first subplot of healthy evaluation

% (Hypo)Manic Evaluation                                                    % Excessively low reference:
m=0;                                                                        % Reference well below average implying sensitivity to rewards
p=1/std(R);                                                                 % Precision is 1/SD    of rewards: 0.05
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Reference-based equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p1 = plot(RSmooth, VRSmooth);                                          % Plot (hypo)mania on top of the first subplot of healthy evaluation

% Depressive Evaluation                                                     % Excessively high reference:
m=80;                                                                       % Reference is well above average implying insensitivity to rewards
p=1/std(R);                                                                 % Precision is 1/SD    of rewards: 0.05
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Reference-based equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p2 = plot(RSmooth, VRSmooth);                                          % Plot depression on top of the first subplot of healthy evaluation

% Colour the three (logistic) evaluation lines
set(fig1.p0, 'Color', [.5 .5 .5], 'LineWidth', 4);                          % Healthy     evaluation  =  grey line
set(fig1.p1, 'Color', 'red', 'LineWidth', 3);                               % (Hypo)Manic evaluation  =  red  line
set(fig1.p2, 'Color', 'blue', 'LineWidth', 3);                              % Depressive  evaluation  =  blue line



% ---------------------------------------------------------------------- % 
% ----------------------------- FIGURE 1B ------------------------------ % 
% ---------------------------------------------------------------------- % 
% --------- Maladaptive evaluation based on aberrant precision --------- % 
% ---------------------------------------------------------------------- % 

subplot(1,2,2); hold on;                                                    % (1row, 2cols, plot 1st panel)
pbaspect([1 1 1]);                                                          % Equal scaling of axes (square)
xlabel ('R');                                                               % Label only x axis
title('(B) Precision effects', FontSize=12)                                 % Add title to the first subplot

% Healthy Evaluation                                                        % True parameters:
m=mean(R);                                                                  % Reference is average of rewards: 40
p=1/std(R);                                                                 % Precision is 1/SD    of rewards: 0.05
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Reference-based equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p0 = plot(RSmooth, VRSmooth);                                          % Plot second subplot of healthy evaluation

% Apathetic Evaluation                                                      % Excessively low precision:
m=mean(R);                                                                  % Reference is average of rewards: 40
p=1/40;                                                                     % Precision is well below 1/SD implying blunted reactivity
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Reference-based equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p1 = plot(RSmooth, VRSmooth);                                          % Plot apathy on top of the second subplot of healthy evaluation

% Borderline Evaluation                                                     % Excessively high precision: 
m=mean(R);                                                                  % Reference is average of rewards (true value)
p=1/12;                                                                     % Precision is well above 1/SD implying strong reactivity
for i=1:7                                                                   % For loop running from 1 to 7 R outcomes
    VR(i)=1/(1+exp(-1.2*p*(R(i)-m)))                                        % Reference-based equation (see manuscript)
end                                                                         % Outcome is vector with 7 V(R) (subjective) values
[RSmooth, VRSmooth] = smoothaf(R, VR);                                      % Smoothaf is a function to smoothen values and make smooth lines
fig1.p2 = plot(RSmooth, VRSmooth);                                          % Plot apathy on top of the second subplot of healthy evaluation

% Colour the three (logistic) evaluation lines
set(fig1.p0, 'Color', [.5 .5 .5], 'LineWidth', 4);                          % Healthy evaluation    =  grey line
set(fig1.p1, 'Color', 'blue', 'LineWidth', 3);                              % Apathetic evaluation  =  blue line
set(fig1.p2, 'Color', 'red', 'LineWidth', 3);                               % Borderline evaluation =  red  line



% ---------------------------------------------------------------------- % 
% --------------------------- PRINT FIGURE 1 --------------------------- % 
% ---------------------------------------------------------------------- %  
printfigure(12, 6, 'Figure 1.pdf')                                          % See function printfigure


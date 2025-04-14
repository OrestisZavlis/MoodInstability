
# A formal model of mood instability


## Introduction 
This repository includes code on a model that formalizes mood instability using the computational process of (reference-based) evaluation: that is, the evaluation of stimuli (humans, objects, events) based on a comparative frame of reference (see Zavlis, Bentall, Fonagy, and Rigoli, 2024). This model has its origins in traditional cognitive theories, which converged on the idea that our evaluation of stimuli is typically based on a comparative frame of reference (see Rigoli, 2019). For example, according to Kahneman & Tversky's infamous prospect theory, how a person evaluates a pay raise depends on the kind of reference they use. If they use their current salary as a reference, they will probably feel elated. However, if they use an expectation of a higher salary as a reference, they might be indifferent or outright saddened.

In our paper, we argued that this process of evaluation can be used to explain the elusive psychological concept of ''mood instability''. Mood instability is found in virtually all psychopathologies, so creating a mathematical model that explains it may enable clinicians (and patients alike) to better understand and perhaps ameliorate it. The next two sections outline the two forms of this model: static and dynamic. 


## Static Evaluation
In its static form, the model proposes that the affective value V(R) of a stimulus is derived from a prediction error between its raw value (_R_) and a reference value (_μ_), moderated by a weight parameter (π) and filtered through a logistic function: 

<p align="center">
$V(R)=logistic(π(R-μ))$
</p>

where $V(R)$ is the subjective value of a given stimulus (which, given the logistic function, is bounded between 0 and 1); _R_ is the real value of the stimulus (e.g., $10); _μ_ is the reference-point (e.g., a desired amount of $20); and _π_ is the ‘weight’ attached to a given prediction error. 

In brief (see Zavlis et al., 2024 for details), this equation implies that the evaluation of a stimulus is based on two parameters. First, evaluation is based on one's reference point: When the objective value of a stimulus is higher than that reference point (R>μ), a reward is experienced (V(R) > 0.5); when it is lower (R < μ), a punishment is experienced (V(R) < 0.5); finally, when the two are equal (i.e., the stimulus matches the reference point; R = μ), the experience is neutral (V(R) = 0.5). Second, evaluation is based on one's certainty over the meaning of the predictiion error: When one's certainty is low (low _π_), their emotional experience will be blunted (deflated prediction error); however, when one's certainty is high (high _π_), their emotional experience will be intensified (inflated prediction error). 

In the first simulation (MATLAB file: Simulation_1_Static_Evaluation.m), I show how altering these two main parameters (in isolation, not in combination) reproduces different emotional problems. For example, setting the reference point extremely high reproduces the centuries-old observation that high-achieving (perfectionistic or narcissistic) people suffer from depression when life falls short of their (grand) expectations. Conversely, setting the reference point extremely low yields a hypersensitivity to rewards that mirrors (hypo)mania (i.e., excessive elation in response to even mild rewards). Finally, regarding the weight parameter, setting it extremely high yields apathy (almost complete non-responsiveness to any stimuli); while setting it low yields excessive mood reactivity characteristic of those with borderline personality (see Zavlis et al., 2024). 

Although these patterns are notable, they do not yet reproduce unstable emotions. I turn to the instability of these emotions in the next section where I ouline the dynamic version of reference-based evaluation. 


## Dynamic Evaluation
Adding a temporal dimension to the logistic model, yields a dynamic system of (reference-based) evaluation that is predicated on the following discrete equations: 

<p align="center">
$V(R_t)=logistic(π(R_t-μ_t))$
</p>
<p align="center">
$μ_{t+1}=μ_t + α(R_t-μ_t)$
</p>

where $V(R_t)$ refers to the affective value at time _t_, $R_t$ to its raw counterpart at time _t_; $μ_t$ and $μ_{t+1}$ are the reference points at times _t_ and _t+1_, respectively; _π_ is the weight parameter; and _α_ [0,1] is the learning rate (of the reference point). 

In brief (see Zavlis et al., 2024 for details), the first equation is the same as the one from static evaluation but extended over time to highlight that the evaluation of a stimulus at time point _t_ is predicated on the weighted prediction error between a referenced (i.e., expected or desired) stimulus for the same time point versus an observed (received) stimulus at that time point. The second equation enables the reference point to change over time based on the Rescorla-Wagner rule (which implies that ‘prediction errors’ drive learning about what the reference point should be in the future $μ_{t+1}$.

In the second to fourth simulations, I show how this model could generate three well-known longitudinal types of mood instability: namely, emotional rigidity (see MATLAB file: Simulation_2_Dynamic_Evaluation_Rigidity), emotional transience (see MATLAB file: Simulation_3_Dynamic_Evaluation_Transience), and emotional reactivity (see MATLAB file: Simulation_4_Dynamic_Evaluation_Reactivity). Briefly explained here as well, rigidity refers to the tendency to experience prolonged emotions (like persistent depression or mania) due to an extremely low learning rate; transiency refers to the tendency to experience fleeting emotions (as seen in borderline instability) due to an extremely high learning rate; finally, reactivity refers to the tendency to experience strong emotions (like reactive emotions, as seen in various temperamental disorders). These patterns are explored either in combination or in isolation and are fully depicted in the final simulation file (see MATLAB file: Simulation_5_Dynamic_Evaluation_Everything). 


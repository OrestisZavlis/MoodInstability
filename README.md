
# A formal model of mood instability

## Introduction 
This repository includes code on a model that formalizes mood instability using the computational process of (reference-based) evaluation: that is, the evaluation of stimuli (humans, objects, events) based on a comparative frame of reference (see Zavlis, Bentall, Fonagy, and Rigoli, 2024). This model has its origins in traditional cognitive theories, which converged on the idea that our evaluation of stimuli is typically based on a comparative frame of reference. (For example, according to Kahneman & Tversky's infamous prospect theory, how a person evaluates a pay raise depends on what reference they use. If they use their current salary as a reference, they will probably feel elated. However, if they use an expectation of a higher salary as a reference, they might be indifferent.) 

In our paper, we argued that this process of evaluation can be used to explain the elusive psychological concept of ''mood instability''. Mood instability is found in virtually all psychopathologies, so creating a mathematical model that explains it may enable clinicians (and patients alike) to better understand and perhaps ameliorate it. The next two sections outline the two forms of this model: static and dynamic. 

## Static Evaluation
In its static form (as first outlined by Rigoli, 2019), the model proposes that the subjective value V(R) of a stimulus is derived from a prediction error between its objective value (_R_) and a reference value (_μ_), weighted by some level of uncertainty (_σ_) and filtered through a logistic function: 

<p align="center">
$V(R)=logistic((R-μ)/σ)$
</p>

where V(R) is the subjective value of a given stimulus (which, given the logistic function, is bounded between 0 and 1); _R_ is the real value of the stimulus (e.g., $10); _μ_ is the reference-point (e.g., a baseline amount of $20); and _σ_ is evaluative uncertainty. 

In brief (see Zavlis et al., 2024 for details), this equation implies that the evaluation of a stimulus is based on two parameters. First, evaluation is based on one's reference point: When the objective value of a stimulus is higher than that reference point (R>μ), a reward is experienced (V(R) > 0.5); when it is lower (R < μ), a punishment is experienced (V(R) < 0.5); finally, when the two are equal (i.e., the stimulus matches the reference point; R = μ), the experience is neutral (V(R) = 0.5). Second, evaluation is based on one's uncertainty parameter: When one's uncertainty is extremely high (''Not sure what your behaviour means''), then their emotional experience is blunted; however, when one's uncertainty is low (''I am sure this is your fault!''), their emotional experience is intensified. 

In the first MATLAB file (Static_Evaluation.m), my team and I show that when we alter the two main parameters of this model (namely, reference point and uncertainty) we can reproduce different emotional problems (namely, depression / mania and apathy / reactivity, respectively). For a discussion on this, please see Zavlis et al. (2024). 

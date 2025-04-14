
function [xSmooth, ySmooth] = smoothaf(xInitial, yInitial)

% Length of x axis var
lengthX = length(xInitial);

% Flip sideways so there is only 1 y for every x
x = yInitial;
y = xInitial;

% Use splines to interpolate a smoother curve,
% with 10 times as many points,
% that goes exactly through the same data points.
samplingRateIncrease = 19;
newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
smoothedY = spline(x, y, newXSamplePoints);

% Now flip back
xSmooth = smoothedY;
ySmooth = newXSamplePoints;

end
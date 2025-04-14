
function [] = printfigure(width, height, title)

% Get current figure
fig = gcf;

% Set figure units and size
fig.Units = 'inches';
fig.PaperUnits = 'inches';
fig.Position(3:4) = [width, height];

% Configure paper settings
fig.PaperPositionMode = 'manual';
fig.PaperPosition = [0 0 width height];
fig.PaperSize = [width height];

% Set background color to white
fig.Color = 'white';
fig.InvertHardcopy = 'off';

% Save as PDF
print(fig, title, '-dpdf');                                                 

end
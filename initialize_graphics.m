function [mainAxis, PAD, pongPlot, PAD_W, PAD_H, axisTitle] = initialize_graphics()
%initialize_graphics creates the graphic environment for the hero
%Input arguments
%   none
%Output arguments
%   mainAxis - handle to the axes object
%   PAD - outline of the paddle
%   heroPlot - patch object for the paddle
%   PAD_W - width of the paddle
%   PAD_H - height of the paddle
%   handle to the axis title

PADDLE_START_Y = 50; %paddle start position
PAD_W = 3; %paddle width
PAD_H = 20; %paddle height
PAD_SHAPE = [0 0 0 0 1 1 1 1; ... %x values
  0 1 2 3 3 2 1 0];    %y values
xScale = PAD_W / max(PAD_SHAPE(1,:));
yScale = PAD_H / max(PAD_SHAPE(2,:));

%coordinats for drawing hero at 0,0.
%scale hero so that he's HERO_W wide and HERO_H tall
PAD = [PAD_SHAPE(1,:) .* xScale; PAD_SHAPE(2,:) .* yScale];


fig = figure;
set(fig,'color','black');
set(fig,'Resize','off');
pointer=NaN(16,16);
pointer(4,1:7) = 2;
pointer(1:7,4)=2;
pointer(4,4)=1;
set(fig,'Pointer','Custom');
set(fig,'PointerShapeHotSpot',[4 4]);
set(fig,'PointerShapeCData',pointer);
set(fig,'KeyPressFcn',@keyDownListener);
set(fig,'WindowButtonDownFcn', @mouseDownListener);
set(fig,'WindowButtonUpFcn', @mouseUpListener);
set(fig,'WindowButtonMotionFcn', @mouseMoveListener);
mainAxis = axes();
%set color for the court, hide axis ticks.
AXIS_COLOR = [0, 0, 0]; %the sky
set(mainAxis, 'color', AXIS_COLOR, 'YTick', [], 'XTick', []);

%handle for displaying the text press q to quit
axisTitle = title('');
font = 'Courier';
large_text = 20;
green = [.1, .7, .1];
title_color = green;
set(axisTitle,'fontsize', large_text)
%set(axisTitle, 'FontName', font,'fontsize', large_text);
set(axisTitle, 'Color', title_color);

%set size of the graphics window
axis([0 100 0 100]);
axis off;
pongPlot = patch(NaN,NaN,'g');
set(pongPlot,'LineWidth', 1);
set(pongPlot,'EdgeColor', 'w');
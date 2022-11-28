function [mainAxis, HERO, heroPlot, HERO_W, HERO_H, axisTitle] = initialize_graphics()
%initialize_graphics creates the graphic environment for the hero
%Input arguments
%   none
%Output arguments
%   mainAxis - handle to the axes object
%   HERO - outline of the hero
%   heroPlot - patch object for the hero
%   HERO_W - width of the hero
%   HERO_H - height of the hero
%   handle to the axis title

HERO_START_Y = 20; %hero start position
HERO_W = 25; %hero width
HERO_H = 100; %hero height
HERO_SHAPE = [0 0 25 25 0; ... %x values
  0 100 100 0 0];    %y values
xScale = HERO_W / max(HERO_SHAPE(1,:));
yScale = HERO_H / max(HERO_SHAPE(2,:));

%coordinats for drawing hero at 0,0.
%scale hero so that he's HERO_W wide and HERO_H tall
HERO = [HERO_SHAPE(1,:) .* xScale; HERO_SHAPE(2,:) .* yScale];

heroPos = [100 150];
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

%handle for displaying the score
axisTitle = title('');
font = 'Courier';
large_text = 12;
green = [.1, .7, .1];
title_color = green;
set(axisTitle,'fontsize', large_text)
%set(axisTitle, 'FontName', font,'fontsize', large_text);
set(axisTitle, 'Color', title_color);

%set size of the graphics window
axis([0 1200 0 800]);
axis off;
heroPlot = patch(NaN,NaN,'b');
set(heroPlot,'LineWidth', 1);
set(heroPlot,'EdgeColor', 'red');
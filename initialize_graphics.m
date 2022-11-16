function [mainAxis, PAD1, pongPlot, PAD_W, PAD_H, axisTitle, pongPlot2, PAD_W2, PAD_H2, PAD2] = initialize_graphics()

%initialize_graphics creates the graphic environment for the hero
%Input arguments
%   none
%Output arguments
%   mainAxis - handle to the axes object
%   PAD - outline of the paddle
%   PAD_W - width of the paddle
%   PAD_H - height of the paddle
%   PAD2 = OUTLINE OF P2 PADDLE
%   PAD_W2 - WIDTH OF P2 PADDLE
%   PAD_H2 = HEIGHT OF P2 PADDLE

PADDLE_START_Y = 50; %paddle start position
PAD_W = 3; %paddle width
PAD_H = 20; %paddle height
PAD_SHAPE = [0 0 0 0 1 1 1 1; ... %x values
  0 1 2 3 3 2 1 0];    %y values
xScale = PAD_W / max(PAD_SHAPE(1,:));
yScale = PAD_H / max(PAD_SHAPE(2,:));

PADDLE_START_Z = 75;    %paddle start position
PAD_W2 = 3;     %padde width
PAD_H2 = 20;        % paddle height
PAD_SHAPE2 = [0 0 0 0 1 1 1 1 ;     %X VALUES
    0 1 2 3 3 2 1 0 ];  % Y VALUES
  xScale2 = PAD_W2 / max(PAD_SHAPE2(1,:));
  yScale2 = PAD_H2 / max(PAD_SHAPE2(2,:));

%coordinates for drawing hero at 0,0.
%scale pads so that they are Pad_w & Pad_H size tall
PAD1 = [PAD_SHAPE(1,:) .* xScale; PAD_SHAPE(2,:) .* yScale];
PAD2 = [PAD_SHAPE2(1,:).*xScale2; PAD_SHAPE2(2,:).*yScale2];

% Pong Ball
BallStart = 51;     % ball start position
ballwidth = 2;
ballheight = 2;
ballshape = [1 1 1 ; 1 1 1 ];
ballxscale = ballwidth / max(ballshape(1,:));
ballyscale = ballwidth / max(ballshape(2,:)); 

%scale ball 
PongBall = [ballshape(1,:).*ballxscale; ballshape(2,:).* ballyscale];

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
pongPlot2 = patch(NaN,NaN,'g');
set(pongPlot2,'LineWidth', 1);
set(pongPlot2,'EdgeColor', 'w');


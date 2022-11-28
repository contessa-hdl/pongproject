function [ball_R, ball_Shape, ballPatch] = ballPlot()
ball_R = 30; %ball radius
th = [0:30:360 0];
ball_Shape = [ball_R*cosd(th); ... %x values
  ball_R*sind(th)];    %y values

ballPatch = patch(NaN,NaN,'r');
set(ballPatch,'LineWidth', 1);
set(ballPatch,'EdgeColor', 'white');
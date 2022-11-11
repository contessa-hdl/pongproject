function [mousePos] = draw_object2(mainAxis, objectOutline, objectPatch, object_width, object_height, mousePos)
%draw_object draws a graphics object on a set of axes
%Input arguments
%   mainAxis - handle to axes object
%   objectOutline - outline of the object
%   objectPatch - patch object for the object
%   object_width - width of the object
%   object_height - height of the object
%   mousePos - 2 element vector containing [x y] of the mouse position

objectOutlinePos = [mousePos(1) - (object_width * 0.5), mousePos(2) - (object_height * 0.5)];
curobjectOutline = [objectOutline(1,:) + objectOutlinePos(1); objectOutline(2,:) + objectOutlinePos(2)];
set(objectPatch, 'XData', curobjectOutline(1,:), 'YData', curobjectOutline(2,:));
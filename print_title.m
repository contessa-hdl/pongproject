function print_title(axisTitle, titlestring)
%titlestring prints a string as an axis title
%Input arguments:
%   axisTitle - handle to the axis title
%   titlestring - the string to print
%Output arguments:
%   none
set(axisTitle, 'String', titlestring);
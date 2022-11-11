function KeyPressFcnTest
close all;
h = figure;
set(h, 'WindowKeyFcn', @KeyPressFcn);
function KeyressFcn(~, event)
fprintf('key event is: %s\n' , event.Key);
end
end

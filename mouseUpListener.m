function mouseUpListener(src, event)
    %no body.
    %this handler must be registerd for axis 'CurrentPoint' to be
    %updated when mouse moves.
    global clickedUp
    clickedUp = true;
end
function [] = player1()

global quitGame;

quitGame = false;

[mainAxis, PAD, pongPlot, PAD_W, PAD_H, axisTitle] = initialize_graphics();

titlestring = "Type q to Quit";

print_title(axisTitle, titlestring);



while quitGame == false

    k = get(gcf,'CurrentCharacter');

    if k == 'q'
        
        quitGame = true;

    else

        pause(0.025)

        [mousePos] = get_mouse_position(mainAxis);

        draw_object(mainAxis, PAD, pongPlot, PAD_W, PAD_H, mousePos);
    end

end


end
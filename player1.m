function [] = player1()

global quitGame;

quitGame = false;

[mainAxis, PAD1, pongPlot, PAD_W, PAD_H, axisTitle, pongPlot2, PAD_W2, PAD_H2, PAD2] = initialize_graphics();

titlestring = "Type q to Quit";

print_title(axisTitle, titlestring);



while quitGame == false

    k = get(gcf,'CurrentCharacter');

    if k == 'q'
        
        quitGame = true;

    else

        [mousePos] = get_mouse_position(mainAxis);
        ypad = [5, mousePos(2)];    %record only y mouse coordinate to lock the paddle to the vertical axis
        
 % write player1's current mouse position       
        fid = fopen('player1data' , 'w');
        fprintf(fid, '%f\n', ypad);
        frewind(fid);
        fclose(fid);

        pause(0.025)
        
        % read player2's position
        fid = fopen( 'player2data' , 'r' );
        [ypad2] = fscanf(fid, '%f\n', [1,2]);
        frewind(fid);
        fclose(fid); 

        draw_object(mainAxis, PAD1, pongPlot, PAD_W, PAD_H, ypad);
        draw_object2(mainAxis, PAD2, pongPlot2, PAD_W2, PAD_H2, ypad2);

  

    end

end

end
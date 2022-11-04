function [] = player2()

global quitGame;

quitGame = false;

[mainAxis, HERO, heroPlot, HERO_W, HERO_H, axisTitle] = initialize_graphics();

titlestring = "Type q to Quit";

print_title(axisTitle, titlestring);



while quitGame == false

    k = get(gcf,'CurrentCharacter');

    if k == 'q'
        quitGame = true;

    else

        pause(0.025)

        [mousePos] = get_mouse_position(mainAxis);

        fid = fopen('player1data', 'w');

fprintf(fid,'%f',mousePos);
fclose(fid);

fid = fopen('player1data', 'r');
pad1pos = fscanf(fid,'%f',[1,2]);
fclose(fid);


        draw_object(mainAxis, HERO, heroPlot, HERO_W, HERO_H, mousePos);
    end

end


end
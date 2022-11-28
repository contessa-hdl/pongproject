function [] = player2()
%player2 is the function for the Player #2 in the Pong game
%Input arguments:
%   there are no inputs to this function
%Output arguments:
%   there are no outputs from this function
%Notes:
%   A two-player networked game in which a ball is batted back and forth
%   between 2 paddles.
%   player1 function is responsible for the movement of the left paddle.
%   This is complete code upt to step four.

global quitGame clickedUp;
quitGame = false; clickedUp = false;
[mainAxis, HERO, heroPlot, HERO_W, HERO_H, axisTitle] = initialize_graphics();
[ball_R, ball_Shape, ballPatch] = ballPlot();
heroPlot2 = copyobj(heroPlot,mainAxis); % for paddle 2

% plot arena
arenaWalls = copyobj(heroPlot,mainAxis); % for arena
set(arenaWalls,'FaceColor','green','EdgeColor','white')
    %left wall
    leftWall = copyobj(arenaWalls,mainAxis);
    draw_object(mainAxis, [0 0 4 4 0;0 800 800 0 0], leftWall, 4, 800, [2 400]);

    %right wall
    rightWall = copyobj(arenaWalls,mainAxis);
    draw_object(mainAxis, [0 0 4 4 0;0 800 800 0 0], rightWall, 4, 800, [1198 400]);

    %top wall
    topWall = copyobj(arenaWalls,mainAxis);
    draw_object(mainAxis, [0 0 1200 1200 0;0 4 4 0 0], topWall, 1200, 4, [600 798]);

    %bottom wall
    bottomWall = copyobj(arenaWalls,mainAxis);
    draw_object(mainAxis, [0 0 1200 1200 0;0 4 4 0 0], bottomWall, 1200, 4, [600 2]);

titlestring = {'Type "q" to Quit\color{white}';' ';...
    '\color{yellow}Waiting for Player #1 to join'};
print_title(axisTitle, titlestring)

% initialize the paddle positions
fclose all;
XY1 = [12.5 400]; XY2 = [1187.5 400];
save('player1_info.txt','XY1','-ascii');
save('player2_info.txt','XY2','-ascii');

% mark that player 2 has entered the game
f_name = 'P2_entry.txt';
P2_entry_id = fopen(f_name,'w');
fprintf(P2_entry_id,'%d\n', 1); % Player 2 joined
frewind(P2_entry_id)

P1_entry = 0;
% check if player 1 joined or not
while P1_entry~=1
    pause(0.025)
f_name = 'P1_entry.txt';
P1_entry_id = fopen(f_name,'r');
P1_entry = fscanf(P1_entry_id,'%d'); % Player 1 joined
frewind(P1_entry_id)
if quitGame
    break
end
end

% initialize not served
f_name = 'P2served.txt';
f_id = fopen(f_name,'w');
fprintf(f_id,'%d\n', 0);
frewind(f_id);
fclose(f_id);

if P1_entry == 1
titlestring = 'Type q to Quit';
print_title(axisTitle, titlestring)

% open the player 1 file for reading
P1_file_name = 'player1_info.txt';
P1_file_id = fopen(P1_file_name,'r');

% open a file for player 2 (writing)
P2_file_name = 'player2_info.txt';
P2_file_id = fopen(P2_file_name,'w');
fprintf(P2_file_id,'%f %f\n', [1187.5 400]');
frewind(P2_file_id)

% ball position communication file
ballPos_file_name = 'ball_position.txt';
ballPos_id = fopen(ballPos_file_name,'r');

% read the serve data
    pause(0.1)  %wait
    f_name = 'serve_info.txt';
    f_id = fopen(f_name,'r');
    first_serve = fscanf(f_id,'%d\n');
    frewind(f_id);
    fclose(f_id);

titlestring = {'Type "q" to Quit\color{white}';...
    sprintf('Player #%d owns the serve',first_serve);...
    ''};
print_title(axisTitle, titlestring)
    % initialize score file
    score_file_name = 'ScoreBoard.txt';
    score_file_id = fopen(score_file_name,'r');
while ~quitGame
    pause(0.02);
    % read the paddle 1 position from the file
    paddle_1_Pos = fscanf(P1_file_id,'%f %f');
    frewind(P1_file_id)
    paddle_1_Pos = paddle_1_Pos'; % reorient as original

    objectOutline = HERO;
    object_width = HERO_W;
    object_height = HERO_H;
    objectPatch = heroPlot;  objectPatch2 = heroPlot2;

    % get the mouse position
    [mousePos] = get_mouse_position(mainAxis);
    % lock on the right side and vertical movement limits
    paddle_2_Pos = [1200-HERO_W/2 mousePos(2)]; % lock at right side
    if paddle_2_Pos(2) > 800-HERO_H/2
        paddle_2_Pos(2) = 800-HERO_H/2;
    elseif paddle_2_Pos(2) < HERO_H/2
        paddle_2_Pos(2) = HERO_H/2;
    end

    [paddle_1_Pos] = draw_object(mainAxis, objectOutline, objectPatch, object_width, object_height, paddle_1_Pos);
    [paddle_2_Pos] = draw_object(mainAxis, objectOutline, objectPatch2, object_width, object_height, paddle_2_Pos);

    % write the paddle 2 position to the file
    fprintf(P2_file_id,'%f %f\n', paddle_2_Pos');
    frewind(P2_file_id)

    if clickedUp == true && first_serve == 2
        served = 1; clickedUp = false;
        % tell this to player 1
        f_name = 'P2served.txt';
        f_id = fopen(f_name,'w');
        fprintf(f_id,'%d\n', served);
        frewind(f_id);
        fclose(f_id);
    else
        % read the serve data
        f_name = 'serve_info.txt';
        f_id = fopen(f_name,'r');
        first_serve = fscanf(f_id,'%d\n');
        frewind(f_id);
        fclose(f_id);
    end

    % get the ball position from player 1
    new_ball_Pos = fscanf(ballPos_id,'%f %f');
    frewind(ballPos_id);
    if ~isempty(new_ball_Pos)
         ball_Pos = new_ball_Pos'; % reorient
    else
         ball_center_Pos = paddle_2_Pos-[(ball_R+HERO_W/2) 0];
         ball_Pos = ball_center_Pos+[ball_R ball_R];
    end
    [ball_Pos] = draw_object(mainAxis, ball_Shape, ballPatch, 2*ball_R, 2*ball_R, ball_Pos);

    % read scoreboard
    scores = fscanf(score_file_id,'%d %d');
    frewind(score_file_id);
    score1 = scores(1); score2 = scores(2);
    %update scoreboard
        titlestring = {'Type "q" to Quit\color{white}';...
            sprintf('Player #%d owns the serve',first_serve);...
            [' \color{yellow}' sprintf('Score#1: %d/10   Score#2: %d/10 ',score1,score2)]};
        print_title(axisTitle, titlestring)

    if score1 == 10 % Player #1 wins
        titlestring = {'\color{red}GAME OVER!\color{green}';...
            'Winner: Player #1';...
            [' \color{white}' sprintf('Score#1: %d/10   Score#2: %d/10 ',score1,score2)]};
        print_title(axisTitle, titlestring)
        quitGame = true;
    elseif score2 == 10 % Player #2 wins
        titlestring = {'\color{red}GAME OVER!\color{green}';...
            'Winner: Player #2';...
            [' \color{white}' sprintf('Score#1: %d/10   Score#2: %d/10 ',score1,score2)]};
        print_title(axisTitle, titlestring)
        quitGame = true;
    else
    end

end
fclose(P1_file_id);
fclose(P2_file_id);
fclose(ballPos_id);

frewind(P2_entry_id)
fprintf(P2_entry_id,'%d\n', 0); % Player 2 left
fclose(P2_entry_id);
end
% set serve zero for player 2
    f_name = 'P2served.txt';
    f_id = fopen(f_name,'w');
    fprintf(f_id,'%d\n', 0);
    frewind(f_id);
    fclose(f_id);
fclose all;
end


function [] = player1()
%player1 is the function for the Player #1 in the Pong game
%Input arguments:
%   there are no inputs to this function
%Output arguments:
%   there are no outputs from this function
%Notes:
%   A two-player networked game in which a ball is batted back and forth
%   between 2 paddles.
%   player1 function is responsible for the movement of the left paddle.
%   This is complete code upto step four.

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
    '\color{yellow}Waiting for Player #2 to join'};
print_title(axisTitle, titlestring)

% initialize the paddle positions
fclose all;
XY1 = [12.5 400]; XY2 = [1187.5 400];
save('player1_info.txt','XY1','-ascii');
save('player2_info.txt','XY2','-ascii');

% mark that player 1 has entered the game
f_name = 'P1_entry.txt';
P1_entry_id = fopen(f_name,'w');
fprintf(P1_entry_id,'%d\n', 1); % Player 1 joined
frewind(P1_entry_id)

P2_entry = 0;
% check if player 2 joined or not
while P2_entry~=1
    pause(0.025)
f_name = 'P2_entry.txt';
P2_entry_id = fopen(f_name,'r');
P2_entry = fscanf(P2_entry_id,'%d'); % Player 2 joined
frewind(P2_entry_id)
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

if P2_entry == 1
% open a file for player 1 (writng)
P1_file_name = 'player1_info.txt';
P1_file_id = fopen(P1_file_name,'w');
fprintf(P1_file_id,'%f %f\n', [12.5 400]');
frewind(P1_file_id)
% open the player 2 file for reading
P2_file_name = 'player2_info.txt';
P2_file_id = fopen(P2_file_name,'r');

% ball position communication file
ballPos_file_name = 'ball_position.txt';
ballPos_id = fopen(ballPos_file_name,'w');

% determine first serve randomly
first_serve = randi([1 2]);
    % tell this to player 2
    f_name = 'serve_info.txt';
    f_id = fopen(f_name,'w');
    fprintf(f_id,'%d\n', first_serve);
    frewind(f_id);
    fclose(f_id);

titlestring = {'Type "q" to Quit\color{white}';...
    sprintf('Player #%d owns the serve',first_serve);...
    ''};
print_title(axisTitle, titlestring)
% initial ball
if first_serve == 1
    ball_center_Pos = [HERO_W/2 400]+[(ball_R+HERO_W/2) 0];
else
    ball_center_Pos = [1200-HERO_W/2 400]-[(ball_R+HERO_W/2) 0];
end
ball_Pos = ball_center_Pos+[ball_R ball_R];
[ball_Pos] = draw_object(mainAxis, ball_Shape, ballPatch, 2*ball_R, 2*ball_R, ball_Pos);

% set zero starting score for both players
score1 = 0; score2 = 0; served = 0;
    % set the scoreboard file
    score_file_name = 'ScoreBoard.txt';
    score_file_id = fopen(score_file_name,'w');
    fprintf(score_file_id,'%d %d\n', [score1 score2]');
    frewind(score_file_id);
% initialize velocity    
velX = randi([5 10]); velY = randi([5 10]);

while ~quitGame
    pause(0.02);
    % read the paddle 2 position from the file
    paddle_2_Pos = fscanf(P2_file_id,'%f %f');
    frewind(P2_file_id)
    paddle_2_Pos = paddle_2_Pos'; % reorient as original

    [mousePos] = get_mouse_position(mainAxis);
    objectOutline = HERO;
    object_width = HERO_W;
    object_height = HERO_H;
    objectPatch = heroPlot; objectPatch2 = heroPlot2;

    % lock on the left side and vertical movement limits
    paddle_1_Pos = [HERO_W/2 mousePos(2)]; % lock at left side
    if paddle_1_Pos(2) > 800-HERO_H/2
        paddle_1_Pos(2) = 800-HERO_H/2;
    elseif paddle_1_Pos(2) < HERO_H/2
        paddle_1_Pos(2) = HERO_H/2;
    end

    [paddle_1_Pos] = draw_object(mainAxis, objectOutline, objectPatch, object_width, object_height, paddle_1_Pos);
    [paddle_2_Pos] = draw_object(mainAxis, objectOutline, objectPatch2, object_width, object_height, paddle_2_Pos);

    % write the paddle 1 position to the file
    fprintf(P1_file_id,'%f %f\n', paddle_1_Pos');
    frewind(P1_file_id)
    
%     ball_Pos = ball_center_Pos+[ball_R ball_R];
%     [ball_Pos] = draw_object(mainAxis, ball_Shape, ballPatch, 2*ball_R, 2*ball_R, ball_Pos);

    % tell ball position to player 2
    fprintf(ballPos_id,'%f %f\n', ball_Pos');
    frewind(ballPos_id);

    % ball edges
    ball_X = ball_center_Pos(1);
    ball_Y = ball_center_Pos(2);
    left_side = ball_X-ball_R;
    right_side = ball_X+ball_R;
    bottom_side = ball_Y-ball_R;
    top_side = ball_Y+ball_R;
    
    if clickedUp == true && first_serve == 1
        served = 1; clickedUp = false;
    elseif first_serve == 2
        % read from player 2 if he served or not
        f_name = 'P2served.txt';
        f_id = fopen(f_name,'r');
        served = fscanf(f_id,'%d');
        frewind(f_id);
        fclose(f_id);
    end
    
    titlestring = {'Type "q" to Quit\color{white}';...
            sprintf('Player #%d owns the serve',first_serve);...
            [' \color{yellow}' sprintf('Score#1: %d/10   Score#2: %d/10 ',score1,score2)]};
        print_title(axisTitle, titlestring)

    if served
        % detect wall collisions
        if bottom_side<=0 % bottom wall
            velY = -velY;
            ball_center_Pos(2) = ball_center_Pos(2) + velY;
        end
        if top_side>=800 % top wall
            velY = -velY;
            ball_center_Pos(2) = ball_center_Pos(2) + velY;
        end
        if left_side<=0 % left wall
            clickedUp = false; 
            if first_serve == 1
                first_serve = 2; score2 = score2-1;
            else
                score2 = score2+1; served = 0;
            end
        elseif right_side>=1200 % right wall
            clickedUp = false;
            if first_serve == 2
                first_serve = 1; score1 = score1-1;
            else
                score1 = score1+1; served = 0;
            end
        end
        % tell the serve change to player 2
        f_name = 'serve_info.txt';
        f_id = fopen(f_name,'w');
        fprintf(f_id,'%d\n', first_serve);
        frewind(f_id);
        fclose(f_id);
        
        % tell to reserve 
        f_name = 'P2served.txt';
        f_id = fopen(f_name,'w');
        fprintf(f_id,'%d\n', served);
        frewind(f_id);
        fclose(f_id);
        
        titlestring = {'Type "q" to Quit\color{white}';...
            sprintf('Player #%d owns the serve',first_serve);...
            [' \color{yellow}' sprintf('Score#1: %d/10   Score#2: %d/10 ',score1,score2)]};
        print_title(axisTitle, titlestring)
        % paddle edges
        P1_edge = paddle_1_Pos(1)+HERO_W/2;
        P1_top = paddle_1_Pos(2)+HERO_H/2;
        P1_bottom = paddle_1_Pos(2)-HERO_H/2;
        P2_edge = paddle_2_Pos(1)-HERO_W/2;
        P2_top = paddle_2_Pos(2)+HERO_H/2;
        P2_bottom = paddle_2_Pos(2)-HERO_H/2;
        
        % detect paddle collisions
        if (left_side<P1_edge)&&(left_side>paddle_1_Pos(1))&&(ball_Y>=P1_bottom)&&(ball_Y<=P1_top) % left paddle
            velX = randi([5 15]); velY = randi([5 10]);
        end
        if (right_side>P2_edge)&&(right_side<paddle_2_Pos(1))&&(ball_Y>=P2_bottom)&&(ball_Y<=P2_top) % right paddle
            velX = -randi([5 15]); velY = randi([5 10]);
        end
        ball_center_Pos = ball_center_Pos +[velX velY];
    else
        if first_serve == 1
            ball_center_Pos = paddle_1_Pos+[(ball_R+HERO_W/2) 0];
        else
            ball_center_Pos = paddle_2_Pos-[(ball_R+HERO_W/2) 0];
        end
    end
    ball_Pos = ball_center_Pos+[ball_R ball_R];
    [ball_Pos] = draw_object(mainAxis, ball_Shape, ballPatch, 2*ball_R, 2*ball_R, ball_Pos);
    
    % update scoreboard
    fprintf(score_file_id,'%d %d\n', [score1 score2]');
    frewind(score_file_id);
    
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

frewind(P1_entry_id)
fprintf(P1_entry_id,'%d\n', 0); % Player 1 left
fclose(P1_entry_id);
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
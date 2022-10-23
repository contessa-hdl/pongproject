clear
clc
clf
format short g
format compact

%Pong
% READ ME:
% USE W & S KEYS TO MOVE UP AND DOWN AND 'UP ARROW AND DOWN ARROW' KEYS FOR MULTIPLAYER MODE


message=["Welcome To Pong!","Select Your Gamemode:"]; % welcomes player
gameoptions=["Single Player" "Multiplayer" "Beach Mode" "Timed Survival Mode"]; % options for gamemodes
choice=menu(message,gameoptions); % creates choice


BallVel = [1,1]; % sets x,y velocity of pong ball
BallPos = [20,50]; % sets x,y position of ball

global blockCenter; % sets variable blockCenter global
blockCenter = 45; % sets center of block
global blockCenter1; % sets variable blockCenter global
blockCenter1 = 45; % sets center of block


if(choice==1 || choice==2|| choice==4)
pongFig = figure('color', [.29 .73 .09], 'KeyPressFcn', @keyboardFunction); % Sets up figure
pongAxes = axes('color', 'w', 'Xlim',[0 100], 'Ylim',[0 100], 'XTickLabels', [], ...
    'YTickLabels',[]); % sets axes
ballSize = 40; % sets size of ball
paddleSize = 15; % sets paddle size
pongBall = line(BallPos(1),BallPos(2),'marker','.','markersize', ballSize, 'color', [0 0 0]); % creates ball
pongBlock = line([5 5], [blockCenter-paddleSize blockCenter+paddleSize], 'linewidth', 4, 'color', [0 0 0]); % creates block
pongBlock1 = line([95 95], [blockCenter1-paddleSize blockCenter1+paddleSize], 'linewidth', 4, 'color', [0 0 0]); %second block 
end



if(choice == 3) % if beach ball mode is selected
    pongFig = figure('color', [.285 .691 .855], 'KeyPressFcn', @keyboardFunction); % Sets up figure
    pongAxes = axes('color', [.744 .660 .516], 'Xlim',[0 100], 'Ylim',[0 100], 'XTickLabels', [], ...
    'YTickLabels',[]); % sets axes
    ballSize = 120; % resizes ball 
    paddleSize = 7; % paddle size decreased for beachball mode
    pongBall = line(BallPos(1),BallPos(2),'marker','.','markersize', ballSize, 'color', [1 0 0]); % creates ball
    
pongBlock = line([5 5], [blockCenter-paddleSize blockCenter+paddleSize], 'linewidth', 4, 'color', [1 1 1]); % creates block
pongBlock1 = line([95 95], [blockCenter1-paddleSize blockCenter1+paddleSize], 'linewidth', 4, 'color', [1 1 1]); %second block 
end




a = 0; % score for player 1
b = 0; % score for player 2
text(45,90, {'Score: '}); % creates text for score
text(50,85, {':'}); % creates : for score



tic;
while toc < 500 % timer
    
      
   
    
    if BallPos(1) > 93 % if the ball gets past 93 to the right
        if abs(BallPos(2) - blockCenter1) <paddleSize % if the ball is being hit by the paddle
            BallVel(1) = - BallVel(1); % ball bounces
        else
            a = a +1; % score increases
            BallPos = [50,50]; % resets ball position
            BallVel(1) = - BallVel(1); %bounces ball
        end
    end
    
    
    
    if BallPos(1) < 7 % if the ball is past 7 on the left
        if abs(BallPos(2) - blockCenter) <paddleSize % if the ball is being hit by paddle
            BallVel(1) = - BallVel(1); % ball bounces
    else
        b = b +1; % other score increases
        BallPos = [50,50]; % resets ball position
        BallVel(1) = - BallVel(1); % bounces ball
      end
        
    end
    
    
    
    
    if BallPos(2) < 0 || BallPos(2) >100 % if the ball hits either the top or bottom
        BallVel(2) = - BallVel(2); % bounce ball
    end
    
    
    
    BallPos = BallPos + BallVel; % creates motion
    set(pongBall, 'XData',BallPos(1), 'YData',BallPos(2)) %sets ball in motion
    set(pongBlock, 'YData', [blockCenter-paddleSize, blockCenter+paddleSize]) % sets blocks into motion
    set(pongBlock1, 'YData', [blockCenter1-paddleSize, blockCenter1+paddleSize])
    
     
    
    
    
    if(blockCenter > 110 || blockCenter<-10) % if paddle goes either too high or too low sets to middle
        blockCenter = 45;
    end
      if(blockCenter1 > 110 || blockCenter1<-10)
        blockCenter1 = 45;
    end
    
     if(choice == 1) % if going against the computer
          if(BallPos(2)>= blockCenter1)
              blockCenter1 = blockCenter1 + 30; % finds position and follows it
          end
             if(BallPos(2)<blockCenter1)
              blockCenter1 = blockCenter1 - 30;
          end
     end
      
     
     if(choice == 4) % if going against the computer & endless
          if(BallPos(2)>= blockCenter1)
              blockCenter1 = blockCenter1 + 1; % finds position and follows it
          end
             if(BallPos(2)<blockCenter1)
              blockCenter1 = blockCenter1 - 1;
          end
     end
      
     
     if choice == 4
        cText = text(10,85, {num2str(round(toc))}); % adds timer
        if (b>0) % if computer wins
             
       text(45,60,{'You Lose'}); % displays you lose
       BallVel(1) = 0; % stops velocity
       BallVel(2) = 0; % stops velocity
       stop; %ends game
       
      end
        
    end
      
     
     
     aText = text(45,85, {num2str(a)}); % sets text for scores
     bText = text(55,85, {num2str(b)});
    pause(0.02); % sets pause
    delete(aText); % deletes text 
     delete(bText);
    if(choice == 4) 
        delete(cText); % deletes the text to reset
    end
   
end

function keyboardFunction(~,event) % allows for keyboard usage
global blockCenter; % sets variable blockCenter global
global blockCenter1;
switch event.Key

    case 'uparrow'
blockCenter1 = blockCenter1 +10;
     
    case 'downarrow'
blockCenter1 = blockCenter1 -10;  

    case 'w'
blockCenter = blockCenter +10;
     
    case 's'
blockCenter = blockCenter -10;  

end
end


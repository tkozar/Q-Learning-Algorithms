%% Creating random arrays filled with 1,4
%% 1 = good space
%% 2 = wall
%% 3 = negative reward
%% 4 = random event occurence (could be +/- reward)
%% Change Size Var For Sizing Grid
size = 20;
x = randi(4,size,1);
y = randi(4,size,1);

%% Size Values, Updates End Point Also
endpoint = 20;

[X, Y] = meshgrid(x,y);
pcolor(X);
colormap(white(2));

%% Patch Start Point
patch([1,2,2,1],[1,1,2,2],'r')
text(1.3,1.55,'S')

%% Patch End Point
patch([endpoint,endpoint - 1,endpoint - 1,endpoint],[endpoint - 1,endpoint - 1,endpoint,endpoint],'g')
text(endpoint - 0.7, endpoint - 0.45, 'F');

%% Variables For Storing Moving Dot
%% X Coordinates
x1 = 1.25;
x2 = 1.75;
x3 = 1.75;
x4 = 1.25;
%% Y Coordinates
y1 = 1.25;
y2 = 1.25;
y3 = 1.75;
y4 = 1.75;

%% Dot To Move
transferblock = patch([x1,x2,x3,x4],[y1,y2,y3,y4], 'b');

%%%%%%%%% Update Function %%%%%%%%%
% Pause To Show Moves
pause(0.5);

%%%%%  Updated Somewhere For Switch -> ** moveTaken = right **

%%%% Switch Case For Move %%%%
switch moveTaken
    
%% For Right Move
    case right
        delete(transferblock());
        transferblock = patch([x1 + 1,x2 + 1,x3 + 1,x4 + 1],[y1,y2,y3,y4], 'b');
        %% Update X Values
        x1 = x1 + 1;
        x2 = x2 + 1;
        x3 = x3 + 1;
        x4 = x4 + 1;

%% For Left Move
    case left
        delete(transferblock());
        transferblock = patch([x1 - 1,x2 - 1,x3 - 1,x4 - 1],[y1,y2,y3,y4], 'b');
        %% Update X Values
        x1 = x1 - 1;
        x2 = x2 - 1;
        x3 = x3 - 1;
        x4 = x4 - 1;

%% For Up Move
    case up
        delete(transferblock());
        transferblock = patch([x1,x2,x3,x4],[y1 + 1,y2 + 1,y3 + 1,y4 + 1], 'b');
        %% Update Y Values
        y1 = y1 + 1;
        y2 = y2 + 1;
        y3 = y3 + 1;
        y4 = y4 + 1;   

%% For Down Move
    case down
        delete(transferblock());
        transferblock = patch([x1,x2,x3,x4],[y1 - 1,y2 - 1,y3 - 1,y4 - 1], 'b');
        %% Update Y Values
        y1 = y1 - 1;
        y2 = y2 - 1;
        y3 = y3 - 1;
        y4 = y4 - 1;  

%% For Diagonal Left Up
    case leftup
        delete(transferblock());
        transferblock = patch([x1 - 1,x2 - 1,x3 - 1,x4 - 1],[y1 + 1,y2 + 1,y3 + 1,y4 + 1], 'b');
        %% Update X Values
        x1 = x1 - 1;
        x2 = x2 - 1;
        x3 = x3 - 1;
        x4 = x4 - 1;
        %% Update Y Values
        y1 = y1 + 1;
        y2 = y2 + 1;
        y3 = y3 + 1;
        y4 = y4 + 1;
    
%% For Diagonal Right Up
    case rightup
        delete(transferblock());
        transferblock = patch([x1 + 1,x2 + 1,x3 + 1,x4 + 1],[y1 + 1,y2 + 1,y3 + 1,y4 + 1], 'b');
        %% Update X Values
        x1 = x1 + 1;
        x2 = x2 + 1;
        x3 = x3 + 1;
        x4 = x4 + 1;
        %% Update Y Values
        y1 = y1 + 1;
        y2 = y2 + 1;
        y3 = y3 + 1;
        y4 = y4 + 1;
        
%% For Diagonal Left Down
    case leftdown
        delete(transferblock());
        transferblock = patch([x1 - 1,x2 - 1,x3 - 1,x4 - 1],[y1 - 1,y2 - 1,y3 - 1,y4 - 1], 'b');
        %% Update X Values
        x1 = x1 - 1;
        x2 = x2 - 1;
        x3 = x3 - 1;
        x4 = x4 - 1;
        %% Update Y Values
        y1 = y1 - 1;
        y2 = y2 - 1;
        y3 = y3 - 1;
        y4 = y4 - 1;
    
%% For Diagonal Right Down
    case rightdown
        delete(transferblock());
        transferblock = patch([x1 + 1,x2 + 1,x3 + 1,x4 + 1],[y1 - 1,y2 - 1,y3 - 1,y4 - 1], 'b');
        %% Update X Values
        x1 = x1 + 1;
        x2 = x2 + 1;
        x3 = x3 + 1;
        x4 = x4 + 1;
        %% Update Y Values
        y1 = y1 - 1;
        y2 = y2 - 1;
        y3 = y3 - 1;
        y4 = y4 - 1;
        
        
    
end
        
    





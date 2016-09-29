function map = Gridworld()
%% Creating random arrays filled with 1,4
%% 1 = good space
%% 2 = wall
%% 3 = negative reward
%% 4 = random event occurence (could be +/- reward)

%% Change Size Var For Sizing Grid (Size Always 1 Less Than Number Assigned
size = 20;
x = randi(4,size,1);
y = randi(4,size,1);

%% Creating & Displaying Grid
[X, Y] = meshgrid(x,y);
pcolor(X);
colormap(white(2));

%% Patch Start Point
patch([1,2,2,1],[1,1,2,2],'r')
text(1.3,1.55,'S')

%% Patch End Point
patch([size,size - 1,size - 1,size],[size - 1,size - 1,size,size],'g')
text(size - 0.6, size - 0.45, 'F');

%% Patch Walls
numWalls = 100;
wallx = randi(size - 1,numWalls,2);
wally = randi(size - 1,numWalls,2);
for i = 2:numWalls
    if (wallx(i) == 1 && wally(i) == 1)
       wallx(i) = 2;
    end
    if (wallx(i) == size-1 && wally(i) == size-1)
       wallx(i) = size-2;
    end
    
    patch([wallx(i),wallx(i)+1,wallx(i)+1,wallx(i)], [wally(i),wally(i),wally(i)+1,wally(i)+1],'black')
end
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


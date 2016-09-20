%% Creating random arrays filled with 1,4
%% 1 = good space
%% 2 = wall
%% 3 = negative reward
%% 4 = random event occurence (could be +/- reward)
x = randi(4,20,1);
y = randi(4,20,1);

%% Size Values, Updates End Point Also
endpoint = 20;

[X, Y] = meshgrid(x,y);
pcolor(X);
colormap(white(2));

patch([0,2,2,0],[0,0,2,2],'b')
text(1.3,1.55,'S')

patch([endpoint,endpoint - 1,endpoint - 1,endpoint],[endpoint - 1,endpoint - 1,endpoint,endpoint],'g')
text(endpoint - 0.7, endpoint - 0.45, 'F'); 





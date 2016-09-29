function updateMap(agent)
% Pause To Show Moves
    pause(0.5);
    
    %%%%%  Updated Somewhere For Switch -> ** moveTaken = right etc. **
    moveTaken = qlearning(x1,x2,x3,x4,y1,y2,y3,y4);

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
end
%% Initializing Grid Size
numRows = 20;
numColumns = 20;

%% Max Number of Moves Else Considered A Fail
maxNumMoves = 400;

%% Reward Set To Number 'Peak'
rewardVar = numRows*numColumns;

%% Q-Learning On/Off (1 if on, will change to 0 if not)
isOn = 1;

%% Number Of Possible States
numStates = numRows*numColumns;

%% Setting Grid Matrix Of Possible States
mStates = reshape(1:numStates, numRows, numColumns);

%% Linked (0 if no, 1 if yes)
linked = zeroes(numStates);

% absorption state - has a reward of 400
absorptionState = numRows*numColumns;

%% Link States
for i = 1:numStates
       [rowsi, columnsi] = stateToRowColumn(i, numStateRows, numStateColumns);
       for j = 1:numStates
           [rowsj, columnsj] = stateToRowColumn(j, numStateRows, numStateColumns);
           
           %% checking above and below itself, left and right and diagonally
           if (columnsj-columnsi < 2)&&(columnsj-columnsi > -2)&&(rowsj-rowsi < 2)&&(rowsj-rowsi > -2)
               linked(i, j) = 0;
           end
           
           %% removing the space its currently in
           if (columnsi == columnsj) && (rowsi == rowsj)
               linked(i, j) = 0;
           end         
       end
end;



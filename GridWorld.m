% GridWorld class
% randomly constructs a grid world task and provides methods for
% interacting with it.

classdef GridWorld < handle
    
    properties
        % this property is a matrix that stores the 'type' of each square
        % in the gridworld: 1 = good space, 2 = wall, 3 = negative reward,
        % 4 = random event occurence (could be +/- reward), 5 = goal state
        squareTypes;
                
    end
    
    methods
        
        %% constructor
        function obj = GridWorld(worldSize, wallFraction)
            obj.squareTypes = ones(worldSize);
            allSquares = 1:numel(obj.squareTypes);
            
            % add goal state
            goalSquareIndex = allSquares(end);
            allSquares(end) = [];
            obj.squareTypes(goalSquareIndex) = 5;
            
            % add walls
            numWalls = round(wallFraction * numel(obj.squareTypes));
            randomIndices = randsample(length(allSquares), numWalls);
            wallSquareIndices = allSquares(randomIndices);
            allSquares(randomIndices) = [];
            %[wallSquaresX, wallSquaresY] = wallSquareIndices([size,size], wallSquareIndices);
            obj.squareTypes(wallSquareIndices) = 2;
            
            % clear a random path to the goal state (to guarantee at least
            % one solution
            reservedSquares = 1;
            current = [1,1];
            while reservedSquares(end) ~= numel(obj.squareTypes)
                if rand() < 0.5
                    current(1) = current(1) + 1;
                else
                    current(2) = current(2) + 1;
                end
                current = min(worldSize,current);
                current = max(1,current);
                reservedSquares = [reservedSquares; sub2ind(size(obj.squareTypes), current(1), current(2))];
            end
            obj.squareTypes(reservedSquares(1:end-1)) = 1;
            
            %% Initializing Storage State Vectors
            newState = ones(2,1);
            oldState = ones(2,1);
        end
        
        %% view the grid world as a figure
        function view(obj, size)
            % create a bitmap version of the world
            bmp = 255*ones(length(obj.squareTypes), length(obj.squareTypes),3);
            
            for i=1:length(obj.squareTypes)
                for j = 1:length(obj.squareTypes)
                    switch obj.squareTypes(i,j)
                        case 2 % walls
                            bmp(i,j,:) = 0;
                        case 5 % goal
                            bmp(i,j,[1,3]) = 0;
                    end
                end
            end
            
            % mark the start state in red
            bmp(1,1,2:3) = 0;
            
            % enlarge to requested size
            bmp = imresize(uint8(bmp), [size,size], 'nearest');
            % add gridlines
            centers = round(linspace(1,size,length(obj.squareTypes)+1));
            bmp(centers,:,:) = 0;
            bmp(:,centers,:) = 0;
            % display
            imshow(bmp);
        end
        
        %% step
        % this method allows the agent to request the results of its
        % actions in the world.
        function [newState,reward] = step(oldState, action)
           switch action
               %% IF MOVNG RIGHT
               case 0
                   %% checking the value in next state
                   if (oldState(1,1) + 1 < worldSize + 1)
                       oldState = ans.squareTypes(oldState(1,1) + 1,oldState(2,1));
                   else 
                       oldStateVal = 2;
                   end
                   
                   %% if open, move
                   if (oldStateVal == 1)
                       reward = 0;
                       newState(1,1) = oldState(1,1) + 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if wall, dont move
                   if (oldStateVal == 2)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if negative reward, move and reward negative
                   if (oldStateVal == 3)
                       reward = -1;
                       newState(1,1) = oldState(1,1) + 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if random +/-, move and decide reward
                   if (oldStateVal == 4)
                       reward = randi([-1 1],1,1);
                       newState(1,1) = oldState(1,1) + 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if goal state, move and give large reward
                   if (oldStateVal == 5)
                       reward = 10;
                       newState(1,1) = oldState(1,1) + 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% update current address
                   oldState(1,1) = newState(1,1);
                   oldState(2,1) = newState(2,1);
               
               %% IF MOVING LEFT   
               case 1
                   %% checking the value in next state
                   if (oldState(1,1) - 1 > 0)
                       oldState = ans.squareTypes(oldState(1,1) - 1,oldState(2,1));
                   else 
                       oldStateVal = 2;
                   end
                       
                   %% if open, move
                   if (oldStateVal == 1)
                       reward = 0;
                       newState(1,1) = oldState(1,1) - 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if wall, dont move
                   if (oldStateVal == 2)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if negative reward, move and reward negative
                   if (oldStateVal == 3)
                       reward = -1;
                       newState(1,1) = oldState(1,1) - 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if random +/-, move and decide reward
                   if (oldState == 4)
                       reward = randi([-1 1],1,1);
                       newState(1,1) = oldState(1,1) - 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if goal state, move and give large reward
                   if (oldState == 5)
                       reward = 10;
                       newState(1,1) = oldState(1,1) - 1;
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% update current address
                   oldState(1,1) = newState(1,1);
                   oldState(2,1) = newState(2,1);
               
               %% IF MOVING UP
               case 2
                   %% checking the value in next state
                   if (oldState(2,1) - 1 > 0)
                       oldState = ans.squareTypes(oldState(1,1),oldState(2,1) - 1);
                   else 
                       oldStateVal = 2;
                   end
                       
                   %% if open, move
                   if (oldStateVal == 1)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) - 1;
                   end
                   
                   %% if wall, dont move
                   if (oldStateVal == 2)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if negative reward, move and reward negative
                   if (oldStateVal == 3)
                       reward = -1;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) - 1;
                   end
                   
                   %% if random +/-, move and decide reward
                   if (oldStateVal == 4)
                       reward = randi([-1 1],1,1);
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) - 1;
                   end
                   
                   %% if goal state, move and give large reward
                   if (oldStateVal == 5)
                       reward = 10;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) - 1;
                   end
                   
                   %% update current address
                   oldState(1,1) = newState(1,1);
                   oldState(1,1) = newState(2,1);
               
               %% IF MOVING DOWN
               case 3
                   %% checking the value in next state
                   if (oldState(2,1) + 1 < worldSize + 1)
                       oldState = ans.squareTypes(oldState(1,1),oldState(2,1) + 1);
                   else 
                       oldStateVal = 2;
                   end
                       
                   %% if open, move
                   if (oldStateVal == 1)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) + 1;
                   end
                   
                   %% if wall, dont move
                   if (oldStateVal == 2)
                       reward = 0;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1);
                   end
                   
                   %% if negative reward, move and reward negative
                   if (oldStateVal == 3)
                       reward = -1;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) + 1;
                   end
                   
                   %% if random +/-, move and decide reward
                   if (oldStateVal == 4)
                       reward = randi([-1 1],1,1);
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) + 1;
                   end
                   
                   %% if goal state, move and give large reward
                   if (oldStateVal == 5)
                       reward = 10;
                       newState(1,1) = oldState(1,1);
                       newState(2,1) = oldState(2,1) + 1;
                   end
                   
                   %% update current address
                   oldState(1,1) = newState(1,1);
                   oldState(2,1) = newState(2,1);
           end
        end
       
        %% getSensorReadings
        % this method returns the agent's current sensor readings, given
        % the specified state in the grid world
        function [sensorReadings] = getSensorReadings(state, failureRate)
            % code here
        end
        
    end
end
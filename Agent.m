% Agent class

classdef Agent < handle
    
    properties
        % the gridworld task being solved
        world;
        
        % q learner
        qLearner;
        epsilon = 0.9;
        
        % egocentric learners
        net;
        Xmemory; Ymemory;
        memorySize;
        trainInterval = 2500;
        allStates;
        allPredictions;
        networkTrained = false;
        
        % other parameters
        currentState = [1 1];
        defaultQ = 10;
        steps = 0;
        rHistory = [];
        sensFailRate = 0;
        
        predErrors = 0;
       
    end
    
    methods
        % constructor
        function obj = Agent(gridWorld, networkSize, MemorySize, SensFailRate)
            
            obj.world = gridWorld;
            obj.qLearner = ModelFreeRL(numel(gridWorld.squareTypes), 4);
            
            obj.net = feedforwardnet(round(networkSize));
            obj.net.trainParam.showWindow = false;
            obj.net.trainParam.showCommandLine = false;
            obj.net.trainParam.time = 20;
            
            obj.memorySize = round(MemorySize);
            obj.sensFailRate = SensFailRate;
            
            % setup the predefined list of all states (for efficiency)
            obj.allStates = zeros(3^8*4,16);
            for i = 1:size(obj.allStates,1)
                X = cell(1,9);
                [X{:}] = ind2sub([3 3 3 3 3 3 3 3 4], i);
                X = cell2mat(X);
                obj.allStates(i,:) = obj.ego2trainVec(X(1:8), X(end));
            end
        end
          
        function switchTasks(obj, newGridWorld)
            obj.rHistory = [];
            obj.train();
            obj.world = newGridWorld;
            obj.qLearner = ModelFreeRL(numel(newGridWorld.squareTypes), 4);
            obj.currentState = [1 1];
        end
        
        function step(obj, display, allowTransfer)
            currentStateInd = sub2ind(size(obj.world.squareTypes),obj.currentState(1), obj.currentState(2));
            
            % get current sensor readings
            sens = obj.world.getSensorReadings(obj.currentState, obj.sensFailRate);
            
            % make predictions
            if obj.networkTrained && allowTransfer
                for a = 1:4                    
                    %thisEgo = obj.ego2trainVec(sens,a);
                    %pred = obj.net(thisEgo')'; 
                    stateActionCell = num2cell([sens, a]);
                    stateActionInd = sub2ind([3 3 3 3 3 3 3 3 4], stateActionCell{:});
                    pred = obj.allPredictions(stateActionInd,:);
                    
%                     pred = perfectPredictions([sens a]);
                    
                    try
                    predState = round(obj.currentState + pred(1:2));
                    
                    truePred = perfectPredictions([sens, a]);
                    if ~isequal(round(pred(1:2)), truePred(1:2))
                       obj.predErrors = obj.predErrors+1;
                    end
                    
                    predState = max([1 1], min(predState, size(obj.world.squareTypes)));
                    predStateInd = sub2ind(size(obj.world.squareTypes), predState(1), predState(2));
                    
                    obj.qLearner.update(currentStateInd, a, predStateInd, pred(3));
                    %disp('prediction transferred');
                    catch
                        error('error');
                    end
                end
            end
            
            % choose action
            if rand() < obj.epsilon
                values = obj.qLearner.value(currentStateInd, 1:4);
                values(isnan(values)) = obj.defaultQ;
                [~,act] = max(values);
            else
                act = randi(4);
            end
                        
            % execute action
            [newState, r] = obj.world.step(obj.currentState, act);
            obj.rHistory(end+1) = r;
            newStateInd = sub2ind(size(obj.world.squareTypes), newState(1), newState(2));
            
            % update q learner
            obj.qLearner.update(currentStateInd, act, newStateInd, r);
            
            % load experience into memory neural network
            dx = newState(1) - obj.currentState(1);
            dy = newState(2) - obj.currentState(2);
            obj.Ymemory = [obj.Ymemory; [dx, dy, r]];
            obj.Xmemory = [obj.Xmemory; obj.ego2trainVec(sens,act)];
            while size(obj.Xmemory,1)>obj.memorySize
                obj.Ymemory(1,:) = [];
                obj.Xmemory(1,:) = [];
            end
            
            % train egocentric model
            if mod(obj.steps, obj.trainInterval)==0 && obj.steps > 0
                obj.train;
            end
            
            % set new current state
            obj.currentState = newState;
            
            if display==true
                obj.world.view(300,newState);
            end
            
            obj.steps = obj.steps + 1;
        end
        
        function output = ego2trainVec(obj, sens, action)
            output = zeros(1,16);
            output(0+sens(2)) = 1;
            output(3+sens(4)) = 1;
            output(6+sens(6)) = 1;
            output(9+sens(8)) = 1;
            output(12+action) = 1;
        end
            
        
        function train(obj)
            % train network
            obj.net = train(obj.net, obj.Xmemory', obj.Ymemory');
            obj.allPredictions = obj.net(obj.allStates')';
            obj.networkTrained = true;
        end
            
    end
end
            
            
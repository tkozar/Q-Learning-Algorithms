classdef ModelFreeRL < handle
    
    properties
        Qtable;
        Ttable;
        
        alpha = 0.2;
        gamma = 0.9;
        
        defaultQ = 10;
    end
    
    methods
        function obj = ModelFreeRL(numStates, numActions)
            obj.Qtable = NaN * ones(numStates,numActions);
            obj.Ttable = cell(numActions,1);
            for a=1:numActions
                obj.Ttable(a) = {sparse(zeros(numStates,numStates))};
            end
        end
        
        function qval = value(obj, stateNum, actionNums)
            qval = obj.Qtable(stateNum, actionNums);
        end
        
        function t = getT(obj, stateNum, actionNum)
            t = obj.Ttable{actionNum};
            t = sum(t(stateNum, :));
        end
        
        function update(obj, oldStateNum, actionNum, newStateNum, reward)
            t = obj.Ttable{actionNum};
            t(oldStateNum, newStateNum) = t(oldStateNum, newStateNum) + 1;
            obj.Ttable(actionNum) = {t};
            
            currentQ = obj.Qtable(oldStateNum, actionNum);
            currentQ(isnan(currentQ)) = obj.defaultQ;
            
            maxNewQ = obj.Qtable(newStateNum, :);
            maxNewQ(isnan(maxNewQ)) = obj.defaultQ;
            maxNewQ = max(maxNewQ);
            
            
            obj.Qtable(oldStateNum, actionNum) = currentQ + obj.alpha * (reward + obj.gamma * maxNewQ - currentQ);
        end
        
    end
    
end
function [f] = fitnessFunction(parameters)

% instantiate the training and test gridworld tasks
g1 = GridWorld(10,0.3);
g2 = GridWorld(10,0.3);

% run the agents with the various parameters and measure the three objective values for each
numAgents = size(parameters,1);
f = zeros(numAgents, 3);
disp(['evaluating ' num2str(numAgents) ' agents in a random grid world...']);
tic
parfor agentNum=1:numAgents
    
    % instantiate the agent - disable the egocentric learning system
    pCell = num2cell(parameters(agentNum,:));
    agent = Agent(g1,pCell{:});
    agent.trainInterval = inf;
    agent.epsilon = 0;
    
    % run this agent on the training task (10k steps)
    for i = 1:10000
        agent.step(false, false);
    end
    
    % switch to test task - allow egocentric system to transfer knowledge
    agent.switchTasks(g2);
    agent.epsilon = 0.9;
    agent.trainInterval = 2500;
    for i=1:10000
        agent.step(false, true);
    end
    
    thisFitness = zeros(1,3);
    
    % measure cumulative reward
    thisFitness(1) = -1*sum(agent.rHistory);
    
    % measure model complexity
    thisFitness(2) = agent.net.numWeightElements * agent.memorySize;
    
    % measure sensor quality
    thisFitness(3) = -1*agent.sensFailRate;
    
    f(agentNum,:) = thisFitness;
end
toc;
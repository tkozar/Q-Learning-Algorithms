function qtestBasic
 
% set the number of states
numStateRows = 10;
numStateCols = 10;
% set gamma between 0 and 1
gamma = 0.9;
% learning rate between 0 and 1
lR = 0.7;
% when move state to state pick best option 1-epsilon of time and random other times
% if epsilon = 1 always picks random next state - is e-greedy
% if epsilon = 0 always pick best option - never explore new areas (random
% if best option is a Q value of zero)
epsilon = 0.4;
% stop running Q updates of this numTrials
% numTrials = 1000; % use later with no absorption state
% stop current cycle of maxNumMoves % use later with no absorption state
maxNumMoves = 50000;
% stop process after total moves
maxTotalMoves = 25000;
% absorption state - has a reward of 100 as this is our mountain 'peak'
absorptionState = numStateRows*numStateCols;
% 1 if q learning demo moving around is on (otherwise 0)
demoOn = 1;

%%%%%%%%%%%%%% no need to change anything under here
 

% set grid matrix of states
mStates = reshape(1:numStates,numStateRows,numStateCols);

% % set linked states matrix (1 for linked; 0 for unlinked)
mLinked = zeros(numStates);
% allow linked states to be all neighbours including diagonal
for i = 1:numStates
% work out point of state i on mStates
[rowSi,colSi] = stateToRowCols(i,numStateRows,numStateCols);
% go through all options that are ok for state i for every next state j
for j = 1:numStates
% find points can move to and then convert to state number
% work out point of state j on mStates
[rowSj,colSj] = stateToRowCols(j,numStateRows,numStateCols);
if (colSj-colSi < 1)&&(colSj-colSi > -1)&&(rowSj-rowSi < 1)&&(rowSj-rowSi > -1)
mLinked(i,j) = 1;
end
% get rid of moving to itself
if (colSj==colSi)&&(rowSj==rowSi)
mLinked(i,j) = 0;
end
end
end
% remove any links starting at absorption state
mLinked(absorptionState,:)=0;
% create q state/action matrices
mQ = zeros(numStates);
% set reward matrix
rewardM = zeros(numStates);
% anything leading to final state is the reward
rewardM(:,absorptionState) = 100;
% rewardM(:,9) = -1000;
% rewardM(:,10) = -1000;
% rewardM(:,11) = -1000;
% rewardM(:,12) = -1000;
 
totalMoves = 0;
%for i = 1:numTrials
i = 0;
keepGoing = 1;
while keepGoing == 1;
i = i+1;
moveThisIteration = 0;
mWatch = zeros(numStateRows,numStateCols);
initialState = 1;
% find initial state point on board
[rowSns,colSns] = stateToRowCols(initialState,numStateRows,numStateCols);
% this pcolor shows actual movements agent takes, comment out to speed up
if demoOn == 1
mWatch(rowSns,colSns) = 1;
padded=padarray(mWatch,[1,1],'post');
subplot(3,3,1);
pcolor(padded)
title('Q Learner - Trying to get bottom left to top right')
axis off;
pause(0.05)
mWatch(rowSns,colSns) = 0;
end
while (initialState ~= absorptionState)&&(moveThisIteration<maxNumMoves) totSteps(i) = i; totMoves(i) = totalMoves; totalMoves = totalMoves +1; moveThisIteration = moveThisIteration + 1; % Q learning algorithm optionVector = mLinked(initialState,:); nextPt = 0; % randomly pick one of the options until one is >0
while nextPt == 0
nextStateRandom = randi([1, numStates]);
nextPt = optionVector(nextStateRandom);
end;
% pick the best next state from qvalues
nextStateVector = mQ(initialState,:);
possibleQ = mLinked(initialState,:).*nextStateVector;
%nextStateBest = nextStateRandom;
nextPt = 0;
nextStateBestQ = 0;
nextStateBest = 0;
for ii = 1:numStates
if possibleQ(ii)>nextStateBestQ
nextStateBestQ = possibleQ(ii);
nextStateBest = ii;
end
end;
% pick best option 1-epsilon of time and random other times
% if epsilon = 1 always picks random next state - is e-greedy
if (rand < (1-epsilon))&&(nextStateBest>0)
nextState = nextStateBest;
else
nextState = nextStateRandom;
end;
% split Q update into two parts
part1 = ((1-lR)*mQ(initialState,nextState));
part2 = lR*((rewardM(initialState,nextState)+(gamma*(max( mLinked(nextState,:).*mQ(nextState,:))))));
mQ(initialState,nextState) = part1 + part2;
% find next state point on board
[rowSns,colSns] = stateToRowCols(nextState,numStateRows,numStateCols);
% this pcolor shows actual movements agent takes, comment out to speed up
if demoOn == 1
mWatch(rowSns,colSns) = 1;
padded=padarray(mWatch,[1,1],'post');
subplot(3,3,1);
pcolor(padded)
title('Q Learner - Trying to get bottom left to top right')
axis off;
pause(0.05)
mWatch(rowSns,colSns) = 0;
end
initialState = nextState;
end;
 
[tBestQ,numStepsBest,totalReward] = BestRoute(mQ,mLinked,numStates,numStateCols,numStateRows,absorptionState,gamma,rewardM);
totBestQ(i) = tBestQ;
toNumStepBest(i)= numStepsBest;
toReward(i)= totalReward;
Qconverge(i) = sum(sum(mQ));
 
% draw value Q table
padded2=padarray(mQ,[1,1],'post');
subplot(3,3,[3 6 9]);
pcolor(padded2)
title('Current Table of State/Action Q Values')
xlabel('Next State (if action to move there is taken)')
ylabel('Current State')
 
% plot number of steps using best Q path
subplot(3,3,4);
plot(totSteps,toNumStepBest)
title('total number of steps using best Q values')
xlabel('number of cycles')
ylabel('best steps')
 
% plot number of moves using best Q path
subplot(3,3,7);
plot(totMoves,toNumStepBest)
title('total number of moves using best Q values')
xlabel('number of moves')
ylabel('best steps')
 
% plot number of steps against sum of Q value matrix
subplot(3,3,5);
plot(totSteps,Qconverge)
title('total value of Q matrix')
xlabel('number of cycles')
ylabel('sum of Q matrix')
 
% plot number of moves against sum of Q value matrix
subplot(3,3,8);
plot(totMoves,Qconverge)
title('total value of Q matrix')
xlabel('number of moves')
ylabel('sum of Q matrix')
 
pause(0.001)
 
if totalMoves>maxTotalMoves
keepGoing = 0;
end
 
end
%
%
function[totalBestQ,numStepsTaken2,totalReward] = BestRoute(mQ,mLinked,numStates,numStateCols,numStateRows,absorptionState,gamma,rewardM)
% Test the best route so far using Q values learnt
% draw best route found so far by taking best q value. Stop if have to turn
% back
% obtain total reward best Q, steps taken best Q and value best Q
 
numStepsTaken2 = 0;
initialState2 = 1;
%lastState2 = 0
onLast2 = 0;
repeated = zeros(numStateRows);
mWatch2 = zeros(numStateRows,numStateCols);
mWatch2(1,1)=1;
totalBestQ = 0;
totalReward = 0;
 
while (onLast2 == 0)&&(repeated(initialState2)==0)
% pick the best next state from qvalues
repeated(initialState2)=1;
 
nextStateVector2 = mQ(initialState2,:);
possibleQ2 = mLinked(initialState2,:).*nextStateVector2;
nextStateBestQ = 0;
for ii = 1:numStates
if possibleQ2(ii)>nextStateBestQ
nextStateBestQ = possibleQ2(ii);
nextStateBest2 = ii;
end
end
if nextStateBestQ > 0
%keep going
nextState2 = nextStateBest2;
 
[rowSns2,colSns2] = stateToRowCols(nextState2,numStateRows,numStateCols);
if (nextState2==absorptionState)
onLast2 = 1;
totalBestQ = totalBestQ/numStepsTaken2;
end
numStepsTaken2 = numStepsTaken2 +1;
% add next reward
totalReward = totalReward + rewardM(initialState2,nextState2);
% add next bestQ value on
totalBestQ = totalBestQ + (gamma*nextStateBestQ);
% find next state point on board
mWatch2(rowSns2,colSns2) = 1;
padded3=padarray(mWatch2,[1,1],'post');
subplot(3,3,2);
pcolor(padded3)
title('Current Best Route using Q values')
axis off;
initialState2 = nextState2;
else
onLast2 = 1;
totalBestQ = totalBestQ/numStepsTaken2;
end
end
 
% function gets the column and row numbers of a given state number
function[row,col] = stateToRowCols(stateNum,numStateRows,numStateCols)
col = ceil(stateNum/numStateCols);
row = (stateNum+numStateRows)-(numStateRows*col);
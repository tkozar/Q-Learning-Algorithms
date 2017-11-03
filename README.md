We consider grid-world-solving agents who can sense the world through imperfect sensors, and are equipped with both egocentric and allocentric learning systems. The agent always has an allocentric state and an egocentric state: the allocentric state is the absolute location in the grid-world (i.e. x and y coordinates) and the egocentric state describes the types of squares surrounding the agent (ie. “wall to the left, lava above, all clear below and to the right”) and is perceived by the agent’s sensors. In this project we model imperfect sensors but assume the agent’s allocentric representation is perfect.

  The allocentric learning system is the typical q-learning system: it learns the values of each action from each allocentric state. Ultimately the allocentric system learns to solve the grid-world. The egocentric learning system considers the egocentric state and learns to predict the consequences of actions. For example, it might learn that if there is lava to the right, then moving east results in a +[1,0] change to the allocentric state and a negative reward. Or that if there is a wall above, moving up results is no change to the allocentric state. The egocentric system accelerates allocentric learning: whenever the agent is in a new allocentric state, and before any action is takem, the egocentric system can predict the outcome of each action given the egocentric information. These predicted experiences are fed into the allocentric learning system, which learns from them as if they were real experiences. The agent can then make a more informed choice about what to do in this new allocentric state. The upshot of this is that the agen can essentially learn what happens when you step into lava or crash into a wall, and then avoid doing those things when it encounters lava & walls in the future.

Our agents sensors are imperfect: their perception of neighboring states can sometimes be wrong. We note that an agent with high quality sensors might get by with a simple egocentric learning system, while lower quality sensors might necessitate a more sophisticated egocentric model. The idea of this project is to use a multi-objective genetic algorithm to create a set of agents with varying trade-offs between sensor “cost” and model “cost”. We’ll see if good fitness can be obtained in a variety of ways (as it seems to be in nature).

Here’s a quick overview of the code:

GridWorld.m
The grid world class. The constructor generates a random grid world with at least one solution. Some of this code is a little confusing, but an agent interacts with the grid world via the ‘step’ method, which takes an old state & action, and returns a new state & reward.

Agent.m 
This is the agent class.  Our agent implements the egocentric learning system as a neural network. The constructor takes a grid world object, and these three parameters:
networkSize: the number of neurons in the network
memorySize: the number of experiences the agent keeps in its memory for network training
sensFailRate: the probability that the agent’s perception of a neighboring state will be wrong

fitnessFunction.m
The multi-objective fitness function accepts a population of parameter sets (each parameter set consists of networkSize, memorySize, and sensFailRate values for one agent).  It creates two random grid worlds – one for training and one for test. Each agent is allowed some time in the training world to build up it’s egocentric model, then transferred to the test world where three objectives are measured:
negative cumulative reward obtained in the test world (negative because the GA minimizes the objective funtion)
model complexity (defined as network size * memory size)
sensor quality (defined as the negative of the sensor fail rate)
The theoretical perfect agent would achieve maximum reward with minimum model complexity and sensor quality. 

Gascript.m
this is the starting point – it simply sets up the GA and runs it.

PlotSurf.m
This is supposed to plot the pareto surface in the three objective dimensions – not sure yet how well it works...

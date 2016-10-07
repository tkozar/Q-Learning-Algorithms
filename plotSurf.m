function state = plotSurf(options,state,flag)
numpts = size(state.Score,1);

% do an (incredibly inefficient) non-dominated sort
pareto = ones(numpts,1);
for i = 1:numpts
    for j = 1:numpts
        if min(state.Score(i,:) > state.Score(j,:))==1
            pareto(i) = 0;
            break;
        end
    end
end

tri = delaunay(state.Score(pareto==1,1),state.Score(pareto==1,2));
trisurf(tri,state.Score(pareto==1,1),state.Score(pareto==1,2),state.Score(pareto==1,3));

hold on;
plot3(state.Score(:,1), state.Score(:,2), state.Score(:,3),'ko');
xlabel('(negative) learning performance');
ylabel('model complexity');
zlabel('sensor quality');
title('objective space and pareto front');
end

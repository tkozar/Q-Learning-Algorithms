function preds = perfectPredictions(egoStateAndAction)

switch egoStateAndAction(9)
    case 1 % down
        switch egoStateAndAction(6)
            case 1 % open
                preds = [1 0 -0.1];
            case 2 % wall
                preds = [0 0 -1];
            case 3 % goal
                preds = [-8,-9,10];
        end
    case 2 % up
        switch egoStateAndAction(2)
            case 1 % open
                preds = [-1 0 -0.1];
            case 2 % wall
                preds = [0 0 -1];
            case 3 % goal
                preds = [-10,-9,10];
        end
    case 3 % left
        switch egoStateAndAction(8)
            case 1 % open
                preds = [0 -1 -0.1];
            case 2 % wall
                preds = [0 0 -1];
            case 3 % goal
                preds = [-9,-10,10];
        end
    case 4 % right
        switch egoStateAndAction(4)
            case 1 % open
                preds = [0 1 -0.1];
            case 2 % wall
                preds = [0 0 -1];
            case 3 % goal
                preds = [-8,-9,10];
        end
end
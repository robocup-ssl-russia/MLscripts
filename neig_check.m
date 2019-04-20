%% block of neighbour check 
function rul = neig_check(agent, Opponent, distance)
X=Blues(7,2:4);
if (isSectorClear(X(1:2),[],Opponent,0,distance)) 
    rul = Rule(agent,0,0, 1, 0, 0);
end
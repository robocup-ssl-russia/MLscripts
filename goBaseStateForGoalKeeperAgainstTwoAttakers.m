function [gkRul, a1Rul, a2Rul] = goBaseStateForGoalKeeperAgainstTwoAttakers(gk, a1, a2, G, V)
    distV = 1500;
    distNV = 850;
    nV = [V(2), -V(1)];
    
    minSpeed = 15;
    P = 4/750;
    D = -1.5;
    vicinity = 50;
    
    gkRul = MoveToPD(gk, G + 150 * V, minSpeed, P, D, vicinity);
    a1Rul = MoveToPD(a1, G + distV * V + distNV * nV, minSpeed, P, D, vicinity);
    a2Rul = MoveToPD(a2, G + distV * V - distNV * nV, minSpeed, P, D, vicinity);
end


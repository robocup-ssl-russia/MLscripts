function [rul] = defenceGoalFor2by2(agent, oppAttacker, G)
    minSpeed = 15;
    P = 4/750;
    D = -1.5;
    vicinity = 50;
    
    rul = MoveToPD(agent, (oppAttacker.z + G) / 2, minSpeed, P, D, vicinity);
end
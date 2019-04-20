function rul = MoveToAvoidance(agent, aimPoint, obstacles)
    step = 100;
    NormalSpeed = 50;
    minSpeed = 20;
    coef = 2/750;
    vicinity = 150;
    
    if ~CheckIntersect([agent.x, agent.y], aimPoint, obstacles)
        rul = MoveToLinear(agent, aimPoint, 0, NormalSpeed, vicinity);
    else
        path = buildPath(obstacles, [agent.x, agent.y], aimPoint, -2500, -200, -1250, 1250, step, step);
        rul = MoveToLinear(agent, [path(2, 1), path(2, 2)], 0, NormalSpeed, 0);
    end
end


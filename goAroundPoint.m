function [rul] = goAroundPoint(agent, center, R, coef1, coef2, Speed)
    v = agent.z - center;
    dist = sqrt(v(1) * v(1) + v(2) * v(2));
    v = v / dist;
    n = [v(2), -v(1)];
    
    cur = R - dist;
    
    %rul = MoveToLinear(agent, agent.z + coef1 * n + (coef2 * cur + coef3 * (cur - prev)) * v, 0, 40, 0);
    rul = MoveToWithRotation(agent, agent.z + coef1 * n + coef2 * cur * v, center, 0, Speed, 0, 5, 20, 0, 0, 0.05, false);
end


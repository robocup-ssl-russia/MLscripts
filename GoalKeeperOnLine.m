function rul = GoalKeeperOnLine(agent, B, G, V)
    v = 800; % окрестность ворот, их ширина, радиус окружности
    eps = 50;
    minBallSpeed = 30;
    historyLength = 4;
    
    persistent BPosHX; %history of ball coordinate X
    persistent BPosHY; %history of ball coordinate Y
    
    if (isempty(BPosHX) || isempty(BPosHY) || numel(BPosHX) < historyLength || numel(BPosHY) < historyLength)
        BPosHX = zeros(1, historyLength);
        BPosHY = zeros(1, historyLength);
        for i = 1: historyLength
            BPosHX(i) = B.x;
            BPosHY(i) = B.y;
        end
    else
        for i = 1: historyLength - 1
            BPosHX(i) = BPosHX(i + 1);
            BPosHY(i) = BPosHY(i + 1);
        end
        BPosHX(historyLength) = B.x;
        BPosHY(historyLength) = B.y;
    end
    
    ballMovement = [B.x, B.y] - [BPosHX(1), BPosHY(1)];
    
    %SpeedX = StabilizationXPID(agent, G(1), 10, 1/750, 0.000000, -0.8, 50);
    %if (sqrt((tmp(1) - B.x) ^ 2 + (tmp(2) - B.y) ^ 2) >= radius) && (V(1) * (B.x - G(1)) + V(2) * (B.y - G(2)) >= 0)
    if (norm(ballMovement) >= minBallSpeed && dot(V, B.z - G) >= 0 && dot(V, ballMovement) < 0)
        p = polyfit(BPosHX, BPosHY, 1);
        [x, y] = getPointForGoalkeeper([0, p(2)], [1, p(1) + p(2)], G, V);
        if (r_dist_points([x, y], G) <= v + eps)
%           SpeedY = StabilizationYPID(agent, y, 60, 5/750, 0.000000, -2 , 100);
%           Speed = SpeedX + SpeedY;
%           rul = Crul(Speed(1), Speed(2), 0, 0, 0);
            rulRot = RotateToLinear(agent, B.z, 5, 0, 0.1);
            rul = MoveToPD(agent, [x, y], 20, 4/750, -1.5, 40);
            rul.sound = rulRot.sound;
        else
           %rul = Crul(SpeedX(1), SpeedX(2), 0, 0, 0);
           rul = RotateToLinear(agent, B.z, 2, 20, 0.05);
        end
    else
        %rul = Crul(SpeedX(1), SpeedX(2), 0, 0, 0);
        %rul = RotateToLinear(agent, [B.x, B.y], 10, 15, 0.2);
        %rul = MoveToWithRotation(agent, G, B.z, 0, 20, 75, 2, 20, 0, 0, 0.05, false);
        rul = MoveToPD(agent, G, 15, 4/750, -1.5, 50);
        rotRul = RotateToLinear(agent, B.z, 2, 20, 0.05);
        rul.sound = rotRul.sound;
        %rul = Crul(0, 0, 0, 0, 0);
    end
end
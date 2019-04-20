function rul = catchBall(agent, B)
    eps = 500;
    delta = 900;
    softeningCoef = 0.2;
    minBallSpeed = 30;
    historyLength = 5;
    
    persistent BPosHX; %history of ball coordinate X
    persistent BPosHY; %history of ball coordinate Y
    
    if (isempty(BPosHX) || isempty(BPosHY))
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
    
    if (norm(ballMovement) >= minBallSpeed)
        p = polyfit(BPosHX, BPosHY, 1);
        a = p(1);
        b = -1;
        c = p(1) * agent.x + p(2) - agent.y;
        d = a ^ 2 + b ^ 2;
        point = [-a * c / d + agent.x, -b * c / d + agent.y]; 
        
        if r_dist_points(point, [agent.x agent.y]) < eps
            rotRul = Crul(0, 0, 0, 0, 0);
            if scalMult(ballMovement, [agent.x, agent.y] - [B.x, B.y]) > 0
                if r_dist_points(point, [B.x, B.y]) < delta
                    point = point + ballMovement * softeningCoef; 
                end
                %{
                angle = getAngle(-ballMovement, [cos(agent.ang), sin(agent.ang)]);
                if (abs(angle) > 0.1)
                    angSpeed = sign(angle) * 7 + 10 * angle;
                end
                %}
                rotRul = RotateToLinear(agent, B.z, 2, 20, 0.05);
            end
            rul = MoveToPD(agent, point, 25, 4/750, -1.5, 25); 
            rul.sound = rotRul.sound;
        else
            rul = Crul(0, 0, 0, 0, 0);
        end
    else
        rul = RotateToLinear(agent, B.z, 2, 20, 0.05);
    end
    %rul = Crul(0, 0, 0, 20, 0);
end
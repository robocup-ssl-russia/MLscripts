function rul = receiveBall(agent, BPosHX, BPosHY)
    historyLength = 5;
    lastItem = numel(BPosHX);
    firstItem = lastItem - historyLength + 1;
    
    ballMovement = [BPosHX(lastItem) - BPosHX(firstItem), BPosHY(lastItem) - BPosHY(firstItem)];

    if scalMult(ballMovement, [agent.x - BPosHX(lastItem), agent.y - BPosHY(lastItem)]) > 0
        p = polyfit(BPosHX, BPosHY, 1);
        a = p(1);
        b = -1;
        c = p(1) * agent.x + p(2) - agent.y;
        d = a ^ 2 + b ^ 2;
        point = [-a * c / d + agent.x, -b * c / d + agent.y]; 

        rotRul = RotateToLinear(agent, [BPosHX(lastItem), BPosHY(lastItem)], 2, 20, 0.05);
        rul = MoveToPD(agent, point, 25, 4/750, -1.5, 25); 
        rul.sound = rotRul.sound;
    else
        rul = Crul(0, 0, 0, 0, 0);
    end
end
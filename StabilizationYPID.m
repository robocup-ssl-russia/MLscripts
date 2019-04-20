function Speed = StabilizationYPID(agent, aimY, minSpeed, P, I, D, eps)
    function Speed = SpeedYFunction(yDist)
        persistent oldYDist;
        persistent sumYDist;
        
        if (isempty(oldYDist))
            oldYDist = yDist;
        end
        
        if (isempty(sumYDist))
            sumYDist = 0;
        end
        
        SpeedCoef = 60;
        if (abs(yDist) > eps)
            Speed = minSpeed + yDist * SpeedCoef  * P + sumYDist * I + (oldYDist - yDist) * D;
        else
            Speed = 0;
        end
        
        oldYDist = yDist;
        sumYDist = sumYDist + yDist;
    end

    Speed = StabilizationY(agent, aimY, @SpeedYFunction);
end
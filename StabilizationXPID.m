function Speed = StabilizationXPID(agent, aimX, minSpeed, P, I, D, eps)
    function Speed = SpeedXFunction(xDist)
        persistent oldXDist;
        persistent sumXDist;
        
        if (isempty(oldXDist))
            oldXDist = xDist;
        end
        
        if (isempty(sumXDist))
            sumXDist = 0;
        end
        
        SpeedCoef = 60;
        if (abs(xDist) > eps)
            Speed = minSpeed + xDist * SpeedCoef  * P + sumXDist * I + (oldXDist - xDist) * D;
        else
            Speed = 0;
        end
        
        oldXDist = xDist;
        sumXDist = sumXDist + xDist;
    end

    Speed = StabilizationX(agent, aimX, @SpeedXFunction);
end
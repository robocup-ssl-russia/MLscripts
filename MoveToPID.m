function [rul] = MoveToPID(agent, aimPoint, minSpeed, P, I, D, vicinity)
    function [Speed] = PIDSpeedFunction(dist)
        persistent oldDist;
        persistent sumDist;
        
        if (isempty(oldDist))
            oldDist = dist;
        end
        
        if (isempty(sumDist))
            sumDist = 0;
        end
        
        speedCoef = 60;
        if (dist > vicinity)
            Speed = minSpeed + speedCoef * P * dist + sumDist * I + (oldDist - dist) * D;
        else
            Speed = 0;
        end
        
        oldDist = dist;
        sumDist = sumDist + dist;
    end

    Speed = MoveTo(agent, aimPoint, @PIDSpeedFunction);
    rul = Crul(Speed(1), Speed(2), 0, 0, 0);
end
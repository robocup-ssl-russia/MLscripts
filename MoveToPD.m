function [rul] = MoveToPD(agent, aimPoint, minSpeed, P, D, vicinity)
    function [Speed] = PIDSpeedFunction(dist)
        persistent oldDist;
        
        if (isempty(oldDist))
            oldDist = zeros(1, 12);
        end
        
        speedCoef = 60;
        if (dist > vicinity)
            Speed = minSpeed + speedCoef * P * dist + (oldDist(agent.id) - dist) * D;
        else
            Speed = 0;
        end
        
        oldDist(agent.id) = dist;
    end

    Speed = MoveTo(agent, aimPoint, @PIDSpeedFunction);
    rul = Crul(Speed(1), Speed(2), 0, 0, 0);
end
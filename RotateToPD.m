function [rul] = RotateToPD(agent, aimPoint, minAngularSpeed, P, D, eps)    
    function [angSpeed] = PIDAngFunction(angDiff)
        persistent oldAngDiff;
        
        if (isempty(oldAngDiff))
            oldAngDiff = zeros(1, 12);
        end
        
        if abs(angDiff) > eps
            angSpeed = sign(angDiff) * minAngularSpeed + angDiff * P + (oldAngDiff(agent.id) - angDiff) * D;
        else
            angSpeed = 0;
        end
        
        oldAngDiff(agent.id) = angDiff;
    end

    rul = Crul(0, 0, 0, RotateTo(agent, aimPoint, @PIDAngFunction), 0);
end


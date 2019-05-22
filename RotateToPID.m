function [rul] = RotateToPID(agent, aimPoint, minAngularSpeed, P, I, D, eps, reset)    
    function [angSpeed] = PIDAngFunction(angDiff)
        persistent oldAngDiff;
        persistent angDiffSum;
        
        if (isempty(oldAngDiff) || reset)
            oldAngDiff = angDiff;
        end
        
        if (isempty(angDiffSum) || reset)
            angDiffSum = 0;
        end
        
        if abs(angDiff) > eps
            angSpeed = sign(angDiff) * minAngularSpeed + angDiff * P + angDiffSum * I + (oldAngDiff - angDiff) * D;
            angDiffSum = angDiffSum + angDiff;
        else
            angSpeed = 0;
            angDiffSum = 0;
        end
        
        oldAngDiff = angDiff;
    end

    rul = Crul(0, 0, 0, RotateTo(agent, aimPoint, @PIDAngFunction), 0);
end


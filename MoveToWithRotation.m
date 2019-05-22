function [rul] = MoveToWithRotation(agent, aimPoint, rotatePoint, sCoef, minSpeed, vicinity, minAngularSpeed, P, I, D, eps, reset)
    function [Speed] = linearSpeedFunction(dist)
        speedCoef = 60;
        if (dist > vicinity)
            Speed = minSpeed + speedCoef * sCoef * dist;
        else
            Speed = 0;
        end
    end

    function [angSpeed] = PIDAngFunction(angDiff)
        persistent oldAngDiff;
        persistent angDiffSum;
        %global outBuffer;
        
        if (isempty(oldAngDiff) || reset)
            oldAngDiff = zeros(1, 12);
        end
        
        if (isempty(angDiffSum) || reset)
            angDiffSum = zeros(1, 12);
        end
        
        if abs(angDiff) > eps
            angSpeed = sign(angDiff) * minAngularSpeed + angDiff * P + angDiffSum(agent.id) * I + (oldAngDiff(agent.id) - angDiff) * D;
        else
            angSpeed = 0;
        end

        %outBuffer(13) = angSpeed;
        oldAngDiff(agent.id) = angDiff;   
        angDiffSum(agent.id) = angDiffSum(agent.id) + angDiff;
    end

    Speed = MoveTo(agent, aimPoint, @linearSpeedFunction);
    rul = Crul(Speed(1), Speed(2), 0, RotateTo(agent, rotatePoint, @PIDAngFunction), 0);
end


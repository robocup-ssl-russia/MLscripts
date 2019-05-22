%agent - robot info
%aimPoint - point to which robot is rotating
%coef - linear velocity coefficient
%minAngularSpeed - minimal speed of rotation
%eps - allowable error of angle

function [rul] = RotateToLinear(agent, aimPoint, minAngularSpeed, coef, eps)
    %function which show linear influence of angle changing to angle speed
    function [angSpeed] = linearAngFunction(angDiff)
        if abs(angDiff) > eps
            angSpeed = sign(angDiff) * minAngularSpeed + angDiff * coef;
        else
            angSpeed = 0;
        end
    end

    rul = Crul(0, 0, 0, RotateTo(agent, aimPoint, @linearAngFunction), 0);
end


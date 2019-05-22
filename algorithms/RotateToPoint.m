function rul = RotateToPoint(agent, G)
    vx = agent.x - G(1);
    vy = agent.y - G(2);
    ux = cos(agent.ang);
    uy = sin(agent.ang);
    dif = sign(vectMul(vx, vy, ux, uy)) * acos(scalMul(vx, vy, ux, uy) / sqrt(vx ^ 2 + vy ^ 2));
    
    angVelocityInPlace = 15; %angular velocity when robot came to the ball    
    eps = 0.1; %accuracy of rotation
    if abs(dif) > eps
        rul = Crul(0, 0, 0, dif * angVelocityInPlace, 0);
    else
        rul = Crul(0, 0, 0, 0, 0);
    end
end

function [res] = vectMul(vx, vy, ux, uy)
    res = vx * uy - ux * vy;
end

function [res] = scalMul(vx, vy, ux, uy)
    res = vx * vy + ux * uy;
end
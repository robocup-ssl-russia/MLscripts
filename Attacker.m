%simple attacker - just go to point in front of ball and gates and go stright to ball and kick it. Goal isn't guarantied!!! 
function rul = Attacker(agent, ball, gateCenter) 
    %flag for ordering
    global outBuffer;
    %go to point of start
    if (outBuffer(1) == 0)    
        r = 100;    %radius of the robot
        bl = [ball.x ball.y];
        vec = bl - gateCenter;
        G = bl+vec/sqrt(vec(1)^2 + vec(2)^2)*4*r;
        
        
        
        
        vyDir = atan2((G(2) - agent.y), (G(1) - agent.x));
        vyDist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);
        vxDist = 1.75 * r;
        vxDir = vyDir - pi / 2;
        vbDir = atan2((bl(2) - agent.y), (bl(1) - agent.x));
        vbDist = sqrt((agent.x - bl(1)) ^ 2 + (agent.y - bl(2)) ^ 2);
        vy = [vyDist * cos(vyDir), vyDist * sin(vyDir)];
        vx = [vxDist * cos(vxDir), vxDist * sin(vxDir)];
        vb = [vbDist * cos(vbDir), vbDist * sin(vbDir)];
        cosAngleX = scalMul(vx(1), vx(2), vb(1), vb(2)) / (vbDist * vxDist);  
        cosAngleY = scalMul(vy(1), vy(2), vb(1), vb(2)) / (vbDist * vyDist);
        
        if ((abs(vbDist * cosAngleX) < vxDist) && (vbDist * cosAngleY < vyDist && 0 < vbDist * cosAngleY))
            vecDir = atan2((G(2) - bl(2)), (G(1) - bl(1))) - pi/2;
            vecDist = 5 * r;
            vector = [vecDist * cos(vecDir), vecDist * sin(vecDir)];
            G = [bl(1) + vector(1), bl(2) + vector(2)];
        end
        
        direction = atan2((G(2) - agent.y), (G(1) - agent.x)) - agent.ang + pi/2;
        minSpeed = 20;

        coef = 80 / 650; %linear velocity coefficient

        dist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);
        
        
        Speed = minSpeed + coef * dist;
        SpeedX = Speed * cos(direction);
        SpeedY = Speed * sin(direction);

        vicinity = 10;

        if (dist > vicinity)
            rul = Crul(SpeedX, SpeedY, 0, 0, 0);
        else
            rul = Crul(0, 0, 0, 0, 0);
            outBuffer(1) = 1;
        end
    end
    
    %rotate to ball
    
    if (outBuffer(1) == 1)
        vx = agent.x - ball.x;
        vy = agent.y - ball.y;
        ux = -cos(agent.ang);
        uy = -sin(agent.ang);
        dif = -atan2(vectMul(vx, vy, ux, uy), scalMul(vx, vy, ux, uy));

        angVelocityMinSpeed = 5;
        angVelocityInPlace = 15; %angular velocity when robot came to the ball    
        eps = 0.05; %accuracy of rotation
        if abs(dif) > eps
            rul = Crul(0, 0, 0, sign(dif) * angVelocityMinSpeed + dif * angVelocityInPlace, 0);
        else
            outBuffer(1) = 2;
        end
    end

    
    %attack
    if (outBuffer(1) == 2)
        vx = agent.x - ball.x;
        vy = agent.y - ball.y;
        ux = -cos(agent.ang);
        uy = -sin(agent.ang);
        dif = -atan2(vectMul(vx, vy, ux, uy), scalMul(vx, vy, ux, uy));
        
        %{
        angFinal = atan2((ball.y - agent.y), (ball.x - agent.x));
        dif = angFinal - agent.ang;
        %}
        pcoef = 1 / 750; %linear velocity coefficient
        angVelocity = 15; %angular velocity when robot came to the ball    
        minSpeed = 15; %minimum speed(to avoid resistance of floor)
        speedCoef = 60; %coefficient of trust for robot
        dist = sqrt((agent.x - ball.x) ^ 2 + (agent.y - ball.y) ^ 2);
        r = 100;    %radius of the robot
        err = 60;   
        vicinity = r + err; %radius of the vicinity of G

        Speed = minSpeed + speedCoef * pcoef * (dist - r);
        direction = pi / 2 + dif;
        SpeedX = Speed * cos(direction); 
        SpeedY = Speed * sin(direction);
        eps = 0.1; %accuracy of rotation
        %{
        if (dist > vicinity && abs(dif) > eps)
            rul = Crul(SpeedX, SpeedY, 0, dif * angVelocityInMove, 0);
        elseif (dist > vicinity && abs(dif) <= eps)
            rul = Crul(SpeedX, SpeedY, 0, 0, 0);  
        elseif (dist <= vicinity && abs(dif) > eps)
            rul = Crul(0, 0, 0, dif * angVelocityInPlace, 0);
        else
            rul = Crul(0,0,1,0,0);
           % outBuffer(1) = 3;
        end
        %}
        if dist > vicinity
            rul = Crul(SpeedX, SpeedY, 0, dif * angVelocity, 0);
        else
            rul = Crul(0, 0, 1, 0, 0);
            outBuffer(1) = 3;
        end
    elseif outBuffer(1) == 3
       rul = Crul(0, 0, 0, 0, 0); 
    end
    
end

function [res] = vectMul(vx, vy, ux, uy)
    res = vx * uy - ux * vy;
end

function [res] = scalMul(vx, vy, ux, uy)
    res = vx * ux + vy * uy;
end

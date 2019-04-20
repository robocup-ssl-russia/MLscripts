function rul = MoveToPointForGoalKeeper(agent, G, ball) 
    direction = atan2((G(2) - agent.y), (G(1) - agent.x)) - agent.ang + pi/2;
    vx = agent.x - ball.x;
    vy = agent.y - ball.y;
    ux = -cos(agent.ang);
    uy = -sin(agent.ang);
    difBall = -atan2(vectMul(vx, vy, ux, uy), scalMul(vx, vy, ux, uy));
    
    pcoef = 4 / 750; %linear velocity coefficient
    angVelocityInMove = 20; %angular velocity while robot is moving to ball
    angVelocityInPlace = 30; %angular velocity when robot came to the ball    
    minSpeed = 30; %minimum speed(to avoid resistance of floor)
    speedCoef = 60; %coefficient of trust for robot
    farSpeed = 80;
    nearSpeed = 40;
    dist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);
    r = 0;    %radius of the robot
    err = 100;   
    vicinity = r + err; %radius of the vicinity of G

    Speed = minSpeed + speedCoef * pcoef * dist;
    angVelocityMinSpeed = 10;
    eps = 0.1; %accuracy of rotation
    %{
    if (dist > vicinity && abs(difBall) > eps)
        rul = Crul(SpeedX, SpeedY, 0, sign(difBall) * angVelocityMinSpeed + difBall * angVelocityInMove, 0);
    elseif (dist > vicinity)
        rul = Crul(SpeedX, SpeedY, 0, 0, 0);  
    elseif (abs(difBall) > eps)
        rul = Crul(0, 0, 0, sign(difBall) * angVelocityMinSpeed + difBall * angVelocityInPlace, 0);
    end
    %}
    if dist > vicinity
        rul = Crul(farSpeed * cos(direction), farSpeed * sin(direction), 0, 0, 0);
    elseif dist > 50
        rul = Crul(nearSpeed * cos(direction), nearSpeed * sin(direction), 0, 0, 0);
    else
        rul = Crul(0, 0, 0, 0, 0);
    end
end

function [res] = vectMul(vx, vy, ux, uy)
    res = vx * uy - ux * vy;
end

function [res] = scalMul(vx, vy, ux, uy)
    res = vx * ux + vy * uy;
end
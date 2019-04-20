function rul = GoToBall(agent, G) 
    angFinal = atan2((G(2) - agent.y), (G(1) - agent.x));
    dif = angFinal - agent.ang;
    pcoef = 1 / 750; %linear velocity coefficient
    angVelocityInMove = 5; %angular velocity while robot is moving to ball
    angVelocityInPlace = 15; %angular velocity when robot came to the ball    
    minSpeed = 15; %minimum speed(to avoid resistance of floor)
    speedCoef = 60; %coefficient of trust for robot
    dist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);
    r = 100;    %radius of the robot
    err = 0;   
    vicinity = r + err; %radius of the vicinity of G

    Speed = minSpeed + speedCoef * pcoef * (dist - r);
    direction = pi / 2 + dif;
    SpeedX = Speed * cos(direction); 
    SpeedY = Speed * sin(direction);
    eps = 0.1; %accuracy of rotation
    if (dist > vicinity && abs(dif) > eps)
        rul = Crul(SpeedX, SpeedY, 0, dif * angVelocityInMove, 0);
    elseif (dist > vicinity)
        rul = Crul(SpeedX, SpeedY, 0, 0, 0);  
    else
        rul = Crul(0, 0, 1, dif * angVelocityInPlace, 0);
    end
end 

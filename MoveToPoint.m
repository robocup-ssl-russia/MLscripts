%Movement of the robot Agent to the point G.
%Stop in the vicinity of the ball and turn to it.

function rul = MoveToPoint(agent, G) 
angFinal = atan2((G(2) - agent.y), (G(1) - agent.x));
angRobot = agent.ang;
dif = angFinal - angRobot;

coef = 60 / 650; %linear velocity coefficient
coef1 = 15;      %angular velocity coefficient

dist = sqrt((agent.x - G(1)) ^ 2 + (agent.y - G(2)) ^ 2);

SpeedX = coef * cos(pi / 2 + dif) * dist;
SpeedY = coef * sin(pi / 2 + dif) * dist;

r = 100;    %radius of the robot
err = 50;   %radius of the vicinity of G
vicinity = r + err;

if (dist > vicinity)
     rul = Crul(SpeedX, SpeedY, 0, 0, 0);
else
    rul = Crul(0, 0, 0, dif * coef1, 0);
end
end
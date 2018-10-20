%Movement of the robot Agent to the point G.
%Stop in the vicinity of the ball and turn to it.

function rul = MoveToPoint(agent, G) 
angF = atan2((G(2) - agent.y), (G(1) - agent.x));
angR = agent.ang;
dif = angF - angR; 

dist = sqrt((agent.x - G(1)) ^2 + (agent.y - G(2))^2);

SpeedX = 60 * cos(pi / 2 + dif) * (dist / 650);
SpeedY = 60 * sin(pi / 2 + dif) * (dist / 650);

r = 100;    %radius of the robot
err = 50;   %the radius of the vicinity of G
vicinity = r + err; 

if (abs(agent.x - G(1)) > vicinity || abs(agent.y - G(2)) > vicinity)
     rul = Crul(SpeedX, SpeedY, 0, 0, 0);
else
    rul = Crul(0, 0, 0, dif * 15, 0);
end
end
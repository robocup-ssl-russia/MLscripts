%agent - robot info
%aimPoint - point to which robot is moving
%SpeedFunction - function which characterize influence of distance to speed

function [Speed] = MoveTo(agent, aimPoint, SpeedFunction)
    v = aimPoint - [agent.x, agent.y];     %vector to aim
    u = [cos(agent.ang), sin(agent.ang)];  %direction vector of the robot
    dist = sqrt(v(1)^2+v(2)^2);            %distance from robot to aim
    v = v / dist;
    
    SpeedAbs = SpeedFunction(dist);        %absolute value of speed
    SpeedX = v(2)*u(1)-v(1)*u(2);          %speed on axis X 
    SpeedY = v(1)*u(1)+v(2)*u(2);          %speed on axis Y
    
        %disp(dist);
    Speed = [SpeedAbs*SpeedX, SpeedAbs*SpeedY];
end


function [Speed] = StabilizationX(agent, aimX, SpeedXFunction)
    v = [aimX - agent.x, 0];     %vector to aim
    u = [cos(agent.ang), sin(agent.ang)];  %direction vector of the robot
    dist = abs(v(1));            %distance from robot to aim
    v = v / dist;
            
    SpeedAbs = SpeedXFunction(dist);
    SpeedX = v(2)*u(1)-v(1)*u(2);          %speed on axis X 
    SpeedY = v(1)*u(1)+v(2)*u(2);          %speed on axis Y
    
    Speed = [SpeedAbs*SpeedX, SpeedAbs*SpeedY];
end
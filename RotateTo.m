%agent - robot info
%aimPoint - point to which robot is rotating
%SpeedFunction - function which characterize influence of angle changing to angle speed

function [angSpeed] = RotateTo(agent, aimPoint, angFunction)
    v = agent.z - aimPoint;                           %vector to aim
    u = [-cos(agent.ang), -sin(agent.ang)];           %direction vector of the robot  
    angDifference = -r_angle_between_vectors(u, v);   %amount of angles to which robot should rotate
    
    angSpeed = angFunction(angDifference);
end


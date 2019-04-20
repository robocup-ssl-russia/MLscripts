% %движение боком
% SpeedX = 40 * cos(angR);
% SpeedY = 40 * sin(angR);
% 
% %движение в точку
% angF = arctg ((y2 - y1) / (x2 - x1));
% angE = angF - angR;
% r = 100; %радиус робота
% err = 50; %дельта, эпсилон, что угодно
% const = r + err;
% if (abs(RP.agent.x - RP.ball.x) > const || abs(RP.agent.y - RP.ball.y > const))
%     if (angR == angF)  %примерно равно; примерно должно быть довольно большим
%         Rule(Agent, 0, 40, 0, 0);
%     else
%         Rule(Agent, 0, 0, 0, angE * 2);
%     end 
% end

%едем в точку, сразу поворачиваемс€(во врем€ движени€)
% 1 - робот, 2 - м€ч
SpeedX = 40 * cos(RP.Blue(N).ang);
SpeedY = 40 * sin(RP.Blue(N).ang);

angF = arctg ((RP.Ball.y - RP.Blue(N).y) / (RP.Ball.x - RP.Blue(N).x));
angE = angF - angR;

r = 100; %радиус робота
err = 50; %дельта, эпсилон
const = r + err;
if (abs(RP.Blue(N).x - RP.Ball.x) > const || abs(RP.Blue(N).y - RP.Ball.y > const))
    Rule(SpeedX, SpeedY, 0, angE * 2)
end


%[Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance);
%[Left,Right]=GoToPoint(X,Xang,C,Cang), StopDistance=PAR.RobotSize/2;
%[Left,Right]=GoToPoint(X,Xang,C), Сang=Xang, StopDistance=PAR.RobotSize/2;
%[rul]=GoToPoint(Agent,C,Cang,StopDistance);
%[rul]=GoToPoint(Agent,C,Cang), StopDistance=PAR.RobotSize/2;
%[rul]=GoToPoint(Agent,C), Сang=agent.ang, StopDistance=PAR.RobotSize/2;
%
%Движение робота Agent(или координатой X и углом Xang)  к точке С.
%Остановка в окрестности StopDistance и разворот на угол Сang. 
%Если StopDistance - вектор [L1,L2], то при подъезде к цели от расстояния 
%L1 до L2 будет происходить плавное замедление скорости. 
function [Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance)
%% Полиморфизм
global PAR
if (isstruct(X))
    agent=X;
    if (nargin==4)
        StopDistance=Cang;
        Cang=C;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end    
    if (nargin==3)
        StopDistance=PAR.RobotSize/2;
        Cang=C;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end
    if (nargin==2)
        StopDistance=PAR.RobotSize/2;
        Cang=agent.ang;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end
else
    agent=[];
    if (nargin==4)
        StopDistance=PAR.RobotSize/2;
    end    
    if (nargin==3)   
        StopDistance=PAR.RobotSize/2;
        Cang=Xang;
    end
end
if isempty(Cang)
    Cang=Xang;
end
X=reshape(X,1,2);
C=reshape(C,1,2);
%% Вычисление скоростей
%Ub - угловая скорость.
%V - линейная скорость.
if (norm(C-X)>min(StopDistance))
    Ub=azi(angV(C-X)-Xang)/pi; 
    V=1-abs(Ub);
    if length(StopDistance)>1
        V=V*min(1,max(0.1*(min(StopDistance)>0),(norm(C-X)-min(StopDistance))/(max(StopDistance)-min(StopDistance))));
    end
else
    Ub=azi(Cang-Xang)/pi;
    V=0;
end
%% Переход к колесам
Left=100*(V-Ub);
Right=100*(V+Ub);
%% re
if (~isempty(agent))
    Left=Crul(Left,Right,0,0,0);
    Right=NaN;
end
end
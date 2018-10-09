%agent=extrap(agent,T)
%[x,y,ang]=extrap([x,y,ang,v,u],T)
%ѕрогнозирование позиции м€ча или игрока agent через врем€ T
function agent=extrapR(agent,T)
%% ѕараметры
A=-250; %A=-4/0.03; %100..300 %”скорение(трение) м€ча
%% ѕолиморфизм
v=1;
u=0;
ang=0;
id=0;
if isstruct(agent)
    if isfield(agent,'z')
        x=agent.z(1);
        y=agent.z(2);
    else
        error('struct agent not contain data');
    end
    if isfield(agent,'ang')
        ang=agent.ang;
    end
    if isfield(agent,'v')
        v=agent.v;
    end
    if isfield(agent,'u')
        u=agent.u;
    end
    if isfield(agent,'id')
        id=agent.id;
    end
else
    if (length(agent)>=2)
       x=agent(1);
       y=agent(2);
    else
        error('agent not contain data');
    end
    if (length(agent)>=3)
        ang=agent(3);
    end
    if (length(agent)>=4)
        v=agent(4);
    end
    if (length(agent)>=5)
        u=agent(5);
    end
end
%% Ёкстрапол€ци€
%ID м€ча
if (id==100) 
    %–ассто€ние проходимое м€чом.
    L=integral(@(t)max(0,v+A*t),0,T);
    [x,y,ang]=extrap(x,y,ang,L,0,1);
else
    [x,y,ang]=extrap(x,y,ang,v,u,T);
end
%% полиморфизм
if isstruct(agent)
    agent.x=x;
    agent.y=y;
    agent.z=[x,y];
    agent.ang=azi(ang);
else
    agent=[x,y,ang];
end
end
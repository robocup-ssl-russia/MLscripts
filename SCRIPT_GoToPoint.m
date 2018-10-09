%rul=SCRIPT_GoToPoint(agent,C,Opponent)
%Движение в точку с обходом препятствий
function rul=SCRIPT_GoToPoint(agent,C,Opponent)
global Blues Yellows;
if (nargin==2)
    Opponent=[Blues;Yellows];
end
if (agent.I>0)
    rul=TrackAvoidance(agent,[],C,agent.ang,[],Opponent,0,0); %Обходим препятствия и едем к ST  
    rul=RegControl(agent,rul);
else
    rul=RegControl(agent);
end
end
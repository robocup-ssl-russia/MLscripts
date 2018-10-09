%rul=SCRIPT_GoalKeeper(agent,Ball,G)
%Движение к воротам и защита ворот
function rul=SCRIPT_GoalKeeper(agent,Ball,G)

if (agent.I>0)
    if (norm(agent.z-G)<500)
        rul=GoalKeeper(agent,Ball,G);
%        rul=BoardControl(agent,rul);
        rul=MoveControl(agent,rul);
    else
        rul=SCRIPT_GoToPoint(agent,G);
    end
else
     rul=RegControl(agent);    
end

end
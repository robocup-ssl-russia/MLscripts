%
% agent - robot information structure
% ball - ball information structure
% G - goal center point
% V - direction of goal front side (expects norm(V) == 1) 
%
function rul = goalAttack(agent, ball, goalKeeperPosition, G, V, ballInside)
    goalZone = 320;       % distance between goal center and goal edge
    neutralZone = 75;   
    attackInterval = 150; % distance between attack point and goal edge
    %attackInterval = 320;
    
    %rul = attack(agent, ball, G - [V(2) -V(1)] * (goalZone - attackInterval), ballInside); 
    
    persistent attackEdgeIsLeft;
    
    if isempty(attackEdgeIsLeft)
        attackEdgeIsLeft = random('unid', 2) == 1;
    end
    
    orientedDist = V(2) * (goalKeeperPosition(1) - G(1)) - V(1) * (goalKeeperPosition(2) - G(2));
    if (abs(orientedDist) > neutralZone)
        attackEdgeIsLeft = orientedDist < 0;
    end
    
    if (attackEdgeIsLeft)
        rul = attack(agent, ball, G - V * 100 + [V(2) -V(1)] * (goalZone - attackInterval), ballInside);
    else
        rul = attack(agent, ball, G - V * 100 - [V(2) -V(1)] * (goalZone - attackInterval), ballInside); 
    end
end

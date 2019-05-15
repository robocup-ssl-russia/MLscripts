%Rule(Nom, Agent) - recommended
%Rule(Nom, rul) 
%Adding new control to Rules array

function Rule(Num, Agent)
if isfield(Agent, 'rul')
    rul = Agent.rul;
else
    rul = Agent;
end
SpeedY = rul.SpeedY;
SpeedX = rul.SpeedX;
KickForward = rul.KickForward;    
SpeedR = rul.SpeedR;
KickUp = rul.KickUp;

global Rules;
%% Control range check.
if isnan(SpeedX)
    SpeedX = 0;
end
if isnan(SpeedY)
    SpeedY = 0;
end
if isnan(SpeedR)
    SpeedR = 0;
end
if (abs(SpeedX) > 100)
    SpeedX = sign(SpeedX) * 100;
end
if (abs(SpeedY) > 100)
    SpeedY = sign(SpeedY) * 100;
end
if (abs(SpeedR) > 100)
    SpeedY = sign(SpeedR) * 100;
end

%% Make controls integer numbers
SpeedX = fix(SpeedX);
SpeedY = fix(SpeedY);
SpeedR = fix(SpeedR);
%% Loading controls to Rules array
global RP;
if isempty(RP) || (RP.Pause == 1)
    return
end
Rules(Num, 1) = 1;
Rules(Num, 2) = Num;
Rules(Num, 3) = SpeedY;
Rules(Num, 4) = SpeedX;
Rules(Num, 5) = KickForward;
Rules(Num, 6) = SpeedR;
Rules(Num, 7) = KickUp;

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
KickVoltage = rul.KickVoltage;
EnableSpinner = rul.EnableSpinner;
AutoKick = rul.AutoKick;
Beep = rul.Beep;
SpinnerSpeed = rul.SpinnerSpeed;
KickerCharge = rul.KickerCharge;

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
if (KickVoltage < 0)
    KickVoltage = 0;
end
if (abs(KickVoltage) > 15)
    KickVoltage = 15;
end
if (SpinnerSpeed < 0)
    SpinnerSpeed = 0;
end
if (abs(SpinnerSpeed) > 15)
    SpinnerSpeed = 15;
end
if (AutoKick < 0)
    AutoKick = 0;
end
if (abs(AutoKick) > 2)
    AutoKick = 0;
end

%% Make controls integer numbers
SpeedX = fix(SpeedX);
SpeedY = fix(SpeedY);
SpeedR = fix(SpeedR);
SpinnerSpeed = fix(SpinnerSpeed);
AutoKick = fix(AutoKick);
KickVoltage = fix(KickVoltage);

%% Loading controls to Rules array
global RP;
if isempty(RP) || (RP.Pause == 1)
    return
end
Rules(Num, 1) = 1;
Rules(Num, 2) = Num;
Rules(Num, 3) = SpeedX;
Rules(Num, 4) = SpeedY;
Rules(Num, 5) = KickForward;
Rules(Num, 6) = SpeedR;
Rules(Num, 7) = KickUp;
Rules(Num, 8) = AutoKick;
Rules(Num, 9) = KickVoltage;
Rules(Num, 10) = EnableSpinner;
Rules(Num, 11) = SpinnerSpeed;
Rules(Num, 12) = KickerCharge;
Rules(Num, 13) = Beep;

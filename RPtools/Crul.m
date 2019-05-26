% rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp) -- simple control
% rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage,
% EnableSpinner, SpinnerSpeed, KickerCharge, Beep) -- advanced control
% rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick) --
% control with AutoKick
% rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage) --
% control with voltage
% rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage,
% EnableSpinner, SpinnerSpeed) -- control with spiner
% Function place control signals to special structure ready for copying
% to robot structure.
% RP.Blue[N].rul = rul
function rul = Crul(SpeedX, SpeedY, KickForward, SpeedR, KickUp, AutoKick, KickVoltage, EnableSpinner, SpinnerSpeed, KickerCharge, Beep)

if (nargin == 5)
    AutoKick = 0;
    KickVoltage = 12;
    EnableSpinner = 0;
    SpinnerSpeed = 0;
    KickerCharge = 1;
    Beep = 0;
end

if (nargin == 6)
    KickVoltage = 12;
    EnableSpinner = 0;
    SpinnerSpeed = 0;
    KickerCharge = 1;
    Beep = 0;
end

if (nargin == 7)
    EnableSpinner = 0;
    SpinnerSpeed = 0;
    KickerCharge = 1;
    Beep = 0;
end

if (nargin == 9)
    KickerCharge = 1;
    Beep = 0;
end

if ~isnumeric([SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage, EnableSpinner, SpinnerSpeed, KickerCharge, Beep])
    warning('Crul : Not numeric input');
end
if sum(isnan([SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage, EnableSpinner, SpinnerSpeed, KickerCharge, Beep])>0)
    warning('Crul : some element is NaN');
end
if sum(isinf([SpeedY, SpeedX, KickForward, SpeedR, KickUp, AutoKick, KickVoltage, EnableSpinner, SpinnerSpeed, KickerCharge, Beep])>0)
    warning('Crul : some element is inf');
end
rul = struct();
rul.SpeedR = SpeedR;
rul.KickUp = KickUp;
rul.KickVoltage = KickVoltage;
rul.EnableSpinner = EnableSpinner;
rul.SpinnerSpeed = SpinnerSpeed;
rul.KickerCharge = KickerCharge;
rul.AutoKick = AutoKick;
rul.Beep = Beep;
rul.SpeedY = SpeedY;
rul.SpeedX = SpeedX;
rul.KickForward = KickForward;
end


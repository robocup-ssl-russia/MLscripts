% rul = Crul(SpeedY,SpeedX,KickForward,SpeedR,KickUp)
% Function place control signals to special structure ready for copying to robot structure.
% RP.Blue[N].rul = rul
function rul = Crul(SpeedY, SpeedX, KickForward, SpeedR, KickUp)
if ~isnumeric([SpeedY, SpeedX, KickForward, SpeedR, KickUp])
    warning('Crul : Not numeric input');
end
if sum(isnan([SpeedY, SpeedX, KickForward, SpeedR, KickUp])>0)
    warning('Crul : some element is NaN');
end
if sum(isinf([SpeedY, SpeedX, KickForward, SpeedR, KickUp])>0)
    warning('Crul : some element is inf');
end
rul = struct();
rul.SpeedR = SpeedR;
rul.KickUp = KickUp;
rul.SpeedY = SpeedY;
rul.SpeedX = SpeedX;
rul.KickForward = KickForward;
end


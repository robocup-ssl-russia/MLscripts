% rul= Crul(Left,Right,Kick,Sound,Sensor)
% Функция компонует управления для передачи её в поле робота.
% RP.Blue[N].rul=rul
function rul= Crul(Left,Right,Kick,Sound,Sensor)
if ~isnumeric([Left,Right,Kick,Sound,Sensor])
    warning('Crul : Not numeric input');
end
if sum(isnan([Left,Right,Kick,Sound,Sensor])>0)
    warning('Crul : some element is NaN');
end
if sum(isinf([Left,Right,Kick,Sound,Sensor])>0)
    warning('Crul : some element is inf');
end
rul=struct();
rul.sound=Sound;
rul.sensor=Sensor;
rul.left=Left;
rul.right=Right;
rul.kick=Kick;
end


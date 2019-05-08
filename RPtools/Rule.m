%Rule(Nom,Left,Right,Kick,Sound,Sensor)
%Rule(Nom,Left,Right,Kick,Sound), Sensor=0;
%Rule(Nom,Agent) - recommended
%Rule(Nom,rul) 
%Размещение нового управления в массиве Rules
%Добавление 1ого елемента   [1,*,*,...]

function Rule(Num, SpeedY, SpeedX, Kick, Sound, Sensor)
if (nargin == 5)
    Sensor = 0;
end
if (nargin == 2)
    if isfield(SpeedY,'rul')
        rul = SpeedY.rul;
    else
        rul = SpeedY;
    end
    SpeedY = rul.left;
    SpeedX = rul.right;
    Kick = rul.kick;    
    Sound = rul.sound;
    Sensor = rul.sensor;
else
    %warning('<RP>: old definition Rule(Nom,Left,Right,Kick,Sound,Sensor), not recommended');
    if (isstruct(SpeedY))
        error('error using return of function ''Left=rul''. Using rul=funct() and Rule(Nom,rul)');
    end
end

global Rules;
%% Проверки управления.
% <100
if isnan(SpeedX)
    SpeedX=0;
end
if isnan(SpeedY)
    SpeedY=0;
end
if (abs(SpeedX)>100)
    SpeedX=sign(SpeedX)*100;
end
if (abs(SpeedY)>100)
    SpeedY=sign(SpeedY)*100;
end
% Округление
SpeedX=fix(SpeedX);
SpeedY=fix(SpeedY);
%% Передача управления
global RP;
if isempty(RP) || (RP.Pause==1)
    return
end
Rules(Num,1) = 1;
Rules(Num,2) = Num;
Rules(Num,3) = SpeedY;
Rules(Num,4) = SpeedX;
Rules(Num,5) = Kick;
Rules(Num,6) = Sound;
Rules(Num,7) = Sensor;

 
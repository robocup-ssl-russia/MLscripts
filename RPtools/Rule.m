%Rule(Nom,Left,Right,Kick,Sound,Sensor)
%Rule(Nom,Left,Right,Kick,Sound), Sensor=0;
%Rule(Nom,Agent) - recommended
%Rule(Nom,rul) 
%Размещение нового управления в массиве Rules
%Добавление 1ого елемента   [1,*,*,...]

function Rule(Nom,Left,Right,Kick,Sound,Sensor)
if (nargin==5)
    Sensor=0;
end
if (nargin==2)
    if isfield(Left,'rul')
        rul=Left.rul;
    else
        rul=Left;
    end
    Left=rul.left;
    Right=rul.right;
    Kick=rul.kick;    
    Sound=rul.sound;
    Sensor=rul.sensor;
else
    %warning('<RP>: old definition Rule(Nom,Left,Right,Kick,Sound,Sensor), not recommended');
    if (isstruct(Left))
        error('error using return of function ''Left=rul''. Using rul=funct() and Rule(Nom,rul)');
    end
end

global Rules;
RulesI=1;
Rules_length=size(Rules,1);

%% Поиск свободной строки
while ((RulesI<=Rules_length)&&((Rules(RulesI,1)>0)||((Rules(RulesI,1)==1)&&(Rules(RulesI,2)~=Nom))))
    RulesI=RulesI+1;
end

%% Проверки управления.
% <100
if isnan(Right)
    Right=0;
end
if isnan(Left)
    Left=0;
end
if (abs(Right)>100)
    Right=sign(Right)*100;
end
if (abs(Left)>100)
    Left=sign(Left)*100;
end
% Округление
Right=fix(Right);
Left=fix(Left);
%% Передача управления
global RP;
if isempty(RP) || (RP.Pause==1)
    return
end
    Rules(RulesI,1)=1;
    Rules(RulesI,2)=Nom;
    Rules(RulesI,3)=Left;
    Rules(RulesI,4)=Right;
    Rules(RulesI,5)=Kick;
    Rules(RulesI,6)=Sound;
    Rules(RulesI,7)=Sensor;

 
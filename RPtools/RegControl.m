function rul = RegControl(agent,rul)
if (nargin<2)
    rul=agent.rul;
end
%Найден ли агент?
if (agent.I==0)
    %Стоим и пищим.
    rul=Crul(0,0,0,1,0);
end
%Проверка на диапазон.
rul.left(abs(rul.left)>100)=sign(rul.left)*100;
rul.right(abs(rul.right)>100)=sign(rul.right)*100;
global Yellows Blues
%Реактивныцй обход близких препятствий
rul=ReactAvoidance(agent,rul,[Yellows;Blues]);
%Отталкивание от стенок
rul=BoardControl(agent,rul);
%Компенсация мощностей моторчиков
rul=MoveControl(agent,rul);
end


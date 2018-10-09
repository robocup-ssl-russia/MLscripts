% !Устаревшее!
% MOD_NGO(N,R,Color,speed,ModKickAng)
% MOD_NGO(N,Color,R,speed,ModKickAng)
% MOD_NGO(N,R,Color,speed); ModKickAng=0;
% MOD_NGO(N,R,Color), speed=1; ModKickAng=0;
% Соединяет пару номера управления и номера робота
% И замыкает контур управления 

function MOD_NGO(N,Color,R,speed,ModKickAng)
if ischar(R)
    temp=R;
    R=Color;
    Color=temp;
end
if (nargin==3)
    speed=1;
    ModKickAng=0;
end    
if (nargin==4)
    ModKickAng=0;
end    

global Rules;
global Blues;
global Yellows;
global Modul;

if (length(R)>1)    
%%Прямое управление
    if (Color=='Y') 
        Yellows(N,:)=[Yellows(N,1),MOD_GO(Yellows(N,2:3),Yellows(N,4),speed*R(1:2))];
        Modul.YellowsKick(N,:)=[R(3),Yellows(N,4)+ModKickAng];
    end
    if (Color=='B')
        Blues(N,:)=[Blues(N,1),MOD_GO(Blues(N,2:3),Blues(N,4),speed*R(1:2))];
        Modul.BluesKick(N,:)=[R(3),Blues(N,4)+ModKickAng];
    end
else
%% Поиск управления
    if (Color=='Y')
        for i=1:size(Rules,1)    
            if (Rules(i,1)==1)&&(Rules(i,2)==R)
                Yellows(N,:)=[Yellows(N,1),MOD_GO(Yellows(N,2:3),Yellows(N,4),speed*Rules(i,3:4))];
                Modul.YellowsKick(N,:)=[Rules(i,5),Yellows(N,4)+ModKickAng];
            end
        end
    end
    if (Color=='B')
        for i=1:size(Rules,1)    
            if (Rules(i,1)==1)&&(Rules(i,2)==R)
                Blues(N,:)=[Blues(N,1),MOD_GO(Blues(N,2:3),Blues(N,4),speed*Rules(i,3:4))];
                Modul.BluesKick(N,:)=[Rules(i,5),Blues(N,4)+ModKickAng];
            end
        end
    end
end
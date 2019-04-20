%% MAIN START HEADER
global Blues Yellows Balls Rules RP
mainHeader();
if (RP.Pause) %Выход.
    return;
end
MAP(); %Отрисовка карты.
%% Параметры поля
global PAR
PAR.KICK_DIST=200;

PAR.MAP_X=4000;
PAR.MAP_Y=3100;


    PAR.RGate.X=-PAR.MAP_X/4;
    PAR.RGate.Y=PAR.MAP_Y/2;
    PAR.RGate.Z=[PAR.RGate.X,PAR.RGate.Y];
    PAR.RGate.ang=-pi/2;    

    PAR.LGate.X=-PAR.MAP_X/4;
    PAR.LGate.Y=-PAR.MAP_Y/2;
    PAR.LGate.Z=[PAR.LGate.X,PAR.LGate.Y];
    PAR.LGate.ang=pi/2;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK

%% Нападающий
G=[-3100,0];            %Ворота
RP.Blue(10).rul=GOcircle(RP.Blue(10),RP.Ball.z,angV(G-RP.Ball.z));
%% Голкипер.
G=PAR.RGate.Z; %Уровень ворот
RP.Yellow(10).rul=GoalKeeperM(RP.Yellow(10),RP.Ball.z,G);
%%  TrackAvoidance (Нападающий)
B=Balls(2:3);       %цель
X=Yellows(4,2:4);   %Входящий робот (4ый среди жёлтых)
G=[-3000,0];            %Ворота
ST=[-1500,1200];    %Точка ожидания
Opponent=Blues(Blues(:,1)>0,2:3);                 %Соперники (все синии)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %Препятствия (все роботы)
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %Если мячь не в играбетельной зоне
    if (norm(ST-X(1:2))>300) %Если расстояния до точки ожидания больше 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),12,Opponent,0,0); %Обходим препятствия и едем к ST
    else
        %Остановились.
        Left=0;
        Right=0;
    end
    Kick=0;
else
    if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,Opponent,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
        [Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       %Заход на мячь
    else
        Kick=0;
        [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),2,Opponent);  %Обходим препятствия и едем к B
    end
end
[Left,Right]=ReactAvoidance(Left,Right,X(1:2),X(3),Opponent2); %Реактивные обход препятствий (не врезаться в своих).
RP.Yellow(4).rul=Crul(Left,Right,Kick,0,0);
Rule(4,Left,Right,-Kick,0,0); %Отправляем на 4ого робота.

%%  TrackAvoidance (Нападающий)
B=Balls(2:3);       %цель
X=Blues(4,2:4);   %Входящий робот (4ый среди жёлтых)
G=[-1000,-2000];            %Ворота
ST=[-1000,300];    %Точка ожидания
Opponent=Yellows(Yellows(:,1)>0,2:3);                 %Соперники (все синии)
Opponent2=[Blues(Blues(:,1)>0,2:3);Opponent]; %Препятствия (все роботы)
if (RP.Blue(4).I>0)
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2)||(abs(B(2))>PAR.MAP_Y/2)) %Если мячь не в играбетельной зоне
    if (norm(ST-X(1:2))>300) %Если расстояния до точки ожидания больше 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),12,Opponent,0,0); %Обходим препятствия и едем к ST
    else
        %Остановились.
        Left=0;
        Right=0;
    end
    Kick=0;
else
    if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,Opponent,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
        rul=GOcircle(RP.Blue(4),B,angV(G-B));
        Left=rul.left;
        Right=rul.right;
        Kick=rul.kick;        
        %[Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       %Заход на мячь
    else
        Kick=0;
        [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),2,Opponent);  %Обходим препятствия и едем к B
    end
end
[Left,Right]=ReactAvoidance(Left,Right,X(1:2),X(3),Opponent2); %Реактивные обход препятствий (не врезаться в своих).
%RP.Yellow(6).rul=Crul(Left,Right,Kick,0,0);
    Rule(3,Left,Right,-Kick,0,0); %Отправляем на 4ого робота.
else
    Rule(3,0,0,0,1,0);
end
%% Пинающие
if (RP.Blue(4).I>0 && RP.Ball.I>0)
    G=[-1000,-2000];            %Ворота    
    RP.Blue(4).rul=GOcircle(RP.Blue(4),RP.Ball.z,angV(G-RP.Ball.z));
    RP.Blue(4).rul.kick=-RP.Blue(4).rul.kick;
    Rule(3,RP.Blue(4));
else
    Rule(3,0,0,0,1,0);
end

if (RP.Yellow(12).I>0 && RP.Ball.I>0)
    G=[-1000,1300]; %Уровень ворот
    RP.Yellow(12).rul=GoalKeeperM(RP.Yellow(12),RP.Ball.z,G);
    RP.Yellow(12).rul.kick=-RP.Yellow(12).rul.kick;
    Rule(2,RP.Yellow(12));
else
    Rule(2,0,0,0,1,0);
end

if (RP.Yellow(10).I>0 && RP.Ball.I>0)
    G=[-1000,-1100]; %Уровень ворот
    RP.Yellow(10).rul=GoalKeeperM(RP.Yellow(10),RP.Ball.z,G);
    RP.Yellow(10).rul.kick=-RP.Yellow(10).rul.kick;
    Rule(4,RP.Yellow(10));
else
    Rule(4,0,0,0,1,0);
end
 
%% Голкипер.
if (RP.Yellow(9).I>0 && RP.Ball.I>0)
    G=[-2800,0]; %Уровень ворот
    RP.Yellow(9).rul=GoalKeeper(RP.Yellow(9),RP.Ball.z,G);
    RP.Yellow(9).KickAng=-pi/2;    
    RP.Yellow(9).rul.kick=-RP.Yellow(9).rul.kick;    
    Rule(3,RP.Yellow(9));
else
    Rule(3,0,0,0,0,0);
end
%%  TrackAvoidance (Нападающий)
B=Balls(2:3);       %цель
X=Yellows(6,2:4);   %Входящий робот (4ый среди жёлтых)
G=[-1000,2000];            %Ворота
ST=[-1000,-300];    %Точка ожидания
Opponent=Blues(Blues(:,1)>0,2:3);                 %Соперники (все синии)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %Препятствия (все роботы)
if (Yellows(6,1)>0)
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %Если мячь не в играбетельной зоне
    if (norm(ST-X(1:2))>300) %Если расстояния до точки ожидания больше 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),13,Opponent,0,0); %Обходим препятствия и едем к ST
    else
        %Остановились.
        Left=0;
        Right=0;
    end
    Kick=0;
else
    if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,Opponent,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
        rul=GOcircle(RP.Yellow(6),B,angV(G-B));
        Left=rul.left;
        Right=rul.right;
        Kick=rul.kick;        
        %[Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       %Заход на мячь
    else
        Kick=0;
        [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),3,Opponent);  %Обходим препятствия и едем к B
    end
end
[Left,Right]=ReactAvoidance(Left,Right,X(1:2),X(3),Opponent2); %Реактивные обход препятствий (не врезаться в своих).
%RP.Yellow(6).rul=Crul(Left,Right,Kick,0,0);
    Rule(1,Left,Right,-Kick,0,0); %Отправляем на 4ого робота.
else
    Rule(1,0,0,0,1,0);
end
% global temp
% if ~isempty(Modul)
% if isempty(temp)
%     temp.h=plot(0,0);
% end
% if (mod(Modul.N,100)==1)
% if ishandle(temp.h)
%     delete(temp.h);
% end
% temp.left_=rand(1)*150-50;
% temp.right_=rand(1)*150-50;
% temp.h=plot(0,0,'-');
% end
% agent=extrapR(RP.Blue(1),0:0.1:10);
% setPlotData(temp.h,agent.x,agent.y);
% end
%Diagnostics();

%Rule(3,50,-50,0,0);
%Diagnostics();
%RP.Yellow(12).rul=Crul(Rules(1,3),Rules(1,4),0,0,0);





%RP.Blue(1).z=[0,500];
RP.Blue(1).rul=NewRotAlg(RP.Blue(1),B,0);
%RP.Blue(9).rul=SCRIPT_Atack(RP.Blue(9),B,G,[-1000,0],Yellows);
%RP.Blue(9).Nrul=1;
%if isnan(Blues(1,2))
%    error('');
%else
%    Blues
%end
% 
% B=RP.Ball.z;
% agent=RP.Yellow(12);
% G=[-1000,000];
% if (agent.I) && (RP.Ball.I)
%     RP.Yellow(12).rul=GOcircle(agent,B,angV(G-B));
%     RP.Yellow(12).rul=RegControl(RP.Yellow(12));
% else
%     if (agent.I)
%         RP.Yellow(12).rul=GoToPoint(agent,G,[],[100,300]);
%     else
%         RP.Yellow(12).rul=Crul(0,0,0,1,0);
%     end
% end
% RP.Yellow(12).Nrul=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();
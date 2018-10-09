%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR Modul
if isempty(RP)
    addpath tools RPtools MODUL
end
%
mainHeader();
MAP(); %Отрисовка карты.
if (RP.Pause) %Выход.
    return;
end
zMain_End=RP.zMain_End;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PAR.HALF_FIELD=-1;
PAR.MAP_X=4000;
PAR.MAP_Y=3000;
PAR.RobotSize=200;
PAR.KICK_DIST=200;
PAR.DELAY=0.15;
PAR.WhellR=5;

PAR.LGate.X=-2000;
PAR.RGate.X=2000;
%PAR.BorotArm=225;

%% CONTRIL BLOCK
%RP.Yellow(11).rul=GoToPoint(RP.Yellow(11),[-500,500]);
G=[2000,0];
B=RP.Ball.z;
RP.Blue(9).rul=GOcircle(RP.Blue(9),B,angV(G-B));
% G=[2000,0];
% RP.Yellow(1).rul=SCRIPT_GoalKeeper(RP.Yellow(1),RP.Ball,-G);
% RP.Yellow(2).rul=SCRIPT_Atack(RP.Yellow(2),RP.Ball,G,[500,-500]);
% RP.Yellow(3).rul=SCRIPT_Atack(RP.Yellow(3),RP.Ball,G,[-500,-500]);
% 
% G=[-2000,0];
% RP.Blue(1).rul=SCRIPT_GoalKeeper(RP.Blue(1),RP.Ball,-G);
% RP.Blue(2).rul=SCRIPT_Atack(RP.Blue(2),RP.Ball,G,[500,500]);
% RP.Blue(3).rul=SCRIPT_Atack(RP.Blue(3),RP.Ball,G,[-500,500]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
%Rules
zMain_End = mainEnd();
%% MAIN START HEADER

global Blues Yellows Balls FieldInfo Rules RP PAR Modul activeAlgorithm obstacles

if isempty(RP)
    addpath tools RPtools MODUL
end
%

mainHeader();
%MAP();

if (RP.Pause) 
    return;
end

zMain_End=RP.zMain_End;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PAR.HALF_FIELD=-1;
%PAR.MAP_X=4000;
%PAR.MAP_Y=3000;
%PAR.RobotSize=200;
%PAR.KICK_DIST=200;
%PAR.DELAY=0.15;
%PAR.WhellR=5;
%PAR.LGate.X=-2000;
%PAR.RGate.X=2000;
%PAR.BorotArm=225;



%% CONTRIL BLOCK

%{
robots = [8, 7, 1, 4, 3, 2];

%{
for k = robots
    RP.Blue(k).Nrul = k;
end
%}
RP.Blue(robots(1)).Nrul = robots(1);
RP.Blue(robots(2)).Nrul = robots(2);

R = 400;
obst = zeros(numel(robots), 3);
for k = 1: numel(robots)
    rid = robots(k);
    obst(k, 1) = RP.Blue(rid).x;
    obst(k, 2) = RP.Blue(rid).y;
    obst(k, 3) = R;
end

%RP.Blue(7).rul = Attacker(RP.Blue(7), RP.Ball, [-2000, 0]);

G1 = [-2270, 147];
G2 = [-283, -168];
RP.Blue(robots(1)).rul = MoveToAvoidance(RP.Blue(robots(1)), G1, obst(2:6, 1:3));
RP.Blue(robots(2)).rul = MoveToAvoidance(RP.Blue(robots(2)), G1, obst([1, 3:6], 1:3));

%RP.Blue(robots(1)).rul = MoveToLinear(RP.Blue(robots(1)), G, 2/750, 30, 50); 
%}


border1 = [-2000 -1500];
border2 = [2000 1500];
point1 = [-1.7683   -0.2785] * 1000;
point2 = [1500 800];

RP.Blue(3).Nrul = 3;
RP.Blue(2).Nrul = 2;
RP.Blue(4).Nrul = 4;
RP.Blue(7).Nrul = 7;
RP.Blue(8).Nrul = 8;

BlueIDs = [3 5 1 2 9];
YellowIDs = [3 8];

commonSize = numel(BlueIDs) + numel(YellowIDs);
if isempty(obstacles) || size(obstacles, 1) < commonSize
    obstacles = zeros(commonSize, 3);
end
        
radius = 220;
eps = 30;

BCnt = numel(BlueIDs);
for k = 1: BCnt;
    id = BlueIDs(k);
    if RP.Blue(id).I == 1 && r_dist_points(RP.Blue(id).z, [obstacles(k, 1), obstacles(k, 2)]) > eps
        obstacles(k, 1) = RP.Blue(id).x;
        obstacles(k, 2) = RP.Blue(id).y;
        obstacles(k, 3) = radius;
    end
end

for k = 1: numel(YellowIDs)
    id = YellowIDs(k);
    if RP.Yellow(id).I == 1 && r_dist_points(RP.Yellow(id).z, [obstacles(k + BCnt, 1), obstacles(k + BCnt, 2)]) > eps
        obstacles(k + BCnt, 1) = RP.Yellow(id).x;
        obstacles(k + BCnt, 2) = RP.Yellow(id).y;
        obstacles(k + BCnt, 3) = radius;
    end
end
%{
RP.Blue(1).Nrul = 1;
RP.Blue(2).Nrul = 2;
RP.Blue(3).Nrul = 3;
RP.Blue(5).Nrul = 5;
%}

%RP.Blue(4).rul = kickBall(RP.Blue(4), RP.Ball, RP.Blue(7).z, kickBallPreparation());
%RP.Blue(4).rul = RotateToPID(RP.Blue(4), RP.Ball.z, 3, 10, 0.1, -30, 0.01);
%Speed1 = StabilizationXPID(RP.Blue(4), -2300, 10, 1/750, 0.000005, -0.8, 50);
%Speed2 = StabilizationYPID(RP.Blue(4), -187, 40, 4/750, 0, -1.5, 100);
%Speed = Speed1;
%RP.Blue(4).rul = Crul(Speed(1), Speed(2), 0, 0, 0);
% RP.Blue(4).rul = RotateToPID(RP.Blue(4), RP.Ball.z, 3, 30, 0, -50, 0.05, false);
%RP.Blue(4).rul = kickBall(RP.Blue(4), RP.Ball, RP.Blue(7).z, kickBallPreparation());
G1 = [-1000, -1200];
G2 = [-1000, 1200];
V = [0 1];
nV = [1 0];

% G1 = [-1800 0];
% G2 = [1800 0];
% V = [1 0];
% nV = [0 1];

%для отладки-----------------------------------------
global BPosHX; %history of ball coordinate X
global BPosHY; %history of ball coordinate Y
global ballFastMoving;
global ballSaveDir;
historyLength = 5;
if isempty(BPosHX) || isempty(BPosHY)
    BPosHX = zeros(1, historyLength);
    BPosHY = zeros(1, historyLength);
end

if isempty(ballFastMoving)
    ballFastMoving = false;
end

if isempty(ballSaveDir)
    ballSaveDir = true;
end
%----------------------------------------------------

switch activeAlgorithm
    case 0
        %{
        if (RP.Blue(7).x > border1(1) &&  RP.Blue(7).x < border2(1) && RP.Blue(7).y > border1(2) && RP.Blue(7).x < border2(2))
            RP.Blue(7).rul = catchBall(RP.Blue(7), RP.Ball);
        else 
            RP.Blue(7).rul = Crul(0, 0, 0, 0, 0);
        end
        if (RP.Blue(4).x > border1(1) &&  RP.Blue(4).x < border2(1) && RP.Blue(4).y > border1(2) && RP.Blue(4).x < border2(2))
            RP.Blue(4).rul = attack(RP.Blue(4), RP.Ball, RP.Blue(7).z, ballInside);
        else 
            RP.Blue(4).rul = Crul(0, 0, 0, 0, 0);
        end
        %}        
        %RP.Blue(7).rul = MoveToWithFastBuildPath(RP.Blue(7), RP.Ball.z, 250, obstacles);
        %{
        RP.Blue(4).rul = Crul(0, 0, 0, 0, 0);
        RP.Blue(7).rul = Crul(0, 0, 0, 0, 0);
        %}
        %G = [-1900, 0];
        %[RP.Blue(8).rul, RP.Blue(5).rul, RP.Blue(3).rul] = goBaseStateForGoalKeeperAgainstTwoAttakers(RP.Blue(8), RP.Blue(5), RP.Blue(3), G, V);
        minSpeed = 15;
        P = 4/750;
        D = -1.5;
        vicinity = 50;
            
        RP.Blue(3).rul = MoveToPD(RP.Blue(3), G1 + 150 * V, minSpeed, P, D, vicinity);
        RP.Blue(2).rul = MoveToPD(RP.Blue(2), G1 + 600 * V, minSpeed, P, D, vicinity);
        RP.Blue(7).rul = MoveToPD(RP.Blue(7), G2 - 150 * V, minSpeed, P, D, vicinity);
        RP.Blue(8).rul = MoveToPD(RP.Blue(8), G2 - 600 * V, minSpeed, P, D, vicinity);
        
%         
 %       RP.Blue(3).rul = MoveToPD(RP.Blue(1), G1 , minSpeed, P, D, vicinity);
 %       RP.Blue(2).rul = MoveToPD(RP.Blue(2), G1 + 600 * V, minSpeed, P, D, vicinity);
 %       RP.Blue(8).rul = MoveToPD(RP.Blue(3), G2 , minSpeed, P, D, vicinity);
 %       RP.Blue(4).rul = MoveToPD(RP.Blue(4), G2 - 600 * V, minSpeed, P, D, vicinity);
    case 1
        %[RP.Blue(8).rul, RP.Blue(5).rul, RP.Blue(3).rul] = goalKeeperAgainstTwoAttakers(RP.Blue(8), RP.Blue(5), RP.Blue(3), RP.Ball, G, V, ballInside);
        %RP.Blue(8).rul = GoalKeeperOnLine(RP.Blue(8), RP.Ball, G + 250 * V, V)
%         if (RP.Blue(8).I && RP.Ball.I)
%             RP.Blue(8).rul = attack(RP.Blue(8), RP.Ball, RP.Blue(2).z, ballInside);
%         end
        %if (RP.Blue(4).x > border1(1) &&  RP.Blue(4).x < border2(1) && RP.Blue(4).y > border1(2) && RP.Blue(4).x < border2(2))
            %RP.Blue(4).rul = MoveToWithFastBuildPath(RP.Blue(4), [-1.3212e+03 -110.5675], 150, obstacles);
        %else 
            %RP.Blue(4).rul = Crul(0, 0, 0, 0, 0);
        %end
        cmd1 = [7 2];
        cmd2 = [3 8];
        [ballFastMoving, ballSaveDir, BPosHX, BPosHY] = ballMovingManager(RP.Ball);
        %RP.Blue(cmd1(2)).rul = receiveBall(RP.Blue(cmd1(2)), BPosHX, BPosHY);
        [RP.Blue(cmd1(1)).rul, RP.Blue(cmd1(2)).rul] = STPGame2by2FirstCom(RP.Ball, BPosHX, BPosHY, ballFastMoving, ballSaveDir, RP.Blue(cmd1), RP.Blue(cmd2), G1, G2, V, -V, ballInside);
        [RP.Blue(cmd2(1)).rul, RP.Blue(cmd2(2)).rul] = STPGame2by2SecondCom(RP.Ball, BPosHX, BPosHY, ballFastMoving, ballSaveDir, RP.Blue(cmd2), RP.Blue(cmd1), G2, G1, -V, V, ballInside);
    case 2
        %RP.Blue(8).rul = GoalKeeperOnLine(RP.Blue(8), RP.Ball, G + 150 * V, V);
        %---------------HISTORY MANAGER-----------------
        
        if (isempty(BPosHX) || isempty(BPosHY))
            BPosHX = zeros(1, historyLength);
            BPosHY = zeros(1, historyLength);
            for i = 1: historyLength
                BPosHX(i) = RP.Ball.x;
                BPosHY(i) = RP.Ball.y;
            end
        else
            for i = 1: historyLength - 1
                BPosHX(i) = BPosHX(i + 1);
                BPosHY(i) = BPosHY(i + 1);
            end
            BPosHX(historyLength) = RP.Ball.x;
            BPosHY(historyLength) = RP.Ball.y;
        end
        %-----------------------------------------------
        ballMovement = RP.Ball.z - [BPosHX(1), BPosHY(1)];
        if norm(ballMovement) > 30
            RP.Blue(2).rul = receiveBall(RP.Blue(2), BPosHX, BPosHY);
        end
        
%         if (RP.Blue(7).x > border1(1) &&  RP.Blue(7).x < border2(1) && RP.Blue(7).y > border1(2) && RP.Blue(7).x < border2(2) && RP.Ball.x > border1(1) && RP.Ball.x < border2(1) && RP.Ball.y > G(2) && RP.Ball.y < border2(2))
%             RP.Blue(7).rul = attack(RP.Blue(7), RP.Ball, G, ballInside);
%         else 
%             RP.Blue(7).rul = Crul(0, 0, 0, 0, 0);
%         end

    case 3
        %RP.Blue(3).rul = MoveToLinearShort(RP.Blue(3), G2, 30, 60/750, 100);
        minSpeed = 25;
        %P = 4/750;
        %D = -1.5;
        vicinity = 50;
            
        RP.Blue(2).rul = MoveToPD(RP.Blue(2), RP.Ball.z, minSpeed, 0, 0, vicinity);
    case 4
        RP.Blue(8).rul = RotateToLinear(RP.Blue(8), RP.Ball.z, 2, 20, 0.05);
    case 5
        RP.Blue(8).rul = goAroundPoint(RP.Blue(8), RP.Ball.z, 140, 1000, 5, 25);
    case 6
        RP.Blue(8).rul = goAroundPoint(RP.Blue(8), RP.Ball.z, 140, -1000, 5, 25);
    case 7
        center = [-800 0];
        pnt1 = [100 800];
        pnt2 = [100 -800];
        global robotState;
        if isempty(robotState)
            robotState = false;
        end
        
        if robotState
            RP.Blue(2).rul = MoveToLinear(RP.Blue(2), pnt1, 0, 40, 100);
        else
            RP.Blue(2).rul = MoveToLinear(RP.Blue(2), pnt2, 0, 40, 100);
        end
        
        if RP.Blue(2).rul.left == 0 && RP.Blue(2).rul.right == 0
            robotState = ~robotState;
        end
        
        RP.Blue(8).rul = attack(RP.Blue(8), RP.Ball, RP.Blue(2).z, ballInside);
    case 8
        RP.Blue(8).rul = attack(RP.Blue(8), RP.Ball, RP.Blue(2).z, ballInside);
    case 9
        RP.Blue(8).rul = catchBall(RP.Blue(8), RP.Ball);
    case 10
        RP.Blue(8).rul = GoalKeeperOnLine(RP.Blue(8), RP.Ball, G + 150 * V, V);
        
    case 10001
        RP.Blue(8).rul = MoveToPD(RP.Blue(8), G + 150 * V, 15, 4/750, -1.5, 50);
    case 10002
        RP.Blue(2).rul = MoveToWithFastBuildPath(RP.Blue(2), [-1.6749e+03 1.1513e+03], 150, obstacles);
        %RP.Blue(4).rul = MoveToLinear(RP.Blue(4), [-1.6749e+03 1.1513e+03], 0, 40, 50);
    case 10003
        RP.Blue(7).rul = Crul(0, 0, 0, 20, 0);
    case 10004
        RP.Blue(4).rul = RotateToPID(RP.Blue(4), RP.Ball.z, 4, 15, 0, -30, 0.04, false);
    case 10005
        RP.Blue(4).rul = MoveToPID(RP.Blue(4), [-1.5e+03 0.7e+03], 35, 0.5/750, 0, 0, 40);
        RP.Blue(7).rul = MoveToPID(RP.Blue(7), [-0.9e+03 -0.7e+03], 35, 0.5/750, 0, 0, 40);   
    case 10006
        RP.Blue(4).rul = MoveToLinear(RP.Blue(4), [-600 -986], 0, 40, 50);
        RP.Blue(7).rul = MoveToLinear(RP.Blue(7), [-600 986], 0, 40, 50);
    case 10007
%             RP.Blue(2).rul = MoveToLinear(RP.Blue(2), [-845.4487 0], 0, 25, 50);
%             RP.Blue(7).rul = MoveToLinear(RP.Blue(7), 1000 * [-1.6729 0.8112], 0, 25, 50);
%             RP.Blue(8).rul = MoveToLinear(RP.Blue(8), 1000 * [-1.1115 -1.1685], 0, 15, 20);
%             RP.Blue(8).rul = MoveToLinear(RP.Blue(8), [-1900 0], 0, 25, 50);
        [RP.Blue(8).rul, RP.Blue(5).rul, RP.Blue(3).rul] = goBaseStateForGoalKeeperAgainstTwoAttakers(RP.Blue(8), RP.Blue(5), RP.Blue(3), G, V);
    case 10008
        minSpeed = 30;
        P = 0;
        D = 0;
        vicinity = 300;
        RP.Blue(8).rul = MoveToPD(RP.Blue(8), RP.Ball.z, minSpeed, P, D, vicinity);
    otherwise
        RP.Blue(4).rul = Crul(0, 0, 0, 0, 0);
        RP.Blue(7).rul = Crul(0, 0, 0, 0, 0);
end

dex = 1.5;
rob = [2 3 8];
for r = rob
    RP.Blue(r).rul.left = RP.Blue(r).rul.left / dex;
    RP.Blue(r).rul.right = RP.Blue(r).rul.right / dex;
    RP.Blue(r).rul.sound = RP.Blue(r).rul.sound / dex;
end

%RP.Blue(4).rul = GoalKeeperOnLine(RP.Blue(4), RP.Ball, G, V);
%RP.Blue(4).rul = TakeAim(RP.Blue(4), RP.Ball.z, RP.Blue(7).z);
%RP.Blue(7).rul = goAroundPoint(RP.Blue(7), RP.Ball.z, 220, 1000, 5, 40);
%RP.Blue(7).rul = RotateToLinear(RP.Blue(7), RP.Ball.z, 5, 2, 0);
%RP.Blue(7).rul = MoveToLinear(RP.Blue(7), G, 0, 40, 50);

%% END CONTRIL BLOCK

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN END

%Rules

zMain_End = mainEnd();
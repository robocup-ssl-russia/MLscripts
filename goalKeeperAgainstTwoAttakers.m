%
% gk - goalkeeper information structure
% a1 - first agent information structure
% a2 - second agent information structure
% B - ball information structure
% G - goal center point
% V - direction of goal front side (expects norm(V) == 1) 
%
function [gkRul, a1Rul, a2Rul] = goalKeeperAgainstTwoAttakers(gk, a1, a2, B, G, V, ballInside)
%     gkRul = GoalKeeperOnLine(gk, B, G + 250 * V, V);
%     a1Rul = goalAttack(a1, B, gk.z, G, V, ballInside);
%     a2Rul = Crul(0, 0, 0, 0, 0);

    persistent status;
    persistent outTime;
    persistent freezeTime;
    persistent doPass;
    persistent prevBallOwner;
    
    distV = 1500;
    distNV = 850;
    nV = [V(2), -V(1)];
    gkBase = G + 150 * V;
    a1Base = G + distV * V + distNV * nV;
    a2Base = G + distV * V - distNV * nV;
    a1PassPos = G + distV / 2 * V + distNV * nV;
    a2PassPos = G + distV / 2 * V - distNV * nV;
    ownershipRadius = 300;
    
    U = B.z - G;
    X = scalMult(U, V);
    Y = vectMult(U, V);
    
    maxOutTime          = 20;
    maxFreezeTime       = 20 * 2;
    
    gameProcessStatus   =  0;
    outOfGameZoneStatus =  1;
    freezeStatus        =  2;
    
%     gkZoneState         =  2;
%     a1ZoneState         =  3;
%     a2ZoneState         =  4; 
    
    ballFastMovingRes   = checkBallFastMoving(B);
    checkGameZoneRes    = checkGameZone(X, Y) && B.I;
    checkGKZoneRes      = checkGKZone(X, Y) && B.I;
    checkA1ZoneRes      = checkA1Zone(X, Y) && B.I;
    checkA2ZoneRes      = checkA2Zone(X, Y) && B.I;
    
    if isempty(doPass)
        doPass = false;
    end
    
    if isempty(prevBallOwner)
        prevBallOwner = 0;
    end
    
    if isempty(freezeTime)
        freezeTime = 0;
    end
    
    if isempty(outTime)
        outTime = 0;
    end
    
    if isempty(status)
        status = gameProcessStatus;
    end
    
    if (checkGameZoneRes)
        outTime = 0;
    else
        outTime = outTime + 1;
    end
    
    if (outTime >= maxOutTime)
        status = outOfGameZoneStatus;
    end
    
    [gkRul, a1Rul, a2Rul] = stopMoving();
    %doPass = true;
    switch status
        case gameProcessStatus
%             [gkRul, a1Rul, a2Rul] = a1ActiveRoleState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase, false);
%             gkRul = Crul(0, 0, 0, 0, 0);
%             a2Rul = Crul(0, 0, 0, 0, 0);
            if r_dist_points(gk.z, B.z) <= ownershipRadius
                prevBallOwner = 1;
                [gkRul, a1Rul, a2Rul] = gkPassState(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a1Base, a2Base, gkBase);
            elseif r_dist_points(a1.z, B.z) <= ownershipRadius
                doPass = passSolver(2, prevBallOwner, doPass);
                prevBallOwner = 2;
                [gkRul, a1Rul, a2Rul] = a1ActiveRoleState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase, doPass);
            elseif r_dist_points(a2.z, B.z) <= ownershipRadius
                doPass = passSolver(3, prevBallOwner, doPass);
                prevBallOwner = 3;
                [gkRul, a2Rul, a1Rul] = a1ActiveRoleState(gk, a2, a1, B, G, V, ballInside, ballFastMovingRes, a1PassPos, gkBase, doPass);
            elseif checkGKZoneRes
                prevBallOwner = 1;
                [gkRul, a1Rul, a2Rul] = gkPassState(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a1Base, a2Base, gkBase);
            elseif checkA1ZoneRes
                doPass = passSolver(2, prevBallOwner, doPass);
                prevBallOwner = 2;
                [gkRul, a1Rul, a2Rul] = a1ActiveRoleState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase, doPass);
            elseif checkA2ZoneRes
                doPass = passSolver(3, prevBallOwner, doPass);
                prevBallOwner = 3;
                [gkRul, a2Rul, a1Rul] = a1ActiveRoleState(gk, a2, a1, B, G, V, ballInside, ballFastMovingRes, a1PassPos, gkBase, doPass);
            end
            %[gkRul, a2Rul, a1Rul] = a1ActiveRoleState(gk, a2, a1, B, G, V, ballInside, ballFastMovingRes, a1PassPos, gkBase, doPass);
            %[gkRul, a1Rul, a2Rul] = gkPassState(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a1Base, a2Base, gkBase);
        case freezeStatus
            if (freezeTime >= maxFreezeTime)
                status = gameProcessStatus;
                prevBallOwner = 0;
            else
                freezeTime = freezeTime + 1;
            end
        case outOfGameZoneStatus
            if (outTime < maxOutTime)
                status = freezeStatus;
                freezeTime = 0;
            end
    end
end

function res = passSolver(curOwner, prevOwner, doPass)
    if (prevOwner <= 1)
        res = random('unid', 2) == 1;
    elseif (prevOwner ~= curOwner)
        res = false;
    else
        res = doPass;
    end
end

function [gkRul, a1Rul, a2Rul] = a1ActiveRoleState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase, doPass)
    if (doPass)
        [gkRul, a1Rul, a2Rul] = a1PassToA2State(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a2PassPos, gkBase);
    else
        [gkRul, a1Rul, a2Rul] = a1AttackGoalState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase);
    end
end

function [gkRul, a1Rul, a2Rul] = a1PassToA2State(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a2PassPos, gkBase)
    if (ballFastMovingRes)
        a2Rul = catchBall(a2, B);
        a1Rul = catchBall(a1, B);
    else
        a1Rul = attack(a1, B, a2.z, ballInside);
        a2Rul = MoveToWithRotation(a2, a2PassPos, B.z, 2/750, 20, 100, 4, 15, 0, -30, 0.1, false);
    end
    gkRul = GoalKeeperOnLine(gk, B, gkBase, V);
end

function [gkRul, a1Rul, a2Rul] = gkPassState(gk, a1, a2, B, V, ballInside, ballFastMovingRes, a1Base, a2Base, gkBase)
    if (ballFastMovingRes)
        gkRul = GoalKeeperOnLine(gk, B, gkBase, V);
        a1Rul = catchBall(a1, B);
        a2Rul = catchBall(a2, B);
    else
        if (r_dist_points(B.z, a1.z) < r_dist_points(B.z, a2.z))
            gkRul = attack(gk, B, a1.z, ballInside);
        else
            gkRul = attack(gk, B, a2.z, ballInside);
        end
        a1Rul = MoveToWithRotation(a1, a1Base, B.z, 2/750, 20, 100, 2, 20, 0, 0, 0.05, false);
        a2Rul = MoveToWithRotation(a2, a2Base, B.z, 2/750, 20, 100, 2, 20, 0, 0, 0.05, false);
    end
end

function [gkRul, a1Rul, a2Rul] = a1AttackGoalState(gk, a1, a2, B, G, V, ballInside, ballFastMovingRes, a2PassPos, gkBase)
    if (ballFastMovingRes)
        a1Rul = catchBall(a1, B);
    else
        a1Rul = goalAttack(a1, B, gk.z, G, V, ballInside);
    end
    gkRul = GoalKeeperOnLine(gk, B, gkBase, V);
    a2Rul = MoveToWithRotation(a2, a2PassPos, B.z, 2/750, 20, 100, 4, 15, 0, -30, 0.1, false);
end

function res = belongSeg(P, L, R)
    res = L <= P && P <= R;
end

function res = checkGameZone(X, Y)
    minX = 0;
    maxX = 1850;
    minY = -1150;
    maxY = 1150;
    
    res = belongSeg(X, minX, maxX) && belongSeg(Y, minY, maxY);
end

function res = checkGKZone(X, Y)
    minX = 75;
    maxX = 500;
    minY = -600;
    maxY = 600;
    
    res = belongSeg(X, minX, maxX) && belongSeg(Y, minY, maxY);
end

function res = checkA1Zone(X, Y)
    minX = 75;
    maxX = 1850;
    minY = 0;
    maxY = 1150;
    
    res = belongSeg(X, minX, maxX) && belongSeg(Y, minY, maxY);
end

function res = checkA2Zone(X, Y)
    minX = 75;
    maxX = 1850;
    minY = -1150;
    maxY = 0;
    
    res = belongSeg(X, minX, maxX) && belongSeg(Y, minY, maxY);
end

function [gkRul, a1Rul, a2Rul] = stopMoving()
    gkRul = Crul(0, 0, 0, 0, 0);
    a1Rul = Crul(0, 0, 0, 0, 0);
    a2Rul = Crul(0, 0, 0, 0, 0);
end

function res = checkBallFastMoving(B)
    minBallSpeed = 100;
    historyLength = 5;
    
    persistent BPosHX; %history of ball coordinate X
    persistent BPosHY; %history of ball coordinate Y
    
    if (isempty(BPosHX) || isempty(BPosHY))
        BPosHX = zeros(1, historyLength);
        BPosHY = zeros(1, historyLength);
        for i = 1: historyLength
            BPosHX(i) = B.x;
            BPosHY(i) = B.y;
        end
    else
        for i = 1: historyLength - 1
            BPosHX(i) = BPosHX(i + 1);
            BPosHY(i) = BPosHY(i + 1);
        end
        BPosHX(historyLength) = B.x;
        BPosHY(historyLength) = B.y;
    end
    
    ballMovement = [B.x, B.y] - [BPosHX(1), BPosHY(1)];
    res = norm(ballMovement) > minBallSpeed;
end


%ball    - ball
%opp     - opponent robots (without pass giver)
%own     - friend robots
%R       - robot radius
%G       - opponent goal center
%V       - opponent goal front vector
%gsz     - goal size
%oppk    - ball speed diveded by opponent robot speed

function res = getPassPoint(ball, opp, own, R, G, V, gsz, oppk)
    persistent takedPnt;
    hyst = 300;
    ownk = 2.5;
    pCnt = 20; %number of random points
    nV = [V(2), -V(1)];
    A = G + nV * gsz;
    B = G - nV * gsz;
    
    if isempty(takedPnt)
        takedPnt = [-100000 -100000];
    end
    
    ownPos = getPosArr(own);
    oppPos = getPosArr(opp);
    
    defArea = getDefenceArea(ball.z, ownPos, R, ownk);
    [curPnt, curQual] = getCurPassPnt(ball.z, oppPos, defArea, R, A, B, oppk, pCnt);
    %disp(defArea);
    %disp(curPnt);
    if checkPntArea(takedPnt, defArea)
        tPntAvail = pointAvailability(ball.z, takedPnt, oppPos, R);
        if ~tPntAvail
            takedPnt = curPnt;
        else
            [~, tPntQual] = getOptimalDirect(A, B, ball.z, oppPos, R, oppk);
            if tPntQual - hyst > curQual
                takedPnt = curPnt;
            end
        end
    else
        takedPnt = curPnt;
    end
    res = takedPnt;
end

function posarr = getPosArr(cmd)
    posarr = zeros(numel(cmd), 2);
    for k = 1: numel(cmd)
        posarr(k, 1) = cmd(k).x;
        posarr(k, 2) = cmd(k).y;
    end
end

%почему-то не работает
function [pnt, qual] = getCurPassPnt(ballPos, oppPos, defArea, R, A, B, oppk, pCnt)
    pnt = [-100000, -100000];
    qual = 100000;
    
    [nPnt, nQual] = getPassPointInArea(A, B, ballPos, oppPos, R, oppk, defArea(1, 3), defArea(1, 1:2), pCnt);
    disp(nPnt);
    if nQual < qual
        qual = nQual;
        pnt = nPnt;
    end
    
    [nPnt, nQual] = getPassPointInArea(A, B, ballPos, oppPos, R, oppk, defArea(2, 3), defArea(2, 1:2), pCnt);
    disp(nPnt);
    if nQual < qual
        qual = nQual;
        pnt = nPnt;
    end
end
%-------------------------

function res = checkPntArea(pnt, defArea)
    res = false;
    for k = 1: size(defArea, 1)
        if r_dist_points(pnt, defArea(k, 1:2)) < defArea(k, 3)
            res = true;
            break;
        end
    end
end
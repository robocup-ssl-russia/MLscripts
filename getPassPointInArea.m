
%O       - ball position
%Q       - robots positions
%R       - robot radius
%k       - ball speed diveded by robot speed
%aR      - area radius
%aCenter - area center
%pCnt    - number of random points

function [res, quality] = getPassPointInArea(A, B, O, Q, R, k, aR, aCenter, pCnt)
    res = [-100000, -100000];
    quality = 100000;
    for j = 1: pCnt
        pnt = generatePassPoint(aR, aCenter);
        avail = pointAvailability(O, pnt, Q, R);
        [~, curquality] = getOptimalDirect(A, B, O, Q, R, k);
        if avail >= 1/4 && curquality < quality
            quality = curquality;
            res = pnt;
        end
    end
end

function pnt = generatePassPoint(aR, aCenter)
    pnt = [random('Uniform', aCenter(1) - aR, aCenter(1) + aR), random('Uniform', aCenter(2) - aR, aCenter(2) + aR)];
    while norm(pnt - aCenter) > aR
        pnt = [random('Uniform', aCenter(1) - aR, aCenter(1) + aR), random('Uniform', aCenter(2) - aR, aCenter(2) + aR)];
    end
end
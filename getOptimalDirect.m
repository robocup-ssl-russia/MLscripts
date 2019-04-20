
%AB  - goal segment
%O   - ball position
%Q   - robots positions
%R   - robot radius
%k   - ball speed divided by robot speed

function [optDir, quality] = getOptimalDirect(A, B, O, Q, R, k)
    seg = getFreeSpaceSegments(A, B, O, Q, R);
    if (size(seg, 1) == 0)
        optDir = [0, 0];
        quality = 0;
    else
        [optDir, quality] = getOptimalDirectOnSegment(A, B, seg(1, 1), seg(1, 2), O, Q, R, k);
        for j = 2: size(seg, 1)
            [dir, dirQuality] = getOptimalDirectOnSegment(A, B, seg(j, 1), seg(j, 2), O, Q, R, k);
            if dirQuality < quality
                optDir = dir;
                quality = dirQuality;
            end
        end
    end
end

function [dir, dirQuality] = getOptimalDirectOnSegment(A, B, l, r, O, Q, R, k)
    v = B - A;
    eps = 0.01;
    
    if (r - l < eps)
        dir = r * v + A - O;
        dir = dir / norm(dir);
        dirQuality = attackDirectQuality(dir / norm(dir), O, Q, R, k);
    else
        while r - l > eps
            len = (r - l) / 3;
            t1 = l + len;
            t2 = r - len;
            dir = t1 * v + A - O;
            dir2 = t2 * v + A - O;
            dir = dir / norm(dir);
            dirQuality = attackDirectQuality(dir / norm(dir), O, Q, R, k);

            if (dirQuality < attackDirectQuality(dir2 / norm(dir2), O, Q, R, k))
                r = t2;
            else
                l = t1;
            end
        end
    end
end

%function is calculate available segments of goal
%return format is array of segments, 
%each segment presented in the basis B - A

function res = getFreeSpaceSegments(A, B, O, Q, R)
    t = getOccupiedSegments(A, B, O, Q, R);
    res = zeros(size(t, 1) + 1, 2);
    
    if (numel(t) == 0)
        res(1, 1) = 0;
        res(1, 2) = 1;
    else
        resSize = 0;

        nesting = 0;
        prevBound = 0;
        openPos = 1;
        closePos = 1;
        for j = 1: numel(t)
            if (openPos <= size(t, 1) && (closePos > size(t, 1) || t(openPos, 1) <= t(closePos, 2)))
                if (nesting == 0 && prevBound < t(openPos, 1))
                    resSize = resSize + 1;
                    res(resSize, 1) = prevBound;
                    res(resSize, 2) = t(openPos, 1);
                end
                nesting = nesting + 1;
                openPos = openPos + 1;
            else
                prevBound = t(closePos, 2);
                nesting = nesting - 1;
                closePos = closePos + 1;
            end
        end

        if (t(size(t, 1), 2) < 1)
            resSize = resSize + 1;
            res(resSize, 1) = t(size(t, 1), 2);
            res(resSize, 2) = 1;
        end
        res = res(1: resSize, :);
    end
end

function t = getOccupiedSegments(A, B, O, Q, R)
    t = zeros(size(Q, 1), 2);
    tSz = 0;
    u = A - O;
    v = B - O;
    AB = B - A;
    for j = 1: size(Q, 1)
        pnts = GetTangentPoints(O(1), O(2), Q(j, 1), Q(j, 2), R);
        intOA = numel(SegmentCircleIntersect(O(1), O(2), A(1), A(2), Q(j, 1), Q(j, 2), R)) > 0;
        intOB = numel(SegmentCircleIntersect(O(1), O(2), B(1), B(2), Q(j, 1), Q(j, 2), R)) > 0;
        [t1, t2] = getOccupiedSegment(pnts(1, :) - O, pnts(2, :) - O, u, v, AB, intOA, intOB);
        if (t1 <= t2)
            tSz = tSz + 1;
            t(tSz, 1) = t1;
            t(tSz, 2) = t2;
        end
    end
    
    t = t(1: tSz, :);
    t = sort(t);
end

function [t1, t2] = getOccupiedSegment(dir1, dir2, u, v, AB, intOA, intOB)
    insDir1 = insideAngle(u, v, dir1);
    insDir2 = insideAngle(u, v, dir2);
    
%     t1 = vectMult(dir1, -u) / vectMult(dir1, AB);
%     t2 = vectMult(dir2, -u) / vectMult(dir2, AB);
% 
%     if (t1 > t2)
%         temp = t1;
%         t1 = t2;
%         t2 = temp;
%     end
% 
%     t1 = max(t1, 0);
%     t2 = min(t2, 1); 
    
    if intOA && intOB
        %перекрывает всё
        t1 = 0;
        t2 = 1;
    elseif ~insDir1 && ~insDir2
        %не перекрывает ничего
        t1 = 1;
        t2 = 0;
    elseif insDir1 && insDir2
        %перекрывает некоторый отрезок внутри ворот
        t1 = vectMult(dir1, -u) / vectMult(dir1, AB);
        t2 = vectMult(dir2, -u) / vectMult(dir2, AB);

        if (t1 > t2)
            temp = t1;
            t1 = t2;
            t2 = temp;
        end

        t1 = max(t1, 0);
        t2 = min(t2, 1); 
    else
        %перерекрывает некоторый отрезок пересекающий ворота
        if ~insDir1
            dir1 = dir2;
        end
        t1 = vectMult(dir1, -u) / vectMult(dir1, AB);
        if intOA
            t2 = t1;
            t1 = 0;
        else
            t2 = 1;
        end
    end
end

%O - ball position
%pnt - considered point
%Q - robots positions
%R - robot radius
%k - ball speed diveded by robot speed

function res = pointAvailability(O, pnt, Q, R)
    slowK = 4;
    fastK = 1.5;
    slowDefArea = getDefenceArea(O, Q, R, slowK);
    fastDefArea = getDefenceArea(O, Q, R, fastK);
    
    res = 1;
    for j = 1: size(Q, 1)
        cir = slowDefArea(j, :);
        if numel(SegmentCircleIntersect(pnt(1), pnt(2), O(1), O(2), cir(1), cir(2), cir(3))) > 0
            res = 0;
            break;
        end
    end
    
    if res ~= 0
        for j = 1: size(Q, 1)
            cir = fastDefArea(j, :);
            if numel(SegmentCircleIntersect(pnt(1), pnt(2), O(1), O(2), cir(1), cir(2), cir(3))) > 0
                res = res * 0.5;
            end
        end
    end
end

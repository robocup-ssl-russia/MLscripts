function [res] = CheckIntersect(A, B, obstacles)
    res = false;
    eps = 30;
    for k = 1: size(obstacles, 1)
        if size(SegmentCircleIntersect(A(1), A(2), B(1), B(2), obstacles(k, 1), obstacles(k, 2), obstacles(k, 3) + eps), 1) > 0
            res = true;
        end
    end
end
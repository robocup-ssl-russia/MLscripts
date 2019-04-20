function [points] = SegmentCircleIntersect(x1, y1, x2, y2, x0, y0, R)
    x1 = x1 - x0;
    x2 = x2 - x0;
    y1 = y1 - y0;
    y2 = y2 - y0;
    A = y2 - y1;
    B = x1 - x2;
    C = x2 * y1 - y2 * x1;
    res = LineCircleIntersect(A, B, C, R);
    lx = min(x1, x2);
    rx = max(x1, x2);
    ly = min(y1, y2);
    ry = max(y1, y2);
    points = [];
    for k = 1: size(res, 1)
        if lx <= res(k, 1) && res(k, 1) <= rx && ly <= res(k, 2) && res(k, 2) <= ry
            points = [points; [x0 + res(k, 1), y0 + res(k, 2)]];
        end
    end
end


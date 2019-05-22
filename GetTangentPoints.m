function [points] = GetTangentPoints(x, y, x0, y0, R)
    eps = 1e-6;
    v = [x0 - x, y0 - y];
    r = v(1) ^ 2 + v(2) ^ 2 - R * R;
    if r > eps
        points = [x, y; x, y] + CirclesIntersect(v(1), v(2), R, sqrt(r));
    elseif abs(r) < eps
        points = [x, y];
    else
        points = [];
    end
end


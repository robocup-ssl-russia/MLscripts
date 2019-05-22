function [points] = CirclesIntersect(x, y, r, R)
    points = LineCircleIntersect(-2 * x, -2 * y, x * x + y * y + R * R - r * r, R);
end


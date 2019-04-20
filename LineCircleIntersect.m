function [points] = LineCircleIntersect(A, B, C, r)
    eps = 1e-6;
    d = A * A + B * B;
    x0 = -A * C / d;
    y0 = -B * C / d;
    if C * C > r * r * d + eps
        points = [];
    elseif abs(C * C - r * r * d) < eps
        points = [x0, y0];
    else
        D = r * r - C * C / d;
        mult = sqrt(D / d);
        points = [x0 + B * mult, y0 - A * mult; x0 - B * mult, y0 + A * mult];
    end
end


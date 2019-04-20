function [field] = buildField(obstacles, verStep, horStep, pos, l, r, d, u)
    field = zeros(l + r + 1, u + d + 1);
    for x = -l: r
        for y = -d: u
            curx = pos(1) + x * verStep;
            cury = pos(2) + y * horStep;
            take = 0;
            for k = 1: size(obstacles, 1)
                ox = obstacles(k, 1);
                oy = obstacles(k, 2);
                or = obstacles(k, 3);
                if (ox - curx) ^ 2 + (oy - cury) ^ 2 <= or * or
                    take = -1;
                end
            end
            field(x + l + 1, y + d + 1) = take;
        end
    end
end


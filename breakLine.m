function C = breakLine(S, F, obst, obstacles, step)
    normal = F - S;
    normal = normal / sqrt(normal(1) ^ 2 + normal(2) ^2);
    normal = [normal(2), -normal(1)] * (step + obstacles(obst, 3) * sign(step));
    C = [obstacles(obst, 1), obstacles(obst, 2)] + normal;
    
    while checkPoint(C, obstacles)
        C = C + normal;
    end
end

function res = checkPoint(C, obstacles)
    res = false;
    for k = 1: size(obstacles, 1)
        if (r_dist_points(C, [obstacles(k, 1), obstacles(k, 2)]) <= obstacles(k, 3))
            res = true;
            break;
        end
    end
end

    
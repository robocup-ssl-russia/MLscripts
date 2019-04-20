function [obst, dist] = getNearestObstacle(point, obstacles)
    obst = 1;
    dist = r_dist_points(point, [obstacles(1, 1), obstacles(1, 2)]);
    for k = 2: size(obstacles, 1)
        curDist = r_dist_points(point, [obstacles(k, 1), obstacles(k, 2)]);
        if dist >= curDist
            dist = curDist;
            obst = k;
        end
    end
end
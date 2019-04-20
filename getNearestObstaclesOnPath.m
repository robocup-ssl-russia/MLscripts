% function obst = getNearestObstaclesOnPath(S, F, obstacles)
%     obst = -1;
%     minDist = 0;
%     for k = 1: size(obstacles, 1)
%         if numel(SegmentCircleIntersect(S(1), S(2), F(1), F(2), obstacles(k, 1), obstacles(k, 2), obstacles(k, 3))) > 0
%             curDist = minDist;
%             if (obst == -1 || curDist < minDist)
%                 minDist = curDist;
%                 obst = k;
%             end
%         end
%     end
% end

function obst = getNearestObstaclesOnPath(S, F, obstacles)
    obst = -1;
    minDist = 1000000;
    for k = 1: size(obstacles, 1)
        pnts = SegmentCircleIntersect(S(1), S(2), F(1), F(2), obstacles(k, 1), obstacles(k, 2), obstacles(k, 3));
        if numel(pnts) > 0
            curDist = getMinDist(S, pnts);
            if (obst == -1 || curDist < minDist)
                minDist = curDist;
                obst = k;
            end
        end
    end
end

function dist = getMinDist(P, pnts)
    dist = r_dist_points(P, [pnts(1, 1), pnts(1, 2)]);
    for k = 2: size(pnts, 1)
        curDist = r_dist_points(P, [pnts(k, 1), pnts(k, 2)]);
        if (curDist < dist)
            dist = curDist;
        end
    end
end
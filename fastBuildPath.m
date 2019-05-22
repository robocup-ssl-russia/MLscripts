function path = fastBuildPath(S, F, obstacles, step, recDepth)
    import java.util.LinkedList;
    maxRecDepth = 20;
    
    path = LinkedList();
    if (recDepth <= maxRecDepth)
        obst = getNearestObstaclesOnPath(S, F, obstacles);
        if (obst ~= -1)
            C = breakLine(S, F, obst, obstacles, step);
            leftPath = fastBuildPath(S, C, obstacles, step, recDepth + 1);
            rightPath = fastBuildPath(C, F, obstacles, step, recDepth + 1);
            if (~leftPath.isEmpty() && ~rightPath.isEmpty())
                path = leftPath;
                path.removeLast();
                path.addAll(rightPath);
            end
        else
            path.add(S);
            path.add(F);
        end
    end
end
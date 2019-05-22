function pnt = getRandCirclePoint(x0, y0, R)
    pnt = [random('Uniform', x0 - R, x0 + R), random('Uniform', y0 - R, y0 + R)];
    
    if r_dist_points(pnt, [x0, y0]) > R
        pnt = getRandCirclePoint(x0, y0, R);
    end
end
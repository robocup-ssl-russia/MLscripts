function res = r_dist_point_line(pnt, A, B) 
    v = B - A;
    res = abs(vectMult(pnt - B, v)) / norm(v, 2);
end


function res = r_dist_points(A, B) 
    res = 0;
    dim = min(numel(A), numel(B));
    for k = 1: dim
        res = res + (A(k) - B(k)) ^ 2;
    end
    res = sqrt(res);
end
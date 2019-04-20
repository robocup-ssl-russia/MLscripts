function [pnt] = lineIntersect(A, aDir, B, bDir)
    t = vectMult(bDir, B - A) / vectMult(bDir, aDir);
    pnt = A + t * aDir;
end


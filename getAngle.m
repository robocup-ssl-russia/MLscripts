function [ang] = getAngle(V, U)
    ang = atan2(vectMult(V, U), scalMult(V, U));
end


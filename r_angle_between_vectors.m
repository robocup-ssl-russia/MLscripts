function [ang] = r_angle_between_vectors(V, U)
    ang = atan2(vectMult(V, U), scalMult(V, U));
end


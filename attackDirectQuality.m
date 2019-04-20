
%dir - attack direction norm(dir) == 1
%O   - ball position
%Q   - robots positions
%R   - robot radius
%k   - ball speed divided by robot speed

function res = attackDirectQuality(dir, O, Q, R, k)
    res = attackDirectQualityForObst(dir, O, [Q(1, 1), Q(1, 2)], R, k);

    for j = 2: size(Q, 1)
        res = max(res, attackDirectQualityForObst(dir, O, [Q(j, 1), Q(j, 2)], R, k));
    end
end

function res = attackDirectQualityForObst(dir, O, Q, R, k)
    n = [dir(2) -dir(1)] * sign(vectMult(dir, Q - O));
    P = Q + R * n;
    v = P - O;
    
    xQ = dot(v, dir);
    yQ = abs(vectMult(v, dir));

    if (xQ < 0)
        res = -1000000; %-бесконечность
    else
        res = xQ - yQ * sqrt(k * k - 1);
    end
end


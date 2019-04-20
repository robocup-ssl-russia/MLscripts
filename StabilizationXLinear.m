function Speed = StabilizationXLinear(agent, aimX, minSpeed, coef, eps)
    function Speed = SpeedXFunction(xDist)
        SpeedCoef = 60;
        if (abs(xDist) > eps)
            Speed = minSpeed + xDist * SpeedCoef  * coef;
        else
            Speed = 0;
        end
    end

    Speed = StabilizationX(agent, aimX, @SpeedXFunction);
end
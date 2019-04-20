function Speed = StabilizationYLinear(agent, aimY, minSpeed, coef, eps)
    function Speed = SpeedYFunction(yDist)
        SpeedCoef = 60;
        if (abs(yDist) > eps)
            Speed = minSpeed + yDist * SpeedCoef  * coef;
        else
            Speed = 0;
        end
    end

    Speed = StabilizationY(agent, aimY, @SpeedYFunction);
end
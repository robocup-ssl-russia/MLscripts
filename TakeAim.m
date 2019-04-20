function [rul] = TakeAim(agent, center, aim, radius, minSpeed, speedCoef, angError)
    wishV = center - aim;
    v = agent.z - center;
    ang = getAngle(wishV, v);

    if (abs(ang) > angError)
        rul = goAroundPoint(agent, center, radius, 1000 * sign(ang), 5, minSpeed + speedCoef * abs(ang));
    else
        rul = RotateToPID(agent, aim, 4, 10, 0.1, -30, 0.05, false);
        %rul = Crul(0, 0, 0, 0, 0);
    end
    %rul = Crul(50, 0, 0, 0, 0);
end


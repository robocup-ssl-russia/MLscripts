function [frul, srul] = givePas2by2(ball, own, opp, oppG, oppV, ballInside)
    %{
    persistent takedPnt;
    hyst = 300;
    R = 130;
    k = 2.5;
    
    if isempty(takedPnt)
        takedPnt = own(2).z;
    end
    
    Q(1, :) = opp(1).z;
    Q(2, :) = opp(2).z;
    pnt = getPasPoint(ball, own, opp, oppG, oppV);
    prevav = pointAvailability(ball.z, takedPnt, Q, R);
    prevdef = getDefenceArea(takedPnt, Q, R, k);
    if (prevav < 0.25)
        takedPnt = pnt;
    end
    
    minSpeed = 15;
    P = 4/750;
    D = -1.5;
    vicinity = 50;
    
    frul = attack(own(1), ball, takedPnt, ballInside);
    srul = MoveToPD(own(2), takedPnt, minSpeed, P, D, vicinity);
    %}
    
end
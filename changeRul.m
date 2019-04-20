function [rul] = changeRul(curRul, aimRul)
    maxSpeedChanging = 15;
    maxRSpeedChanging = 5;
    
    rul = curRul;
    rul.left = changeValue(curRul.left, aimRul.left, maxSpeedChanging);
    rul.right = changeValue(curRul.right, aimRul.right, maxSpeedChanging);
    rul.sound = changeValue(curRul.sound, aimRul.sound, maxRSpeedChanging);
end

function [nval] = changeValue(curVal, aimVal, maxChange)
    dVal = aimVal - curVal;
    if (abs(dVal) < maxChange)
        nval = aimVal;
    else
        nval = curVal + maxChange * sign(dVal);
    end
end


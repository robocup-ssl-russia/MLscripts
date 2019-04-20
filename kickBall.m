function [rul] = kickBall(agent, ball, aim, statePointer)
    switch getGlobalMemory(statePointer)
        case 0 %move to ball
            rul = handleMoveToBallState(agent, ball, statePointer);
        case 1 %take aim
            rul = handleTakeAimState(agent, ball, aim, statePointer);  
        case 2 %kick ball
            rul = handleKickBallState(agent, ball, aim, statePointer);
        otherwise 
            rul = Crul(0, 0, 0, 0, 0);
    end
end

function resetRulFunctions(agent, aim)
    RotateToPID(agent, aim, 0, 0, 0, 0, 0, true);
    MoveToWithRotation(agent, aim, aim, 0, 0, 0, 0, 0, 0, 0, 0, true);
end

function [rul] = handleMoveToBallState(agent, ball, statePointer)
    vicinity = 450;
    rul = MoveToWithRotation(agent, ball.z, ball.z, 1/1000, 25, vicinity, 3, 30, 0, -50, 0.1, false);
    if (rul.left == 0 && rul.right == 0 && rul.sound == 0)
        rul = Crul(0, 0, 0, 0, 0);
        setGlobalMemory(statePointer, 1);
        resetRulFunctions(agent, ball.z);
    end
end

function [rul] = handleTakeAimState(agent, ball, aim, statePointer)
    rul = TakeAim(agent, ball.z, aim, 250, 40, 7, 3.14 / 30);
    if (rul.left == 0 && rul.right == 0 && rul.sound == 0)
        setGlobalMemory(statePointer, 2);
        resetRulFunctions(agent, aim);
    end
end

function [rul] = handleKickBallState(agent, ball, aim, statePointer)
    rul = MoveToWithRotation(agent, ball.z, aim, 0, 25, 170, 3, 15, 0.8, -30, 0.04, false);
    if (rul.left == 0 && rul.right == 0 && rul.sound == 0)
        rul = Crul(0, 0, 1, 0, 0);
        setGlobalMemory(statePointer, 3);
        resetRulFunctions(agent, aim);
    end
end

%{
function [checkPointer] = checkTakeAimPreparation()
    persistent pnt;
    
    if (isempty(pnt))
       pnt = allocateGlobalMemory(); 
    end
    
    checkPointer = pnt;
end

function [rul] = handleCheckTakeAimState(agent, ball, aim, statePointer)
    checkPointer = checkTakeAimPreparation();
    checkIterationCount = 2;
    
    if (getGlobalMemory(checkPointer) < checkIterationCount)
        wishV = [ball.x ball.y] - aim;
        v = agent.z - center;
        ang = getAngle(wishV, v);
        angError = 3.14 / 90;
        
        v = [agent.x, agent.y] - aimPoint;                                  
        u = [-cos(agent.ang), -sin(agent.ang)];                             
        angDifference = -atan2(u(1)*v(2)-v(1)*u(2), v(1)*u(1)+v(2)*u(2));
        
        if (abs(ang) < angError && abs(angDifference) < 0.1)
            setGlobalMemory(checkPointer, getGlobalMemory(checkPointer) + 1);
        else
            setGlobalMemory(statePointer, 2);
        end
    else
        rul = Crul(0, 0, 0, 0, 0);
        setGlobalMemory(statePointer, 4);
    end
end

function setCheckTakeAimState(statePointer)
    checkPointer = checkTakeAimPreparation();
    
    setGlobalMemory(checkPointer, 0);
    setGlobalMemory(statePointer, 3);
end
%}


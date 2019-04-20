function [fastMoving, saveDir, BPosHX, BPosHY] = ballMovingManager(B)
    persistent oldFastMoving;
    persistent oldSaveDir;
    persistent hX; %history of ball coordinate X
    persistent hY; %history of ball coordinate Y
    minBallSpeed = 50;
    hLen = 5; %historyLength
    
    if isempty(oldFastMoving) 
        oldFastMoving = false;
    end
    
    if isempty(oldSaveDir)
        oldSaveDir = true;
    end
    
    global outBuffer;
    
    if (B.I)
        
        if (isempty(hX) || isempty(hY) || numel(hX) < hLen || numel(hY) < hLen)
            hX = zeros(1, hLen);
            hY = zeros(1, hLen);
            for i = 1: hLen
                hX(i) = B.x;
                hY(i) = B.y;
            end
        else
            for i = 1: hLen - 1
                hX(i) = hX(i + 1);
                hY(i) = hY(i + 1);
            end
            hX(hLen) = B.x;
            hY(hLen) = B.y;
        end

        ballMovement = B.z - [hX(hLen - 3), hY(hLen - 3)];
        fastMoving = norm(ballMovement) > minBallSpeed;
        if (fastMoving)
            %задаЄт допустимые значени€ косинуса угла между текущим и
            %предыдущим направлени€ми движени€ м€ча
            sensivity = 0.8;
            curDir = B.z - [hX(hLen - 1), hY(hLen - 1)];
            prevDir = [hX(hLen - 1) - hX(hLen - 2), hY(hLen - 1) - hY(hLen - 2)];
            saveDir = getCos(curDir, prevDir) >= sensivity;
        else
            saveDir = true;
        end
    else
        saveDir = oldSaveDir;
        fastMoving = oldFastMoving;
    end
    oldFastMoving = fastMoving;
    oldSaveDir = saveDir;
    outBuffer(2) = fastMoving;
    BPosHX = hX;
    BPosHY = hY;
end


function res = getCos(U, V)
    res = scalMult(U, V) / (norm(U) * norm(V));
end

function [statePointer] = kickBallPreparation()
    persistent pnt;
    if (isempty(pnt))
        pnt = allocateGlobalMemory();
    end
    
    statePointer = pnt;
end


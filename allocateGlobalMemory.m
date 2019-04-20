function [pointer] = allocateGlobalMemory()
    global bufferEmptyPosition;
    pointer = bufferEmptyPosition;
    bufferEmptyPosition = bufferEmptyPosition + 1;
end


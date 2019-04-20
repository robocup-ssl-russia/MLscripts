function [value] = getGlobalMemory(pointer)
    global outBuffer;
    value = outBuffer(pointer);
end


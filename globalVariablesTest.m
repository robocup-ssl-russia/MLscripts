function globalVariablesTest()
    persistent kokokolol;
    if (isempty(kokokolol))
        kokokolol = 0;
    else
        kokokolol = kokokolol + 1;
    end
    disp(kokokolol);
end


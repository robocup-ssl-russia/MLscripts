function [rul] = MoveToLinearShort(agent, aim, minV, C, eps)
    v = aim - agent.z;                
    D = norm(v);            
    V = [1, 1i] * v' * exp(-1i * agent.ang) * (minV + C * D) * heaviside(D - eps) / D;
    rul = Crul(imag(V), real(V), 0, 0, 0);
end
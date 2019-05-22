function res = insideAngle(U, V, W)
    G = [dot(U, V), dot(V, V); dot(U, U), dot(U, V)];
    B = [dot(W, V); dot(W, U)];
    A = G \ B;
    res = A(1) >= 0 && A(2) >= 0;
end
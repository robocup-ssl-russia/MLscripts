vx = RP.Blue(6).x - RP.Ball.x;
vy = RP.Blue(6).y - RP.Ball.y;
ux = cos(RP.Blue(6).ang);
uy = sin(RP.Blue(6).ang);
disp(atan2(vx * uy - ux * vy, vx * ux + vy * uy));
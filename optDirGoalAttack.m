%отакует ворота в оптимально направлении 
%(в модели где скорость мяча и роботов постоянны)
function [rul] = optDirGoalAttack(agent, ball, oppCom, G, V, ballInside)
    v = 400;            %размер ворот
    R = 130;            %радиус робота
    K = 2;              %скорость мяча делённая на скорость робота
    
    oppPos = zeros(numel(oppCom), 2);
    for k = 1: numel(oppCom)
        oppPos(k, 1) = oppCom(k).x;
        oppPos(k, 2) = oppCom(k).y;
    end
    
    nV = [V(2), -V(1)];
    [optDir, optScore] = getOptimalDirect(G - nV * v, G + nV * v, ball.z, oppPos, R, K);
    %проверяем определено ли оптимальное направление
    if abs(optDir(1)) + abs(optDir(2)) > 0
        rul = attackOptDir(agent, ball, oppPos, G, R, nV, v, optDir, optScore, K, ballInside);
    else
        rul = Crul(0, 0, 0, 0, 0);
    end
end

function rul = attackOptDir(agent, ball, oppPos, G, R, nV, v, optDir, optScore, K, ballInside)
    persistent takeDir; %выбранное направление
    inf = 100000;       %бесконечность (нужна для моделирования лучей)
    hyst = 200;         %hysteresys нужен для того чтобы избежать скачки между соседнимим кадрами
    coef = 2000;        %расстояние до точки, на которую прицеливается робот
    
    optScore = -optScore; %делаем так, потому что функция getOptimalDirect 
                          %возвращает качество направления относительно защитников 
                          %(чтобы соблюдалось правило: чем больше score, тем лучше)
    %проверяет нет ли врагов на атакуемом луче и попадает ли направление в ворота
    if isempty(takeDir) || ~checkDir(ball.z, ball.z + takeDir * inf, oppPos, R, G, nV, v) 
        takeDir = optDir;
    else
        score = -attackDirectQuality(takeDir, ball.z, oppPos, R, K);
        if scalMult(optDir, takeDir) < 0.9 && optScore > score + hyst
            takeDir = optDir;
        end
    end
    
    rul = attack(agent, ball, ball.z + coef * takeDir, ballInside);
end

%проверяет нет ли на AB противников и пересекает ли он ворота
function [res] = checkDir(A, B, oppPos, R, G, nV, v)
    res = true;
    for k = 1: size(oppPos, 1)
        if numel(SegmentCircleIntersect(A(1), A(2), B(1), B(2), oppPos(k, 1), oppPos(k, 2), R)) > 0
            res = false;
            break;
        end
    end
    if res
        pnt = lineIntersect(A, B - A, G, nV);
        res = res && checkRect(pnt, A, B) && checkRect(pnt, G - nV * v, G + nV * v);
    end
end

function [res] = checkRect(pnt, A, B)
    left = min(A(1), B(1));
    right = max(A(1), B(1));
    up = max(A(2), B(2));
    down = min(A(2), B(2));
    
    res = inSeg(pnt(1), left, right) && inSeg(pnt(2), down, up);
end

function [res] = inSeg(x, a, b)
    res = a <= x && x <= b;
end
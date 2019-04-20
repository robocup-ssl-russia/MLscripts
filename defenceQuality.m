%pnt - рассматриваемая точка
%G - центр ворот
%V - направляющий вектор ворот
%oppCom - информация о роботах противника

function score = defenceQuality(pnt, G, V, oppCom)
    v = 400;            %размер ворот
    R = 130;            %радиус робота
    K = 2.5;            %скорость мяча делённая на скорость робота
    
    oppPos = zeros(numel(oppCom), 2);
    for k = 1: numel(oppCom)
        oppPos(k, 1) = oppCom(k).x;
        oppPos(k, 2) = oppCom(k).y;
    end
    
    nV = [V(2), -V(1)];
    [~, score] = getOptimalDirect(G - nV * v, G + nV * v, pnt, oppPos, R, K);
    %disp(score);
end
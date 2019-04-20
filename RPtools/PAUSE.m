%PAUSE
%Создаёт и отменяет паузу 
%Во время паузы Rule не передаёт данные
global RP Rules outBuffer bufferEmptyPosition;

%% Пересборка управляющей функции
%pcode main.m;
Rules=zeros(size(Rules));
%Смена паузы.
RP.Pause=1-RP.Pause;
if (RP.Pause)
    fprintf('Pause = ON\n');
else
    fprintf('Pause = OFF\n');
end

%% Посылка "Стоп" на всех роботов.
if (RP.Pause==1)
    Rules(1,:)=[2,1,0,0,0,0,0];
    Rules(2,:)=[1,0,0,0,0,0,0];
    Rules(3,:)=[1,0,0,0,0,0,0];
    Rules(4,:)=[1,0,0,0,0,0,0];
%     pause(0.1);
%     Rules(1,:)=[2,1,0,0,0,0,0];
%     Rules(2,:)=[1,0,0,0,0,0,0];
%     Rules(3,:)=[1,0,0,0,0,0,0];
%     Rules(4,:)=[1,0,0,0,0,0,0];
else
    Rules(1,:)=[2,1,0,0,0,0,0];
    %---------------------------------------------------
    outBuffer = zeros(1, 16);
    if (isempty(bufferEmptyPosition))
        bufferEmptyPosition = 1;
    end
    %---------------------------------------------------
end
%% Использование main
RP.zMain_End=true;
main();
%% 
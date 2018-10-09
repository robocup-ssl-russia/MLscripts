clear all
close all
clc
%% Инициализация
Modul_INI();
%% Цикл
while(Modul.T+Modul.dT<=Modul.Tend )    
    Rules=zeros(12,7);
    Modul.N=Modul.N+1;
    Modul.T=Modul.T+Modul.dT;    
    %% Внесение погрешности
    if norm(Modul.MapError)>0
        Modul.Save.Yellows=Yellows;
        Modul.Save.Blues=Blues;
        Modul.Save.Balls=Balls;    
        Yellows=Modul.Save.Yellows+randn(size(Yellows)).*repmat(Modul.MapError,size(Yellows(:,1)));
        Blues=Modul.Save.Blues+randn(size(Blues)).*repmat(Modul.MapError,size(Blues(:,1)));
        Balls=Modul.Save.Balls+randn(size(Balls)).*Modul.MapError(1:3);
    end
    %% MAIN ---------------------------------------------------------------
    main
        %main   %Основной скрипт, управляющий роботами
    %======================================================================
    %% Внесение погрешности
    if norm(Modul.MapError)>0
        Yellows=Modul.Save.Yellows;
        Blues=Modul.Save.Blues;
        Balls=Modul.Save.Balls;    
    end
    %% Инициализация карты
    if (Modul.N==1)  
        MAP_INI        
%        PairStart();
    end
%    if (RP.pair.N==13)
%        RP.Pause=false;
%    end
%    Rules
    %% Задержка
    Rules_Delay_S=Rules;
    if (Modul.Delay>0)
        Rules=Modul.Rules_Delay{1};
        for i=1:Modul.Delay-1
            Modul.Rules_Delay{i}=Modul.Rules_Delay{i+1};        
        end
        Modul.Rules_Delay{Modul.Delay}=Rules_Delay_S;
    end    
    
    floor(Modul.dT/Modul.Delay)

    
    Modul.Rules_Delay{ceil(Modul.Delay/Modul.dT)}=Rules;     
    %Rules_Delay_S=Rules;
    %Rules=Modul.Rules_Delay{1};

    if (rem(Modul.Delay,Modul.dT)>0)
        MOD(rem(Modul.Delay,Modul.dT)); 
    end
    
    Rules=Modul.Rules_Delay{1};
    for i=1:ceil(Modul.Delay/Modul.dT)-1
        Modul.Rules_Delay{i}=Modul.Rules_Delay{i+1};        
    end
    %Modul.Rules_Delay{floor(Modul.Delay/Modul.dT)}=Rules_Delay_S;
    
    %% Передача управления роботу
    % пример: MOD_NGO(9,3,'Y'); (Для реализаций Rule в обход RP)
    % 9 - номер цвета робота, 3 - номер управления робота, Y - из жёлиых. 
    MOD_Agents();
%    MOD_NGO(12,4,'Y');
%     MOD_NGO(10,2,'B',1,-pi/2);
%    SAVE_rip();
%--------------------------------------------
    kick=Rules(1,5)||Rules(2,5)||Rules(3,5);
    if (kick~=0)
        %Tend=T%+5*dT;
    end
%% --------MOD_BALL-----------    
    MOD_Ball();
%%---------DOP------------------------------------------------------------- 
%     if (abs(Blues(7,4)-pi/2)<0.01)        
%         Blues(7,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%     end
%     if (abs(Blues(8,4)+pi/2)<0.01)        
%         Blues(8,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%     end
end
%SAVE_map;
%SAVE_load();
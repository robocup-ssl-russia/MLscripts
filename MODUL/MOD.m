%MOD(T)
%Запуск моделирования на время T
%Выполняет Modul_INI(); для подготовки
%Затем в цикле:     MOD_All; Rules=zeros(size(Rules)); main;
function MOD(T)
Modul_INI();
global Modul
if (nargin==1) 
    Modul.Tend=Modul.T+T;
end
while(Modul.T<Modul.Tend )    
    %% Инициализация карты
    Modul.N=Modul.N+1;
    MOD_All;
    Rules=zeros(size(Rules));
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
    main %Основной скрипт, управляющий роботами
    %======================================================================
    %% Внесение погрешности
    if norm(Modul.MapError)>0
        Yellows=Modul.Save.Yellows;
        Blues=Modul.Save.Blues;
        Balls=Modul.Save.Balls;    
    end
end
fprintf('MOD is END, T=%4.2f\n',Modul.T);

end


function INIPosition()
% Инициализация начальных позиций
% [1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]]
global Blues Yellows Balls
PAR=get_PAR();
Balls=zeros(1,3);
Blues=zeros(12,4);
Yellows=zeros(12,4);
%% ==============================================
Balls(:)=[1,0,0];

%Blues(1,:)=[1,0,0,0];

%%Blues(1,:)=randposition();
for i=1:5
    Blues(i,:)=randposition();
    Yellows(i,:)=randposition();
end

save lastINIPosition.mat
fprintf('Начальные позиции агентов:\n');
Blues
Yellows
    function re=randposition()        
        re=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
        while(~CollisionControl())
            re=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];            
        end
    end
end
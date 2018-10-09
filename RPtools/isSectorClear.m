%re=isSectorClear(X,B,Opponents,Bang,L) 
%re=isSectorClear(X,B,Opponents,Bang) L=0;
%re=isSectorClear(X,B,Opponents) Bang=angV(B-X); L=200;

% Функция проверяет, попадают ли агенты из массива Opponents в сектор 
% захода на мячь перед агентом X. L - размер робота, который можно указать
% в качестве дополнительной толщины сектора.
function [re,cor]=isSectorClear(X,B,Opponents,Bang,L,ML)
%% Полиморфизм
cor=[];
if (nargin==4)
    L=0;
end
global PAR
if (nargin==3)    
    L=PAR.RobotSize;
    Bang=angV(B-X);
end
if (nargin<6)
    ML=L;
end
if size(Opponents,2)==4
    Opponents=Opponents(Opponents(:,1)>0,2:3);
end    
%% Иллюстрация
% if (get(0,'CurrentFigure')==200)
%     clf;
%     subplot(1,2,1);
%     plot(Opponents(:,1),Opponents(:,2),'.');
%     hold on
%     plot(X(1),X(2),'R*');
%     plot(B(1),B(2),'Go');
%     plot(B(1)-1000*cos(Bang)*[0,1],B(2)-1000*sin(Bang)*[0,1],'R');
% end
 
X=X-B; 
T=[cos(Bang),sin(Bang);-sin(Bang),cos(Bang)];
X=(T*[X(1);X(2)])';

% if (get(0,'CurrentFigure')==200)
%     subplot(1,2,2)
%     plot(X(1),X(2),'R*');
%     hold on    
%     plot([X(1)-L,X(1)-L,0,X(1)+L],[X(2)+L*(1-2*(X(2)<0)),-L,-L,X(2)+L*(1-2*(X(2)<0))],'R')
% end

MysteryValue=150;

if( (X(1)>0) || ( abs(angV(-X+[MysteryValue,0]))>pi/6))
    re=0;
    return
end

for i=1:size(Opponents,1)
    C=Opponents(i,:);
    C=C-B;
    C=(T*[C(1);C(2)])';
    if (norm(X-C)~=0)
        
    if X(2)<0
        C(2)=-C(2);
    end
%      if (get(0,'CurrentFigure')==200)
%         subplot(1,2,2)
%         plot(C(:,1),C(:,2),'.')
%         if (i==size(Opponents,1))
%             hold off;
%         else 
%             hold on
%         end
%      end
    if (C(2)>-L) && (C(1)<0)&& (C(1)>X(1)-ML) && C(2)<(L-C(1)*abs(X(2))/abs(X(1)))*norm(X)/abs(X(1))... 
       && (C(1)>X(1) || ((C(2)>0 && C(2)<abs(X(2)))|| norm(C-[X(1),0])<L || norm(C-[X(1),abs(X(2))])<L))  
%        && ((C(2)-L)*-X(1)<(-C(1)+L)*abs(X(2))))
        cor=Opponents(i,:);
        re=0;
        return
    end
    end
end
re=1;
end
%[Left,Right] = ReactAvoidance([X,Xang],[Left,Right],Opponent)
%rul = ReactAvoidance(agent,rul,Opponent)
%rul = ReactAvoidance(agent,Opponent)
% Реактивное обхождение препятствий
% Вносит в угловую скорость отклонение от препятствий
% Только для V>=0
function [Left,Right] = ReactAvoidance(agent,rul,Opponent)
%% Локальные параметры
global PAR;
RobotSize=PAR.RobotSize;
len0=PAR.RobotSize;
len1=500;
%% Полиморфизм
if (nargin==2)
    Opponent=rul;
    rul=agent.rul;
end
if isstruct(agent)
    X=agent.z;
    Xang=agent.ang;
else
    if (size(agent,1)~=1) || (size(agent,2)<3)
        error('Need agent is struct,[x,y,ang] or [I,x,y,ang]');
    end
    if (size(agent,2)>3) 
        agent=agent(2:4);
    end
    X=agent(1:2);
    Xang=agent(3);    
end
if isstruct(rul)
    Left=rul.left;
    Right=rul.right;
else
    if (size(rul,1)~=1) || (size(rul,2)~=2)
        error('Need rul is struct or [Left,Right]');
    end    
    Left=rul(1);
    Right=rul(2);
end
if size(Opponent,2)==4    
    Opponent=Opponent(Opponent(:,1)>0,2:3);    
end    
Opponent=Opponent(or(Opponent(:,1)~=X(1),Opponent(:,2)~=X(2)),:);

%% Pars
Ubreal=(Right-Left)/200;
Vreal=(Right+Left)/200;
length=RobotSize+0*len0+Vreal*len1;
if (Vreal<0)
    [Right,Left] = ReactAvoidance([X,Xang+pi],[-Right,-Left],Opponent);    
    Right=-Right; Left=-Left; 
    if ~isempty(rul)  
        rul=Crul(Left,Right,rul.kick,0,0);
        Left=rul;
        Right=[];
    end
    return;
end
%% Alg 
% Поиск направления с свободным сектором.
CangK=0.7;
Cang=Ubreal*pi*CangK;
dang=0;

%[~,cor]=isSectorClear(X,X+length*[cos(Xang),sin(Xang)],Opponent,Xang,RobotSize+len0);
%re=isSectorClear(X,X+length*[cos(Xang+Cang),sin(Xang+Cang)],Opponent,Xang+Cang,RobotSize+len0);
[range0,rangeL,~,reNorm]=CollisionRange([X,Xang],Opponent,length,RobotSize);
range1=CollisionRange([X,Xang+Cang],Opponent,length,RobotSize);
re=(range1>RobotSize+len0);
% testshow=0;
% if testshow
%      figure(858)
%      clf
%     plot(X(1),X(2),'Ro');
%     hold on
%     plot(Opponent(:,1),Opponent(:,2),'Bo');
%     if re
%         plot(X(1)+[0,length*cos(Xang+Cang)],X(2)+[0,length*sin(Xang+Cang)],'G');
%     else
%         plot(X(1)+[0,length*cos(Xang+Cang)],X(2)+[0,length*sin(Xang+Cang)],'R');
%     end
% end
while (abs(dang)<pi && re==0)
    dang=-sign(dang)*(abs(dang)+pi/180) + pi/360*(dang==0);
    range=CollisionRange([X,Xang+Cang+dang],Opponent,length,RobotSize);
    re=(range>RobotSize+len0);
% if testshow
%     if re
%         plot(X(1)+[0,length*cos(Xang+Cang+dang)],X(2)+[0,length*sin(Xang+Cang+dang)],'G');
%     else
%         plot(X(1)+[0,length*cos(Xang+Cang+dang)],X(2)+[0,length*sin(Xang+Cang+dang)],'R');
%     end
% end
end
if (re==0)
    dang=0;
end
% global test
%     figure(100)
% if ~isfield(test,'h1') || ~ishandle(test.h1)
%     test.h1=plot(X(1)+[0,length*cos(Xang+Cang+dang)],X(2)+[0,length*sin(Xang+Cang+dang)],'B');
%     test.h2=plot(X(1)+[0,length*cos(Xang+Cang)],X(2)+[0,length*sin(Xang+Cang)],'R');
% else
%     set(test.h1,'xdata',X(1)+[0,length*cos(Xang+Cang+dang)],'ydata',X(2)+[0,length*sin(Xang+Cang+dang)]);
%     set(test.h2,'xdata',X(1)+[0,length*cos(Xang+Cang)],'ydata',X(2)+[0,length*sin(Xang+Cang)]);
% end
% [re,cor]=isSectorClear(X,X+length*[cos(Xang),sin(Xang)],Opponent,Xang,RobotsizeX2,0);
% 
% while (abs(dang)<pi && re==0)
%     if (abs(Ubreal)<=0.1)
%         dang=-sign(dang)*(abs(dang)+pi/180) + pi/360*(dang==0);
%     else
%         dang=dang+azi(sign(Ubreal)*pi/360);        
%     end
%     re=isSectorClear(X,X+length*[cos(Xang+dang),sin(Xang+dang)],Opponent,Xang+dang,RobotsizeX2,0);    
% end

%Vreal=Vreal+max(0,abs(Ubreal)-0.8);
Ub=azi(Cang+dang)/pi/CangK;
Vneed=1-abs(Ub);
%MAP_addtext(dang);

if (range0<RobotSize+len0)
%    len2=len0*max(0,[cos(Xang),sin(Xang)]*(X-opp1)'/norm(X-opp1));
    len2=len0*min(1,max(0,rangeL/reNorm));
%    MAP_addtext(len2,'Len2=%f');
    Vmax=min(1,max(-1,(reNorm-(RobotSize+len2))/(RobotSize+len2)));        
%    MAP_addtext(Vmax,'Vmax=%f');
    Vneed=min(Vneed,Vmax);
%    if (Vneed<0)
        %Ub=-Ub;
%    end
    if (Vneed<-1+abs(Ub))
        %Ub=-Ub;
        Vneed=-1+abs(Ub);
    end    
end
V=min(Vneed,Vreal);

%MAP_addtext(V);
if (reNorm<RobotSize)
    V=V*sign(rangeL);
end
%% Переход к колесам
Left=100*(V-Ub);
Right=100*(V+Ub);
%% Debug
%fprintf('REACT AVOIDANCE cor=%d Vneed=%d V=%d\n',cor,Vneed,V)
%fprintf('ReacAvoidance: Vreal=%4.2f,Ubreal=%4.2f,V=%4.2f,Ub=%4.2f\n',Vreal,Ubreal,Vneed,Ub);
%if ~isempty(cor)
%fprintf(' %4.2f\n',norm(cor-X))
%end
%% graph
% global map_test_react;
% if (get(0,'CurrentFigure')==100)
% if isempty(map_test_react) || ~ishandle(map_test_react)
%     map_test_react=plot(X(1)+length*[0,cos(Xang+dang)],X(2)+length*[0,sin(Xang+dang)],'R');
% else
%     set(map_test_react,'xdata',X(1)+length*[0,cos(Xang+dang)],'ydata',X(2)+length*[0,sin(Xang+dang)]);     
% end
% end
  
if isstruct(agent)
    if isstruct(rul)        
        rul.left=Left;
        rul.right=Right;
    else
        rul=Crul(Left,Right,rul.kick,0,0);
    end
    Left=rul;
    Right=[];
end
end


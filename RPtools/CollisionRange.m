function [range,rangeL,opp,reNorm]=CollisionRange(agent,Opponents,maxlength,RobotSize)
opp=[];
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
if size(Opponents,2)>=3
    Opponents=Opponents(Opponents(:,1)>0,2:3);
end 
if isempty(Opponents)
    range=inf;
    rangeL=inf;
    reNorm=inf;
    return
end
Opponents_old=Opponents;
Opponents=Opponents-ones(size(Opponents,1),1)*X;
RotM=[cos(Xang),-sin(Xang);sin(Xang),cos(Xang)];
Opponents=Opponents*RotM;
NORM=sqrt(Opponents(:,1).^2+Opponents(:,2).^2);
NORMrange=NORM;
NORMrange(NORM>RobotSize)=inf;
LINErange=abs(Opponents(:,2));
LINErange(Opponents(:,1)>maxlength)=inf;
LINErange(Opponents(:,1)<0)=inf;
LINErange(NORM>maxlength)=inf;
[range,I]=min([NORMrange;LINErange]);
I(I>size(Opponents,1))=I-size(Opponents,1);
rangeL=Opponents(I,1);
reNorm=NORM(I);
opp=Opponents_old(I,:);
range(isempty(range))=inf;
rangeL(isempty(rangeL))=inf;
reNorm(isempty(reNorm))=inf;

end


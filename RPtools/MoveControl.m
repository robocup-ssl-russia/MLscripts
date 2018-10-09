function rul = MoveControl(agent,rul)
K=1/3;
M=20;    
max=50;
if (nargin<2)
    rul=agent.rul;
end
if (agent.I==0)
    rul=Crul(0,0,0,1,0);
    return;
end
id=agent.id;
Left=agent.v-agent.u*100;
Right=agent.v+agent.u*100;

global movecontroldata
if (~isempty(movecontroldata) && isfield(movecontroldata,'S') && size(movecontroldata.S,1)>=id)
    SLeft=movecontroldata.S(id,1);
    SRight=movecontroldata.S(id,2);
else
    SLeft=0;
    SRight=0;
end

SLeft=SLeft+rul.left;
SRight=SRight+rul.right;

SLeft(sign(SLeft)==sign(Left))=SLeft-sign(SLeft)*min(abs(Left)*K,abs(SLeft));
SRight(sign(SRight)==sign(Right))=SRight-sign(SRight)*min(abs(Right)*K,abs(SRight));


SLeft(rul.right==0)=0;
SRight(rul.left==0)=0;

SLeft=SLeft-1*sign(SLeft);
SRight=SRight-1*sign(SRight);

SLeft(abs(SLeft)>max*M)=sign(SLeft)*max*M;
SRight(abs(SRight)>max*M)=sign(SRight)*max*M;

rul.left=rul.left+SLeft/M;
rul.right=rul.right+SRight/M;

rul.left(abs(rul.left)>100)=sign(rul.left)*100;
rul.right(abs(rul.right)>100)=sign(rul.right)*100;

movecontroldata.S(id,1:2)=[SLeft,SRight];

% if (~isfield(movecontroldata,'save_data') || ~isfield(movecontroldata,'h'))   
%     movecontroldata.showid=id;
%     movecontroldata.save_data=[Right,Left,SLeft,SRight];
%     figure(113)
%     title('movecontroldata');
%     clf
%     subplot(2,1,1);
%     movecontroldata.h(1)=plot(1,movecontroldata.save_data(1),'B');
%     hold on
%     movecontroldata.h(2)=plot(1,movecontroldata.save_data(2),'R--');
%     subplot(2,1,2);
%     movecontroldata.h(3)=plot(1,movecontroldata.save_data(3),'B');
%     hold on
%     movecontroldata.h(4)=plot(1,movecontroldata.save_data(4),'R--');
% else
%     if (id==movecontroldata.showid)
%         sz=size(movecontroldata.save_data,1)+1;
%         movecontroldata.save_data(sz,:)=[Right,Left,SLeft,SRight];
%         set(movecontroldata.h(1),'xdata',1:sz,'ydata',movecontroldata.save_data(:,1));
%         set(movecontroldata.h(2),'xdata',1:sz,'ydata',movecontroldata.save_data(:,2));    
%         set(movecontroldata.h(3),'xdata',1:sz,'ydata',movecontroldata.save_data(:,3));    
%         set(movecontroldata.h(4),'xdata',1:sz,'ydata',movecontroldata.save_data(:,4));    
%     end
% end



end


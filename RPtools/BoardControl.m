function rul = BoardControl(agent,rul)
global PAR
if isfield(PAR,'HALF_FIELD')
    MOD_HALF_FIELD=PAR.HALF_FIELD;
else
    MOD_HALF_FIELD=0;
end
%%-------------------------------------------
if (nargin<2)
    rul=agent.rul;
end
if (agent.I==0)
    rul=Crul(0,0,0,1,0);
    return;
end
savedist=300;
V=(rul.left+rul.right)/200;
Ub=(rul.right-rul.left)/200;

cdist=sign(V)*savedist;
c=agent.z+cdist*[cos(agent.ang),sin(agent.ang)];

dist=min(PAR.MAP_X/2-abs(agent.z(1)),PAR.MAP_Y/2-abs(agent.z(2)));
if (MOD_HALF_FIELD~=0)
    dist=min(dist,abs(agent.z(1)));
end
cc=min(1,max(0,dist/savedist));
newV=V*cc;

    newUb=azi(angV([MOD_HALF_FIELD*PAR.MAP_X/4,0]-agent.z)-agent.ang)/pi;
    newUb=Ub*cc+(1-cc)*newUb;

if (abs(c(1))>PAR.MAP_X/2 || abs(c(2))>PAR.MAP_Y/2 || c(1)*MOD_HALF_FIELD<0)
    %goAway=(abs(c(2))>PAR.MAP_Y/2);    
    %if newUb>0
    %    newUb=max(newUb,Ub);
    %else
    %    newUb=min(newUb,Ub);
    %end
    rul.left=100*(newV-newUb);
    rul.right=100*(newV+newUb);    
    rul.left(abs(rul.left)>100)=sign(rul.left)*100;
    rul.right(abs(rul.right)>100)=sign(rul.right)*100;

else
    rul.left=100*(V-newUb);
    rul.right=100*(V+newUb);
    rul.left(abs(rul.left)>100)=sign(rul.left)*100;
    rul.right(abs(rul.right)>100)=sign(rul.right)*100;
end
end


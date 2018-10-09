function rePAR=get_PAR()
global PAR
if isempty(PAR)
    warning('PAR IS EMPTY');
    PAR=struct();    
end
if ~isfield(PAR,'HALF_FIELD')
    PAR.HALF_FIELD=0; %0
end
if ~isfield(PAR,'MAP_X')
    PAR.MAP_X=6000; %6000
end
if ~isfield(PAR,'MAP_Y')
    PAR.MAP_Y=4000; %4000
end
if ~isfield(PAR,'KICK_DIST')
    PAR.KICK_DIST=120; %120
end
if ~isfield(PAR,'LGate')
    PAR.LGate.X=-PAR.MAP_X/2;
    PAR.LGate.Y=0;    
    PAR.LGate.ang=0;    
    PAR.LGate.width=1000;
end
if ~isfield(PAR,'RGate')
    PAR.RGate.X=PAR.MAP_X/2;
    PAR.RGate.Y=0;
    PAR.RGate.ang=-pi;    
    PAR.RGate.width=1000;
end
if ~isfield(PAR,'RobotSize')
    PAR.RobotSize=100;
end
if ~isfield(PAR,'RobotArm')
    PAR.RobotArm=100;
end
if ~isfield(PAR,'DELAY')
    PAR.DELAY=0.0;
end
if ~isfield(PAR,'WhellR')
    PAR.WhellR=5;
end
rePAR=PAR;
end
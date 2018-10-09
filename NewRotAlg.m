function rul=NewRotAlg(agent,B,ang)

Ureal=agent.u;
Vreal=agent.v;
z=agent.z;

rotmod=pi/2;

H=agent.y;
R=H/(1+cos(agent.ang));

figure(100)
global newalgsave
if isempty(newalgsave)
    newalgsave.R=plot(NaN,NaN,'R');
end
setPlotData(newalgsave,z(1)+[0,R]*cos(angnt.ang+rotmod)...
                      ,z(2)+[0,R]*sin(angnt.ang+rotmod));
rul=Crul(0,0,0,0,0);
end
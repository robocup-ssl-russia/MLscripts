%—имул€ци€ движени€ агентов по их управлению в структуре RP
global Modul RP Blues Yellows;

if isempty(RP) || isempty(Modul)
    return
end
if (~isfield(Modul,'Rules_Delay') || (size(Modul.Rules_Delay,2)<(floor((Modul.Delay/Modul.dT))+2)))
    for i=1:(floor((Modul.Delay/Modul.dT))+2)
        Modul.Rules_Delay{i}=[];
    end
end

rob_rul=struct();
rob_rul.Blue=RP.Blue;
rob_rul.Yellow=RP.Yellow;

% figure(140)
% hold on;
% plot([Modul.T,Modul.T+Modul.dT],[1,1]*rul.Blue(4).rul.left,'R','LineWidth',3);

if (Modul.Delay>0)
    Modul.Rules_Delay{floor((Modul.Delay/Modul.dT))+2}=rob_rul;
    rob_rul=Modul.Rules_Delay{1};
    dt1=rem(Modul.Delay,Modul.dT);
    if (dt1>0 && ~isempty(rob_rul))
        %% rul    
        for N=1:size(RP.Blue,2)
            if Blues(N,1)
                Blues(N,:)=[Blues(N,1),MOD_GO(Blues(N,2:3),Blues(N,4),[rob_rul.Blue(N).rul.left,rob_rul.Blue(N).rul.right],dt1)];
                Modul.BluesKick(N,:)=[rob_rul.Blue(N).rul.kick,Blues(N,4)+rob_rul.Blue(N).KickAng];
            end
        end

        for N=1:size(RP.Yellow,2)
            if Yellows(N,1)
                Yellows(N,:)=[Yellows(N,1),MOD_GO(Yellows(N,2:3),Yellows(N,4),[rob_rul.Yellow(N).rul.left,rob_rul.Yellow(N).rul.right],dt1)];
                Modul.YellowsKick(N,:)=[rob_rul.Yellow(N).rul.kick,Yellows(N,4)+rob_rul.Yellow(N).KickAng];
            end
        end
        
%         figure(140)
%         plot([Modul.T,Modul.T+dt1],[1,1]*rul.Blue(4).rul.left,'B');

    end
    for i=1:(floor((Modul.Delay/Modul.dT))+1)
        Modul.Rules_Delay{i}=Modul.Rules_Delay{i+1};        
    end
    rob_rul=Modul.Rules_Delay{1};
    dt2=Modul.dT-dt1;
else
    dt1=0;
    dt2=Modul.dT;
end

if (dt2>0 && ~isempty(rob_rul))
%% rul
    for N=1:size(RP.Blue,2)
        if Blues(N,1)
            Blues(N,:)=[Blues(N,1),MOD_GO(Blues(N,2:3),Blues(N,4),[rob_rul.Blue(N).rul.left,rob_rul.Blue(N).rul.right],dt2)];
            Modul.BluesKick(N,:)=[rob_rul.Blue(N).rul.kick,Blues(N,4)+rob_rul.Blue(N).KickAng];
        end
    end
    for N=1:size(RP.Yellow,2)
        if Yellows(N,1)
            Yellows(N,:)=[Yellows(N,1),MOD_GO(Yellows(N,2:3),Yellows(N,4),[rob_rul.Yellow(N).rul.left,rob_rul.Yellow(N).rul.right],dt2)];
            Modul.YellowsKick(N,:)=[rob_rul.Yellow(N).rul.kick,Yellows(N,4)+rob_rul.Yellow(N).KickAng];
        end
    end
%     figure(140)
%     plot([Modul.T+dt1,Modul.T+dt1+dt2],[1,1]*rul.Blue(4).rul.left,'B');

end
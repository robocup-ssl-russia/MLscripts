global RP Blues Yellows Balls Rules
%% -----------------------------------------
Stady=3;
global DiagnosticShow
if isempty(DiagnosticShow)
    DiagnosticShow=false;
end

DiagnosticShow=true;

agent=RP.Yellow(12);
Nrul=1;
% if (agent.I==0)
%     return
% end
global TEST_viz

if (Stady==1)
    CamData=agent.z;
    ang=agent.ang;
    
    if isempty(TEST_viz)
        TEST_viz.Save=CamData;
        TEST_viz.Save2=ang;
        
        if (DiagnosticShow)
            figure(30)
            clf
            subplot(1,2,1);
            TEST_viz.h1=plot(CamData(1),CamData(2),'B.');    
            hold on
            TEST_viz.h2=plot(CamData(1),CamData(2),'R*');    
            TEST_viz.h3=plot(CamData(1),CamData(2),'Go');   
            subplot(1,2,2);            
            plot(sin(-pi:0.1:pi),cos(-pi:0.1:pi),'Y');
            hold on
            TEST_viz.h4=plot(cos(ang),sin(ang),'B.');    
            TEST_viz.h5=plot(cos(ang),sin(ang),'R*');    
            TEST_viz.h6=plot(cos(ang),sin(ang),'Go');    
        end
    else
        N=size(TEST_viz.Save,1)+1;
        TEST_viz.Save(N,:)=CamData;    
        TEST_viz.Save2(N,:)=ang;            
        if DiagnosticShow
            set(TEST_viz.h1,'xdata',TEST_viz.Save(:,1),'ydata',TEST_viz.Save(:,2));
            set(TEST_viz.h2,'xdata',sum(TEST_viz.Save(:,1))/N,'ydata',sum(TEST_viz.Save(:,2))/N);    
            set(TEST_viz.h3,'xdata',CamData(1),'ydata',CamData(2));

            set(TEST_viz.h4,'xdata',cos(TEST_viz.Save2(:)),'ydata',sin(TEST_viz.Save2(:)));
            set(TEST_viz.h5,'xdata',cos(sum(TEST_viz.Save2(:))/N),'ydata',sin(sum(TEST_viz.Save2(:))/N));    
            set(TEST_viz.h6,'xdata',cos(ang),'ydata',sin(ang));
        end
        Dr2=sum((TEST_viz.Save(:,1)-sum(TEST_viz.Save(:,1))/N).^2+(TEST_viz.Save(:,2)-sum(TEST_viz.Save(:,2))/N).^2)/N;
        Da2=sum((TEST_viz.Save2(:)-sum(TEST_viz.Save2(:))/N).^2)/N;
    if DiagnosticShow
        fprintf('Среднеквадратическое отклонение координат=%4.2fмм\n',sqrt(Dr2));
        fprintf('Среднеквадратическое отклонение угла=%4.4fрад (%4.2fградусов)\n',sqrt(Da2),sqrt(Da2)/pi*180);    
    end
    end
    
    Rule(Nrul,0,0,0,0,0);
end

global Diagnostic_data;
if (Stady==2)
    K=-0.035;
    delay=0.3;
    if RP.T<2.5
        USpeed=0;      
    else
        USpeed=100*sin(RP.T*pi);
    end
        Rule(Nrul,USpeed,-USpeed,0,0,0);
    
    AngSpeed=[USpeed;agent.u;RP.T];
    
    if ~isfield(Diagnostic_data,'AngSpeed') || isempty(Diagnostic_data.AngSpeed)
        Diagnostic_data.AngSpeed=AngSpeed;
    else
        Diagnostic_data.AngSpeed(:,size(Diagnostic_data.AngSpeed,2)+1)=AngSpeed;
    end    
    AngSpeed=Diagnostic_data.AngSpeed;
    
    if ~isfield(Diagnostic_data,'AngSpeed_H') || isempty(Diagnostic_data.AngSpeed_H)
        figure(31);     
        clf; 
        Diagnostic_data.AngSpeed_H(1)=plot(0,0,'G'); hold on; 
        Diagnostic_data.AngSpeed_H(2)=plot(0,0,'B');
        Diagnostic_data.AngSpeed_H(3)=plot(0,0,'R');     
    else
        filt=[filter(ones(1,11)/11,1,AngSpeed(2,:)),AngSpeed(2,end)*ones(1,5)];
        filtT=[zeros(1,5),AngSpeed(3,:)];
        if DiagnosticShow    
            set(Diagnostic_data.AngSpeed_H(1),'xdata',AngSpeed(3,:),'ydata', AngSpeed(2,:)); 
            set(Diagnostic_data.AngSpeed_H(2),'xdata',filtT,'ydata',filt);
            set(Diagnostic_data.AngSpeed_H(3),'xdata',AngSpeed(3,:)+delay,'ydata',AngSpeed(1,:)*K);     
        end
    end
end

if (Stady==3)
    K=5.0;
    delay=0.3;
    if RP.T<2.5
        USpeed=0;      
    else
        USpeed=100*sin(RP.T*pi);
    end
        Rule(Nrul,USpeed,USpeed,0,0,0);
    
    VSpeed=[USpeed;agent.v;RP.T];
    
    if ~isfield(Diagnostic_data,'VSpeed') || isempty(Diagnostic_data.VSpeed)
        Diagnostic_data.VSpeed=VSpeed;
    else
        Diagnostic_data.VSpeed(:,size(Diagnostic_data.VSpeed,2)+1)=VSpeed;
    end    
    VSpeed=Diagnostic_data.VSpeed;
    
    if ~isfield(Diagnostic_data,'VSpeed_H') || isempty(Diagnostic_data.VSpeed_H)
        figure(31);     
        clf; 
        Diagnostic_data.VSpeed_H(1)=plot(0,0,'G'); hold on; 
        Diagnostic_data.VSpeed_H(2)=plot(0,0,'B');
        Diagnostic_data.VSpeed_H(3)=plot(0,0,'R');     
    else
        filt=[filter(ones(1,11)/11,1,VSpeed(2,:)),VSpeed(2,end)*ones(1,5)];
        filtT=[zeros(1,5),VSpeed(3,:)];
        if DiagnosticShow    
            set(Diagnostic_data.VSpeed_H(1),'xdata',VSpeed(3,:),'ydata', VSpeed(2,:)); 
            set(Diagnostic_data.VSpeed_H(2),'xdata',filtT,'ydata',filt);
            set(Diagnostic_data.VSpeed_H(3),'xdata',VSpeed(3,:)+delay,'ydata',VSpeed(1,:)*K);     
        end
    end
end

if (Stady==4)
    if (agent.I)
    K=4.5;
    delay=0.18;
    Rule(Nrul,100,0,0,0,0);
        
    Position=[agent.x,agent.y];
    N=1;
    if ~isfield(Diagnostic_data,'MPosition') || isempty(Diagnostic_data.MPosition)
        Diagnostic_data.MPosition=Position;
    else
        N=size(Diagnostic_data.MPosition,1)+1;
        Diagnostic_data.MPosition(N,:)=Position;
    end
    MPosition=Diagnostic_data.MPosition;
    
    if ~isfield(Diagnostic_data,'MPosition_H') || isempty(Diagnostic_data.MPosition_H)
        figure(31);     
        clf; 
        Diagnostic_data.MPosition_H(1)=plot(0,0,'B.'); hold on; 
        Diagnostic_data.MPosition_H(2)=plot(0,0,'R*');
        Diagnostic_data.MPosition_H(3)=plot(0,0,'Go');     
    else
%        filt=[filter(ones(1,11)/11,1,VSpeed(2,:)),VSpeed(2,end)*ones(1,5)];
%        filtT=[zeros(1,5),VSpeed(3,:)];
        if DiagnosticShow    
            set(Diagnostic_data.MPosition_H(1),'xdata',MPosition(:,1),'ydata',MPosition(:,2)); 
            set(Diagnostic_data.MPosition_H(2),'xdata',sum(MPosition(:,1))/N,'ydata',sum(MPosition(:,2))/N);
            set(Diagnostic_data.MPosition_H(3),'xdata',MPosition(end,1),'ydata',MPosition(end,2));     
            C=[sum(MPosition(:,1))/N,sum(MPosition(:,2))/N];
            R=sum(sqrt(((MPosition(:,1)-C(1)).^2+(MPosition(:,2)-C(2)).^2)))/N;
            s=sprintf('B=%4.0f',2*R);
            title(s);
        end
    end
    end
end

%agent=RP.Yellow(12);
%oagent=extrap(agent,0);
%Blues(12,2:3)=oagent.z;
%Blues(12,4)=oagent.ang;
% global TEST2
% if isempty(TEST2)
%     TEST2.D0=norm(Yellows(12,2:3));
%     TEST2.OLD=Yellows(12,2:3);
%     TEST2.V=0;
%     TEST2.FV=TEST2.V;
%     TEST2.VR=0;
%     TEST2.YS=0;
%     TEST2.T=RP.T;
%     figure(333);
%     clf
%     TEST2.H2=plot(0,0);
%     hold on
%     TEST2.H3=plot(0,0,'R','LineWidth',2);
%     TEST2.H4=plot(0,0,'G','LineWidth',1);
%     TEST2.H5=plot(0,0,'Y','LineWidth',2);
% else
%     TEST2.VR=[TEST2.VR;RP.Yellow(12).v];
%     TEST2.V=[TEST2.V;norm(Yellows(12,2:3)-TEST2.OLD)/RP.dT];
%     TEST2.FV=[TEST2.FV;(TEST2.V(end)+TEST2.FV(max(1,end))+2*TEST2.FV(max(1,end-1)))/4];
%     TEST2.YS=[TEST2.YS;RP.YellowsSpeed(12)];
%     TEST2.OLD=Yellows(12,2:3);
%     TEST2.D0=[TEST2.D0;norm(Yellows(12,2:3))];
%     TEST2.T=[TEST2.T;RP.T];
%     set(TEST2.H2,'xdata',TEST2.T,'ydata',min(TEST2.V,1000));
%     set(TEST2.H3,'xdata',TEST2.T,'ydata',abs(TEST2.VR));
%     set(TEST2.H4,'xdata',TEST2.T,'ydata',min(1000,TEST2.FV));
%     set(TEST2.H5,'xdata',TEST2.T,'ydata',abs(TEST2.YS));
% end
% oBall=extrap(RP.Ball,100);
% Yellows(12,2:3)=oBall.z;
% Yellows(12,4)=oBall.ang-pi;
% Yellows(12,1)=1;


%  global TEST
% if RP.Ball.I
% if isempty(TEST)
%     TEST.Ballz=RP.Ball.z;
%     TEST.Ballv=RP.Ball.v;
%     TEST.BallFV=RP.Ball.v;
%     TEST.Ballu=RP.Yellow(6).u;
%     TEST.Balla=0;    
%     TEST.T=RP.T;
%     figure(554);
%     clf
%     subplot(2,1,1);
%     TEST.h1=plot(TEST.T,TEST.Ballv);
%     hold on
%     TEST.h3=plot(TEST.T,TEST.Ballv,'r','lineWidth',2);
%     subplot(2,1,2);
%     TEST.h2=plot(TEST.T,TEST.Balla);
% else
%     TEST.T=[TEST.T;RP.T];
%     TEST.BallFV=[TEST.BallFV;(TEST.BallFV(max(1,end-1))+2*TEST.BallFV(max(1,end-2))+RP.Ball.v)/4];
%     TEST.Ballz=[TEST.Ballz;RP.Ball.z];
%     TEST.Ballv=[TEST.Ballv;RP.Ball.v];
%     TEST.Balla=[TEST.Balla,(TEST.Ballv(end-1)-TEST.Ballv(end))/RP.dT];        
%     TEST.Ballu=[TEST.Ballu,RP.Yellow(6).u];
%     
%     set(TEST.h1,'xdata',TEST.T','ydata',TEST.Ballv);
%     set(TEST.h2,'xdata',TEST.T,'ydata',TEST.Balla);    
%     set(TEST.h3,'xdata',TEST.T,'ydata',TEST.BallFV);    
% end
% end




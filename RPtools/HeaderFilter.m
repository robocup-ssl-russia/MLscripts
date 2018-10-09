global RP
if ~isfield(RP,'Filt')
    RP.Filt.FiltBluesSpeed{1}=0;
    RP.Filt.FiltBluesSpeed{2}=0;
    RP.Filt.FiltBluesAng{1}=0;
    RP.Filt.FiltBluesAng{2}=0;
    RP.Filt.FiltYellowsSpeed{1}=0;
    RP.Filt.FiltYellowsSpeed{2}=0;
    RP.Filt.FiltYellowsAng{1}=0;
    RP.Filt.FiltYellowsAng{2}=0;    
    RP.Filt.BallSpeed{1}=0;
    RP.Filt.BallSpeed{2}=0;    
    RP.Filt.BallAng{1}=0;
    RP.Filt.BallAng{2}=0;    
end
%‘ильтр м€ча
RP.BallsSpeed=(RP.BallsSpeed+RP.Filt.BallSpeed{1}+2*RP.Filt.BallSpeed{2})/4;
RP.Ballsang=RP.Ballsang+(azi(RP.Filt.BallAng{1}-RP.Ballsang)+2*azi(RP.Filt.BallAng{2}-RP.Ballsang))/4;

RP.Filt.BallAng{2}=RP.Filt.BallAng{1};    
RP.Filt.BallAng{1}=RP.Ballsang;
RP.Filt.BallSpeed{2}=RP.Filt.BallSpeed{1};
RP.Filt.BallSpeed{1}=RP.BallsSpeed;    
%‘ильтр игроков
RP.BluesSpeed=(RP.BluesSpeed+RP.Filt.FiltBluesSpeed{1}+2*RP.Filt.FiltBluesSpeed{2})/4;
RP.BluesAngSpeed=(RP.BluesAngSpeed+RP.Filt.FiltBluesAng{1}+2*RP.Filt.FiltBluesAng{2})/4;
RP.YellowsSpeed=(RP.YellowsSpeed+RP.Filt.FiltYellowsSpeed{1}+2*RP.Filt.FiltYellowsSpeed{2})/4;
RP.YellowsAngSpeed=(RP.YellowsAngSpeed+RP.Filt.FiltYellowsAng{1}+2*RP.Filt.FiltYellowsAng{2})/4;

    RP.Filt.FiltBluesSpeed{1}=RP.BluesSpeed;
    RP.Filt.FiltBluesSpeed{2}=RP.Filt.FiltBluesSpeed{1};
    RP.Filt.FiltBluesAng{1}=RP.BluesAngSpeed;
    RP.Filt.FiltBluesAng{2}=RP.Filt.FiltBluesAng{1};
    RP.Filt.FiltYellowsSpeed{1}=RP.YellowsSpeed;
    RP.Filt.FiltYellowsSpeed{2}=RP.Filt.FiltYellowsSpeed{1};
    RP.Filt.FiltYellowsAng{1}=RP.YellowsAngSpeed;
    RP.Filt.FiltYellowsAng{2}=RP.Filt.FiltYellowsAng{1};    

%[x,y,ang]=extrap(x,y,ang,v,u,T)
%Ёкстрапол€ци€ координат динамического объекта
function [re_x,re_y,re_ang]=extrap(x,y,ang,v,u,dt)
fi=sign(u.*dt).*mod(abs(u.*dt),2*pi);
    Ln=1.4142.*sign(dt).*v./abs(u).*sqrt(1-cos(fi));
    re_x=x+Ln.*cos(ang+fi/2);
    re_y=y+Ln.*sin(ang+fi/2);  
    xl=(x+v.*dt.*cos(ang)).*ones(size(re_x));
    yl=(y+v.*dt.*sin(ang)).*ones(size(re_y));
    inline=abs(u*ones(size(re_x)))<0.001;
    re_x(inline)=xl(inline);
    re_y(inline)=yl(inline);    
re_ang=azi(ang+fi);    
end
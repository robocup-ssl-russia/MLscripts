%re=MOD_GO(X,Xang,Rul)
%re=[X(1),X(2),Xang] 
%Моделирование движения робота
function re=MOD_GO(X,Xang,Rul,dT)
global Modul;
if isempty(Modul)
    error('Modul is empty.')
end
if (nargin==3)    
    dT=Modul.dT;
end
%% Инициализация параметров
l=Modul.l_wheel;
if (l==0)
    warning('l=0! a non-rotatable model?');
    l=inf;
end
%% Переход к скоростям
Left=Rul(1)*Modul.vSpeed;
Right=Rul(2)*Modul.vSpeed;
U=(Right-Left)/(2*l);
V=(Left+Right)/2;
[re(1),re(2),re(3)]=extrap(X(1),X(2),Xang,V,U,dT);
end


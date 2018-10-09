%angV = angV(z); z=[x,y];
%angV = angV(x,y);
%Угол направления вектора. 
%Аналог angle(re+1i.*im);

function angV = angV(x,y)
if (nargin==1 && length(x)==2)
    angV=atan2(x(2), x(1));
else
    angV=atan2(y, x);
end
end

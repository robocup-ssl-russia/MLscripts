function bool=CollisionControl()
global Blues Yellows PAR;
bool=true;
if (size(Blues,1)~=size(Yellows,1))
    warning('size(Blues,1)~=size(Yellows,1)');
end
for i=4%:size(Blues,1)
   for j=3%1:size(Yellows,1)
       if ((i~=j) && Yellows(i,1) && Yellows(j,1) &&(norm(Yellows(i,[2,3])-Yellows(j,[2,3]))<PAR.RobotSize))
           warning('Collision Y(%1.0f) vs Y(%1.0f)',i,j);
           bool=false;
       end
       if ((i~=j) && Blues(i,1) && Blues(j,1) && (norm(Blues(i,[2,3])-Blues(j,[2,3]))<PAR.RobotSize))
           warning('Collision B(%1.0f) vs B(%1.0f)',i,j);
           bool=false;
       end
       if (Yellows(i,1) && Blues(j,1) && (norm(Yellows(i,[2,3])-Blues(j,[2,3]))<PAR.RobotSize))
           warning('Collision Y(%1.0f) vs B(%1.0f)',i,j);
           bool=false;
       end
   end
end

end
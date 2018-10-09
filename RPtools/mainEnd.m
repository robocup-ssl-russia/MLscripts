%Функция завершающая основную "main" функцию.
%Обязательная для функционирования структуры RP .
function zMain_End = mainEnd()
global RP Rules;
RP.zMain_End=true;
RP.WorkTime=toc(RP.T_timerH);
if isfield(RP,'WorkTimeMax');
    RP.WorkTimeMax=max(RP.WorkTimeMax,RP.WorkTime);
else
    RP.WorkTimeMax=RP.WorkTime;
end
zMain_End=RP.zMain_End;

for i=1:12
    if isempty(find(Rules(:,2)==i,1))
        for j=1:12
            if (RP.Yellow(j).Nrul==i)
                Rule(RP.Yellow(j).Nrul,RP.Yellow(j));
            else
                if (RP.Blue(j).Nrul==i)
                    Rule(RP.Blue(j).Nrul,RP.Blue(j));                    
                end
            end
        end
    end
end
global Modul;
if (norm(Rules)==0 && isempty(Modul)) 
    fprintf('Rules is clear! Use ''pairStart()''.\n');
end
end


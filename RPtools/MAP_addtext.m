function MAP_addtext(text,mod)
if (nargin==1)
    mod='%f';
end
global MAP_PAR
if isempty(MAP_PAR)
    return;
end

if (get(0,'CurrentFigure')==100)
%% BEGIN 
    if isnumeric(text)
        text=sprintf(mod,text);
    end
    if ~isfield(MAP_PAR,'text') || isempty(MAP_PAR.text)
        MAP_PAR.text=text;
    else
        MAP_PAR.text=[MAP_PAR.text,' ',text];
    end
end

end

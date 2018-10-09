global Modul
if isempty(Modul)
    return
end
MOD_Agents();
MOD_Ball();
Modul.T=Modul.T+Modul.dT;

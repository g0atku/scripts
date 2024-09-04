local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local oldNameCall
oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if self == MyPlayer and method:lower() == 'kick' and not checkcaller() then
        return
    elseif self.Name == 'Emotecs' and method == 'FireServer' and not checkcaller() then
        return
    elseif self.Name == 'shoot' and method == 'FireServer' and not checkcaller() then
        if IsRiptideCurve and args[21] then
            args[21] = args[21] * CurveMulti
        end
    elseif GKHBE and self.Name == 'Goalie' and method == 'FireServer' and not checkcaller() then
        if args[2] == 'BlockL' or args[2] == 'BlockR' then
            game:GetService("ReplicatedStorage").GK.Goalie:FireServer(args[1],'Gagamaru',args[3],args[4],args[5],args[6])
        elseif args[2] == 'Handle' then
            args[2] = 'Gagamaru'
        end
    end
    return oldNameCall(self, unpack(args))
end)
getgenv().HMMLoaded = true

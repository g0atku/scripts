local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local oldNameCall
oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if self == MyPlayer and method:lower() == 'kick' then
        return
    elseif self.Name == 'Emotecs' and method == 'FireServer' then
        return
    elseif IsAutoDribble and self.Name == 'ChestBump' and method == 'FireServer' then
        args[2] = args[2] / 1.5
    elseif IsRiptideCurve and self.Name == 'shoot' and method == 'FireServer' then
        if args[21] then
            args[21] = args[21] * CurveMulti
        end
    elseif M2HBE then
        args[12] = true
        args[13] = true
    elseif IsAutoM2 and self.Name == 'Ragdoll' and method == 'FireServer' then
        return
    end
    return oldNameCall(self, unpack(args))
end)
getgenv().HMMLoaded = true

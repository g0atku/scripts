local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local oldNameCall
oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if self == MyPlayer and method:lower() == 'kick' then
        return task.wait(9e9)
    elseif self.Name == 'Emotecs' and method == 'FireServer' then
        return task.wait(9e9)
    elseif IsAutoDribble and self.Name == 'ChestBump' and method == 'FireServer' then
        args[2] = args[2] / 2
    elseif IsRiptideCurve and self.Name == 'shoot' and method == 'FireServer' then
        if args[21] then
            args[21] = args[21] * CurveMulti
        end
        if M2HBE then
            if args[5] == true then
                args[5] = false
            end
            if args[12] == false then
                args[12] = true
            end
            if args[13] == false then
                args[13] = true
            end
        end
    end
    return oldNameCall(self, unpack(args))
end)
getgenv().HMMLoaded = true

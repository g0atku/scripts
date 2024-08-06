local oldNameCall = nil
oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if self == MyPlayer and method:lower() == 'kick' then
        return task.wait(9e9)
    elseif self.Name == 'Emotecs' and method == 'FireServer' then
        return task.wait(9e9)
    elseif getgenv().IsRiptideCurve and self.Name == 'shoot' and method == 'FireServer' then
        if args[21] then
            args[21] = args[21] * getgenv().CurveMulti
        end
        if getgenv().M2HBE then
            if args[4] == true then
                args[4] = false
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

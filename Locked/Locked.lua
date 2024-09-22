repeat task.wait() until VevoLoaded and VevoAllowed

local Window = Library:CreateWindow({
    Title = 'Vevo Hub | Locked',
    Center = true,
    AutoShow = (not getgenv().VevoStealth),
    TabPadding = 8,
    MenuFadeTime = 0.2
})
local Tabs = {}
local Sections = {}
if game.PlaceId ~= 12276235857 then
	Tabs['Game'] = Window:AddTab('Game')
	Tabs['Skills'] = Tabs['Game']:AddLeftTabbox()
	Sections['Weapons'] = Tabs['Skills']:AddTab('Weapons')
	Sections['Traits'] = Tabs['Skills']:AddTab('Traits')
	Sections['Physical'] = Tabs.Game:AddLeftGroupbox("Physical")
	Sections['Dribbling'] = Tabs.Game:AddRightGroupbox("Dribbling")
	Sections['Defense'] = Tabs.Game:AddRightGroupbox("Defense")
	Sections['GK'] = Tabs.Game:AddRightGroupbox("GK")
	Sections['Visual'] = Tabs.Game:AddLeftGroupbox("Visual")
end
Tabs['Auto'] = Window:AddTab('Auto')
Tabs['Misc'] = Window:AddTab('Misc')
Tabs['Player'] = Window:AddTab('Player')
Tabs['UI Settings'] = Window:AddTab('UI Settings')
Tabs['Credits'] = Window:AddTab('Credits')
	
Sections['Spinning'] = Tabs.Auto:AddRightGroupbox("Spinning")
Sections['Auto'] = Tabs.Auto:AddLeftGroupbox("Auto")
Sections['Misc'] = Tabs.Misc:AddLeftGroupbox("Misc")
Sections['Player'] = Tabs.Player:AddLeftGroupbox("Player")
Sections['Menu'] = Tabs['UI Settings']:AddLeftGroupbox('Menu')
Sections['Credits'] = Tabs.Credits:AddLeftGroupbox("Credits")

local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local MyGui = MyPlayer.PlayerGui
local MyChar = MyPlayer.Character or MyPlayer.CharacterAdded:wait()
local MyHum = MyChar:WaitForChild('Humanoid')
local MyHRP = MyChar:WaitForChild('HumanoidRootPart')
local Http = game:GetService("HttpService")
local TeleportService = game:GetService('TeleportService')
local CollectionService = game:GetService("CollectionService")
local Api = 'https://games.roblox.com/v1/games/'
local _place = game.PlaceId
local PlaceId = game.PlaceId
local _servers = Api.._place..'/servers/Public?sortOrder=Asc&limit=100'
local RunService = game:GetService('RunService');
local CurrentCamera = Workspace.CurrentCamera
local Clip
local UserInputService = game:GetService('UserInputService')
local WatermarkConnection
local IgnoreIndexes = {'StealthToggle'}

getgenv().NCToggle = false
getgenv().Noclipping = nil
getgenv().IsAutoAim = false
getgenv().AutoSlideTackle = false
getgenv().IsMetavision = false
getgenv().IsMetavisionTint = false
getgenv().NoJumpFatigue = false
getgenv().IsAutoDribble = false
getgenv().IsAutoFormless = false
getgenv().FormlessPowerMulti = 1
getgenv().IsRiptideCurve = false
getgenv().IsAutoM2 = false
getgenv().IsAutoFlick = false
getgenv().metacolor = Color3.new(1,1,1)
getgenv().webhook = ''
getgenv().buffp = 0
getgenv().blackf = 1
getgenv().IsAutoSpin = false
getgenv().CurveMulti = 1
getgenv().PowerMulti = 1
getgenv().M2Clear = 'Cursor'
getgenv().M2HBE = false
getgenv().GKHBE = false
getgenv().IsGKHBE = 0
getgenv().StaminaGain = 1
getgenv().SlideTackleMulti = 1
getgenv().GKDiveMulti = 1
getgenv().DribbleHBE = 1
getgenv().DribbleDelay = 0.115
getgenv().CBIntoDribbleDelay = 0.7
getgenv().JumpBoost = 0
getgenv().JumpCD = 1.5
getgenv().JumpFatigueCD = 3
getgenv().IsAutoCBGK = false
getgenv().IsAutoDive = false
getgenv().FlowGain = 5

if getconnections then
	for i,v in pairs(getconnections(MyPlayer.Idled)) do
		v:Disable()
		v:Disconnect()
	end
end

repeat task.wait() until (tonumber(MyChar:WaitForChild('AuraColour').Buff:GetAttribute("BuffValue"))) ~= 0

local orgKickPower
local orgSpeed
local orgWeapon = (MyPlayer.Backpack:FindFirstChildWhichIsA('NumberValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('BoolValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('StringValue'))
local orgWeaponText = MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Text
local orgWeaponKBText
local orgTrait = MyPlayer.Backpack.Trait:GetChildren()[1].Name
local orgTraitText = MyGui.GeneralGUI.cooldowns.Trait.TextLabel.Text
local orgTraitKBText
local orgMaxStamina
local rm2anim = Instance.new("Animation")
rm2anim.AnimationId = "rbxassetid://12830711336"
local rm2animation = MyHum:LoadAnimation(rm2anim)
local lm2anim = Instance.new("Animation")
lm2anim.AnimationId = "rbxassetid://16013434132"
local lm2animation = MyHum:LoadAnimation(lm2anim)
if PlaceId ~= 12276235857 then
	orgMaxStamina = MyChar:GetAttribute('MAXSTAMINA')
	orgKickPower = MyChar.Specs.OrgKickPower.Value
	orgSpeed = MyChar.Specs.OrgSprintSpeed.Value
	orgWeaponKBText = MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Text
	orgTraitKBText = MyGui.GeneralGUI.cooldowns.TraitKeybind.TextLabel.Text
end
local mvcon
local divecon
local formlessfunc

local ContextActionService = game:GetService("ContextActionService")
local stamina = 100
local isSurf = false
local isVora = false
local tacklestam = 15
local isTackle = true
local tacklecd = 0
local tackleanim = Instance.new("Animation")
tackleanim.AnimationId = "rbxassetid://12994376714"
local runanim = Instance.new("Animation")
runanim.AnimationId = "rbxassetid://13124893453"
local runanimation = MyHum:FindFirstChildWhichIsA("Animator"):LoadAnimation(runanim)
local isRunning = false
local runspeed = 0
local changedspeed = true
local isChargingStam = false

local blockfanim = Instance.new("Animation")
blockfanim.AnimationId = "rbxassetid://12573707464"
local blockranim = Instance.new("Animation")
blockranim.AnimationId = "rbxassetid://12830222462"
local blocklanim = Instance.new("Animation")
blocklanim.AnimationId = "rbxassetid://12830218177"
local gkrushanim = Instance.new("Animation")
gkrushanim.AnimationId = "rbxassetid://12782895583"
local gagamaruanim = Instance.new("Animation")
gagamaruanim.AnimationId = "rbxassetid://13576366759"
local sblockranim = Instance.new("Animation")
sblockranim.AnimationId = "rbxassetid://12924118750"
local sblocklanim = Instance.new("Animation")
sblocklanim.AnimationId = "rbxassetid://12924088391"
local gktakeanim = Instance.new("Animation")
gktakeanim.AnimationId = "rbxassetid://13891765925"
local blockfanimation = MyHum:LoadAnimation(blockfanim)
local blocklanimation = MyHum:LoadAnimation(blocklanim)
local blockranimation = MyHum:LoadAnimation(blockranim)
local gkrushanimation = MyHum:LoadAnimation(gkrushanim)
local gagamaruanimation = MyHum:LoadAnimation(gagamaruanim)
local sblockranimation = MyHum:LoadAnimation(sblockranim)
local sblocklanimation = MyHum:LoadAnimation(sblocklanim)
local gktakeanimation = MyHum:LoadAnimation(gktakeanim)
local gktakeanimation = MyHum:LoadAnimation(gktakeanim)

local isSaving = false
local isSnatch = false
local isAcrobatic = false
local isGagamaru = false
local gagamarucd = false
local isClaw = false
local isHoldingBall = false

local fatiguecount = 2
local isJumpFatigue = false
local fatiguecd = false

function findAnimation(plr, anid)
	for _, anim in pairs(plr.Character.Humanoid:GetPlayingAnimationTracks()) do
		if string.find(anim.Animation.AnimationId, anid) then
			return anim
		end
	end
	return
end
function CustomSprintScript()
	local CurrentStamina = MyGui:WaitForChild("GeneralGUI"):WaitForChild("CurrentStamina")
	MyHum.Running:Connect(function(speed)
		runspeed = speed
	end)
	function handle(a1, a2, a3)
		if a2 == Enum.UserInputState.Begin then
			if MyHum.MoveDirection.Magnitude > -1 then
				isRunning = true
				while isRunning do
					if runanimation.IsPlaying or runspeed <= 0 or MyChar:FindFirstChild("Dominance") then
						if runspeed == 0 then
							runanimation:Stop()
							local tweeninf = TweenInfo.new(0.5)
							game:GetService("TweenService"):Create(CurrentCamera, tweeninf, {
								["FieldOfView"] = 70
							}):Play()
						end
					else
						runanimation:Play()
						local tweeninf = TweenInfo.new(0.5)
						game:GetService("TweenService"):Create(CurrentCamera, tweeninf, {
							["FieldOfView"] = 80
						}):Play()
					end
					if MyHum.FloorMaterial == Enum.Material.Air or MyHum.FloorMaterial == Enum.Material.Water then
						runanimation:Stop()
						local tweeninf = TweenInfo.new(0.5)
						game:GetService("TweenService"):Create(CurrentCamera, tweeninf, {
							["FieldOfView"] = 70
						}):Play()
					end
					if MyChar:GetAttribute("SPRINTSPEED") then
						changedspeed = true
						MyHum.WalkSpeed = MyChar:GetAttribute("SPRINTSPEED") or 34
						changedspeed = false
					else
						changedspeed = true
						MyHum.WalkSpeed = 34
						changedspeed = false
					end
					local getstam = MyChar:GetAttribute("MAXSTAMINA") or 100
					if isChargingStam then
						changedspeed = true
						MyHum.WalkSpeed = 0
						changedspeed = false
					elseif stamina < 0 then
						stamina = 0
						changedspeed = true
						MyHum.WalkSpeed = 18
						changedspeed = false
						isRunning = false
					elseif MyChar:HasTag("Slowed") then
						changedspeed = true
						MyHum.WalkSpeed = 18
						changedspeed = false
						isRunning = false
					elseif getstam < stamina then
						stamina = getstam
					end
					task.wait()
				end
				runanimation:Stop()
				changedspeed = true
				MyHum.WalkSpeed = 18
				changedspeed = false
				local tweeninf = TweenInfo.new(0.5)
				game:GetService("TweenService"):Create(CurrentCamera, tweeninf, {
					["FieldOfView"] = 70
				}):Play()
				return
			end
		else
			isRunning = false
		end
	end
	game.ReplicatedStorage["GOAL!"].OnClientEvent:Connect(function()
		stamina = MyChar:GetAttribute("MAXSTAMINA") or 100
	end)
	function checksprint(a1, a2, a3)
		if MyGui.Menu.NewPopup.GUIS.SettingsGUI.Sprint.Value.Value == true then
			handle(a1, a2, a3)
		end
	end
	ContextActionService:BindAction("Sprint", checksprint, true, Enum.KeyCode.LeftShift)
	RunService.Heartbeat:Connect(function(a)
		local getstam = MyChar:GetAttribute("MAXSTAMINA") or 100
		if stamina < getstam then
			if not runanimation.IsPlaying then
				stamina = stamina + ((0.02*60) / (1/a))
			end
			if stamina < 0 then
				stamina = 0
			elseif getstam < stamina then
				stamina = getstam
			end
		end
		if runanimation.IsPlaying and (not isChargingStam) and (not MyChar.IsSliding.Value) and (not MyHRP.Anchored) then
			stamina = stamina - ((0.08*60) / (1/a))
		end
		if not isRunning then
			if isChargingStam then
				changedspeed = true
				MyHum.WalkSpeed = 0
				changedspeed = false
			else
				changedspeed = true
				MyHum.WalkSpeed = 18
				changedspeed = false
			end
		end
		local getstam = MyChar:GetAttribute("MAXSTAMINA") or 100
		if workspace:WaitForChild("TrainingMode").Value == true or (MyChar:FindFirstChild("Lroke") and MyChar:WaitForChild("Lroke").Value) then
			stamina = getstam
		end
		local GStamina = stamina / getstam
		local PStamina = CurrentStamina:WaitForChild("Stamina%")
		local MStamina = GStamina * 100
		PStamina.Text = "STAMINA " .. math.floor(MStamina) .. "%"
		game:GetService("TweenService"):Create(CurrentStamina:WaitForChild("CurrentStamina"), TweenInfo.new(0.075, Enum.EasingStyle.Quint), {
			["Size"] = UDim2.new(GStamina, 0, 1, 0)
		}):Play()
		if getstam < stamina then
			stamina = getstam
		end
	end)
	local CStamina = 0
	MyChar.AttributeChanged:Connect(function()
		local getstamina = MyChar:GetAttribute("MAXSTAMINA")
		if getstamina and getstamina ~= CStamina then
			if CStamina < getstamina then
				stamina = getstamina
			end
			CStamina = getstamina
		end
	end)
	local stamanim = Instance.new("Animation")
	stamanim.AnimationId = "rbxassetid://12476887564"
	local stamanimation = MyHum:FindFirstChildWhichIsA("Animator"):LoadAnimation(stamanim)
	stamanimation.Priority = Enum.AnimationPriority.Action3
	UserInputService.InputBegan:Connect(function(key, a1)
		if (key.KeyCode == Enum.KeyCode.V or key.KeyCode == Enum.KeyCode.ButtonY) and MyChar and not MyChar:FindFirstChildOfClass("Tool") and not isChargingStam and MyChar.Ragdoll.Value == false then
			isChargingStam = true
			repeat task.wait() until MyHRP.Velocity.Magnitude < 30
			stamanimation:Play()
			MyHum.WalkSpeed = 0
			while task.wait(0.03) do
				local getstam = MyChar:GetAttribute("MAXSTAMINA") or 100
				if stamina >= getstam then
					break
				end
				if not MyHRP:FindFirstChild("BodyVelocity") then
					stamina = stamina + (getstam * (0.01 * getgenv().StaminaGain))
				end
				if key.UserInputState == Enum.UserInputState.End then
					stamanimation:Stop()
					isChargingStam = false
					return
				end
			end
			stamanimation:Stop()
			isChargingStam = false
		end
	end)
	function funccooldown(cd)
		MyGui.GeneralGUI.cooldowns.Tackle.TextLabel.Visible = false
		MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Parent.BackgroundTransparency = 0
		if MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Visible == false then
			MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Visible = true
			local t = tick()
			local cdcon
			cdcon = RunService.RenderStepped:Connect(function()
				local leftcd = cd - (tick() - t)
				MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Text = "(" .. string.format("%.1f", leftcd) .. ")/s"
				if leftcd <= 0 then
					MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Visible = false
					MyGui.GeneralGUI.cooldowns.Tackle.TextLabel.Visible = true
					MyGui.GeneralGUI.cooldowns.Tacklecd.TextLabel.Parent.BackgroundTransparency = 1
					cdcon:Disconnect()
				end
			end)
		end
	end
	function velocity(vel, isVora, anim)
		local velcon
		local t = 0.04
		task.spawn(function()
			task.wait(0.8)
			if isVora then
				velcon:Disconnect()
				vel:Destroy()
				anim:Stop()
				MyHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				MyHum.AutoRotate = true
			else
				t = 0.05
				task.wait(1)
				velcon:Disconnect()
				vel:Destroy()
				MyHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				MyHum.AutoRotate = true
			end
		end)
		velcon = RunService.RenderStepped:Connect(function(a)
			local velspeed = vel.Velocity
			vel.Velocity = velspeed - ((velspeed * t * 60) / (1/a))
		end)
	end
	UserInputService.InputBegan:Connect(function(key, a1)
		if a1 then
			return
		elseif isTackle then
			if os.time() - tacklecd >= 30 then
				if MyChar.Animate.idle.Animation1.AnimationId ~= "rbxassetid://12572855663" and not MyHRP:FindFirstChild("BodyVelocity") and (key.KeyCode == Enum.KeyCode.Q or key.KeyCode == Enum.KeyCode.ButtonX) and not MyHRP.Anchored then
					if MyPlayer.Backpack:FindFirstChild("Voracious") then
						isVora = true
						tacklestam = 25
					else
						isVora = false
						tacklestam = 15
					end
					if MyChar.Ragdoll.Value == false and tacklestam < stamina then
						if MyPlayer.Backpack.Trait:FindFirstChild("Surf") then
							isSurf = true
						else
							isSurf = false
						end
						tacklecd = os.time()
						isTackle = false
						funccooldown(30)
						MyHum.AutoRotate = false
						local tackleanimation = MyHum:LoadAnimation(tackleanim)
						tackleanimation:Play()
						MyHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
						game.ReplicatedStorage.TackleFlag:FireServer()
						local TackleVel = Instance.new("BodyVelocity")
						TackleVel.MaxForce = Vector3.new(1, 0, 1) * 20000
						TackleVel.Velocity = MyHRP.CFrame.lookVector * (100 * getgenv().SlideTackleMulti)
						if isSurf then
							TackleVel.Velocity = TackleVel.Velocity * 1.3
						end
						TackleVel.Parent = MyHRP
						stamina = stamina - tacklestam
						task.spawn(function()
							if not MyHRP:FindFirstChild('IsTackling') then
								local IsTackling = Instance.new("StringValue", MyHRP)
								IsTackling.Name = "IsTackling"
							end
							task.wait(2.5)
							MyHRP:WaitForChild('IsTackling'):Destroy()
						end)
						game.ReplicatedStorage.Tackle:FireServer(MyHRP.CFrame.lookVector, isVora)
						velocity(TackleVel, isVora, tackleanimation)
						isTackle = true
					end
				end
			end
		else
			return
		end
	end)
	if MyPlayer.Backpack.Trait:FindFirstChild('Bunnys') then
		MyHum.JumpHeight = 10.5
	elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
		MyHum.JumpHeight = 9.5
	else
		MyHum.JumpHeight = 8.5
	end
	if orgTrait ~= 'LongStrides' and orgTrait ~= 'Athlete' then
		if MyPlayer.Backpack.Trait:FindFirstChild('LongStrides') then
			if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
				MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 2)
			end
		elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
			if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
				MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 1)
			end
		else
			MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value)
		end
	end
	MyChar.FlowValue:GetPropertyChangedSignal('Value'):Connect(function()
		if MyChar.AuraColour.Buff.Value == 'speed' then
			if MyChar.FlowValue.Value then
				local cspeed = MyChar:GetAttribute('SPRINTSPEED')
				repeat task.wait() until MyChar:GetAttribute('SPRINTSPEED') ~= cspeed
				local speed = MyChar.Specs.OrgSprintSpeed.Value
				local buff = (tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue')) / 10) + 1
				speed = speed * buff
				if orgTrait ~= 'LongStrides' and orgTrait ~= 'Athlete' then	
					if MyPlayer.Backpack.Trait:FindFirstChild('LongStrides') then
						speed = speed + 2
					elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
						speed = speed + 1
					end
				end
				MyChar:SetAttribute('SPRINTSPEED', speed)
			else
				local cspeed = MyChar:GetAttribute('SPRINTSPEED')
				repeat task.wait() until MyChar:GetAttribute('SPRINTSPEED') ~= cspeed
				local speed = MyChar.Specs.OrgSprintSpeed.Value
				if orgTrait ~= 'LongStrides' and orgTrait ~= 'Athlete' then	
					if MyPlayer.Backpack.Trait:FindFirstChild('LongStrides') then
						speed = speed + 2
					elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
						speed = speed + 1
					end
				end
				MyChar:SetAttribute('SPRINTSPEED', speed)
			end
		end
	end)
end
function CustomGKScript()	
	MyHum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	MyHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	MyHum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	
	function InBox()
		for i,v in ipairs(workspace:WaitForChild("Box"):GetChildren()) do
			local partsinbox = workspace:GetPartsInPart(v)
			for _,part in pairs(partsinbox) do
				if part == MyHRP then
					return true
				end
			end
		end
		return
	end
	function cooldownbuff(cd)
		if workspace:FindFirstChild("TrainingMode") then
			cd = (workspace.TrainingMode.Value == true and 0) or cd
		end
		if MyPlayer.Backpack.Trait:FindFirstChild("Consistent") then
			cd = cd - (cd * 0.15)
		end
		if MyChar.AuraColour.Buff.Value == "cooldown" then
			local cdmath = cd * (MyChar.AuraColour.Buff:GetAttribute("BuffValue") / 10)
			if MyChar:HasTag("CooldownBuff") then
				cdmath = cdmath * 2
			end
			cd = cd - cdmath
		end
		return cd
	end
	function cooldownmove(cd)
		MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Visible = false
		MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Visible = false
		MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Parent.BackgroundTransparency = 0
		if MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible == false then
			MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible = true
			local t = tick()
			local cdcon
			cdcon = RunService.RenderStepped:Connect(function()
				local leftcd = cd - (tick() - t)
				MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Text = "(" .. string.format("%.1f", leftcd) .. ")/s"
				if leftcd <= 0 then
					MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible = false
					MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Visible = true
					MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Visible = true
					MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Parent.BackgroundTransparency = 1
					cdcon:Disconnect()
				end
			end)
		end
	end
	function BlockR()
		if isHoldingBall or not InBox() then return end
		if MyPlayer.Backpack:FindFirstChild("Snatch") then
			isSnatch = true
		else
			isSnatch = false
		end
		if MyPlayer.Backpack:FindFirstChild("Acrobatic") then
			isAcrobatic = true
		else
			isAcrobatic = false
		end
		if not MyChar:WaitForChild("GK").Value then
			if MyPlayer.Backpack:FindFirstChild("Serpent") and not isSaving then
				isSaving = true
				sblockranimation:Play()
				local vel = Instance.new("BodyVelocity")
				vel.MaxForce = Vector3.new(1, 0, 1) * 19000
				vel.Velocity = MyHRP.CFrame.RightVector * (130 * getgenv().GKDiveMulti)
				vel.Parent = MyHRP
				game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockR", false, false, true, false)
				local v = 5
				if getgenv().IsAutoCBGK then
					task.spawn(function()
						while v > 0 do
							game.ReplicatedStorage.ChestBump:FireServer(Vector3.zero, 0, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
							task.wait(0.7)
						end
					end)
				end
				if getgenv().IsGKHBE > 0 then
					for i = 1,getgenv().IsGKHBE do
						game:GetService("ReplicatedStorage").GK.jumped:FireServer()
					end
				end	
				while v > 0 do
					wait()
					vel.Velocity = vel.Velocity * 0.84
					v = v - 0.1
				end
				vel:Destroy()
				MyChar.IsBlocking.Value = false
				task.wait(1)
				isSaving = false
				return
			end
		elseif not isSaving then
			isSaving = true
			local v = 3
			if getgenv().IsAutoCBGK then
				task.spawn(function()
					while v > 0 do
						game.ReplicatedStorage.ChestBump:FireServer(Vector3.zero, 0, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
						task.wait(0.7)
					end
				end)
			end
			blockfanimation:Play()
			local vel = Instance.new("BodyVelocity")
			MyChar.IsBlocking.Value = true
			if MyPlayer.Backpack.Trait:FindFirstChild("Claw") then
				isClaw = true
			end
			vel.MaxForce = Vector3.new(1, 0, 1) * 19000
			local direction = MyHRP.CFrame.RightVector * (130 * getgenv().GKDiveMulti)
			if MyPlayer.Backpack.Trait:FindFirstChild("Diver") then
				direction = MyHRP.CFrame.RightVector * 200
			end
			blockfanimation:Stop()
			blockranimation:Play()
			if isAcrobatic and gagamarucd == false then
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.6, 0.2)
				task.spawn(function()
					task.wait(0.7)
					blockranimation:Stop()
				end)
			else
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.6, 0.6)
			end
			vel.Velocity = direction
			vel.Parent = MyHRP
			game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockR", isSnatch, isGagamaru, true, isClaw)
			if getgenv().IsGKHBE > 0 then
				for i = 1,getgenv().IsGKHBE do
					game:GetService("ReplicatedStorage").GK.jumped:FireServer()
				end
			end
			while v > 0 do
				wait()
				vel.Velocity = vel.Velocity * 0.84
				v = v - 0.1
			end
			vel:Destroy()
			MyChar.IsBlocking.Value = false
			if isAcrobatic and gagamarucd == false then
				isSaving = false
				return
			end
			task.wait(0.5)
			isSaving = false
		end
	end
	function BlockL()
		if isHoldingBall or not InBox() then return end
		if MyPlayer.Backpack:FindFirstChild("Snatch") then
			isSnatch = true
		else
			isSnatch = false
		end
		if MyPlayer.Backpack:FindFirstChild("Acrobatic") then
			isAcrobatic = true
		else
			isAcrobatic = false
		end
		if not MyChar:WaitForChild("GK").Value then
			if MyPlayer.Backpack:FindFirstChild("Serpent") and not isSaving then
				isSaving = true
				sblocklanimation:Play()
				local vel = Instance.new("BodyVelocity")
				vel.MaxForce = Vector3.new(1, 0, 1) * 19000
				vel.Velocity = -MyHRP.CFrame.RightVector * (-130 * getgenv().GKDiveMulti)
				vel.Parent = MyHRP
				game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockL", false, false, true, false)
				local v = 5
				if getgenv().IsAutoCBGK then
					task.spawn(function()
						while v > 0 do
							game.ReplicatedStorage.ChestBump:FireServer(Vector3.zero, 0, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
							task.wait(0.7)
						end
					end)
				end
				if getgenv().IsGKHBE > 0 then
					for i = 1,getgenv().IsGKHBE do
						game:GetService("ReplicatedStorage").GK.jumped:FireServer()
					end
				end
				while v > 0 do
					wait()
					vel.Velocity = vel.Velocity * 0.84
					v = v - 0.1
				end
				vel:Destroy()
				MyChar.IsBlocking.Value = false
				task.wait(1)
				isSaving = false
				return
			end
		elseif not isSaving then
			isSaving = true
			local v = 3
			if getgenv().IsAutoCBGK then
				task.spawn(function()
					while v > 0 do
						game.ReplicatedStorage.ChestBump:FireServer(Vector3.zero, 0, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
						task.wait(0.7)
					end
				end)
			end
			MyChar.IsBlocking.Value = true
			if MyPlayer.Backpack.Trait:FindFirstChild("Claw") then
				isClaw = true
			end
			blockfanimation:Play()
			local vel = Instance.new("BodyVelocity")
			vel.MaxForce = Vector3.new(1, 0, 1) * 19000
			local direction = MyHRP.CFrame.RightVector * (-130 * getgenv().GKDiveMulti)
			if MyPlayer.Backpack.Trait:FindFirstChild("Diver") then
				direction = MyHRP.CFrame.RightVector * -200
			end
			blockfanimation:Stop()
			blocklanimation:Play()
			if isAcrobatic and gagamarucd == false then
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.6, 0.2)
				task.spawn(function()
					task.wait(0.7)
					blocklanimation:Stop()
				end)
			else
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.6, 0.6)
			end
			vel.Velocity = direction
			vel.Parent = MyHRP
			game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockL", isSnatch, isGagamaru, true, isClaw)
			if getgenv().IsGKHBE > 0 then
				for i = 1,getgenv().IsGKHBE do
					game:GetService("ReplicatedStorage").GK.jumped:FireServer()
				end
			end	
			while v > 0 do
				wait()
				vel.Velocity = vel.Velocity * 0.84
				v = v - 0.1
			end
			vel:Destroy()
			MyChar.IsBlocking.Value = false
			if isAcrobatic and gagamarucd == false then
				isSaving = false
				return
			end
			task.wait(0.5)
			isSaving = false
		end
	end
	function handleStealEvent()
		if isHoldingBall or not InBox() then return end
		if MyPlayer.Backpack:FindFirstChild("Snatch") then
			isSnatch = true
		else
			isSnatch = false
		end
		if MyPlayer.Backpack:FindFirstChild("Acrobatic") then
			isAcrobatic = true
		else
			isAcrobatic = false
		end
		if MyChar:WaitForChild("GK").Value then
			if not isSaving then
				isSaving = true
				local hb
				if getgenv().GKHBE then
					hb = 'Gagamaru'
				else
					hb = 'Handle'
				end
				local v = 3
				if getgenv().IsAutoCBGK then
					task.spawn(function()
						while v > 0 do
							game.ReplicatedStorage.ChestBump:FireServer(Vector3.zero, 0, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
							task.wait(0.7)
						end
					end)
				end
				if MyPlayer.Backpack.Trait:FindFirstChild("Claw") then
					isClaw = true
				end
				blockfanimation:Play()
				MyChar.IsBlocking.Value = true
				game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), hb, isSnatch, isGagamaru, false, isClaw)
				if getgenv().IsGKHBE > 0 then
					for i = 1,getgenv().IsGKHBE do
						game:GetService("ReplicatedStorage").GK.jumped:FireServer()
					end
				end	
				while v > 0 do
					wait()
					v = v - 0.1
				end
				MyChar.IsBlocking.Value = false
				task.wait(0.5)
				isSaving = false
			end
		end
	end
	function gagamaruactive()
		if isHoldingBall or not InBox() then return end
		if MyPlayer.Backpack:FindFirstChild("CopyCat") and MyPlayer.Backpack:FindFirstChild("CopyCat").Value == 1 then
			return
		end
		if MyPlayer.Backpack:FindFirstChild("Snatch") then
			isSnatch = true
		else
			isSnatch = false
		end
		if MyPlayer.Backpack:FindFirstChild("Acrobatic") then
			isAcrobatic = true
		else
			isAcrobatic = false
		end
		if MyChar:WaitForChild("GK").Value then
			if not isSaving and not gagamarucd and isAcrobatic then
				isSaving = true
				local v = 3
				MyChar.IsBlocking.Value = true
				isGagamaru = true
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.5, 0.5)
				gagamaruanimation:Play()
				task.spawn(function()
					gagamarucd = true
					local cd = cooldownbuff(10)
					cooldownmove(cd)
					task.wait(cd)
					gagamarucd = false
				end)
				isClaw = false
				game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "Gagamaru", isSnatch, isGagamaru, false, isClaw)
				if getgenv().IsGKHBE > 0 then
					for i = 1,getgenv().IsGKHBE do
						game:GetService("ReplicatedStorage").GK.jumped:FireServer()
					end
				end	
				isGagamaru = false
				while v > 0 do
					wait()
					v = v - 0.1
				end
				MyChar.IsBlocking.Value = false
				task.wait(0.5)
				isSaving = false
			end
		end
	end
	function divef()
		if isHoldingBall or not InBox() then return end
		if MyChar:WaitForChild("GK").Value then
			if not isSaving then
				isSaving = true
				local v = 3
				local vel = Instance.new("BodyVelocity")
				vel.MaxForce = Vector3.new(1, 0, 1) * 30000
				local direction = MyHRP.CFrame.LookVector * (100 * getgenv().GKDiveMulti)
				if MyPlayer.Backpack.Trait:FindFirstChild("Diver") then
					direction = MyHRP.CFrame.LookVector * 140
				end
				gkrushanimation:Play()
				vel.Velocity = direction
				vel.Parent = MyHRP
				game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(0.4, 0.7)
				game.ReplicatedStorage.GK.GKDive:FireServer(direction, MyChar)
				while v > 0 do
					wait()
					vel.Velocity = vel.Velocity * 0.89
					v = v - 0.1
				end
				gkrushanimation:Stop()
				vel:Destroy()
				task.wait(0.5)
				isSaving = false
			end
		end
	end
	function PickUpBall()
		if InBox() and not isHoldingBall and not isSaving and MyChar:WaitForChild("GK").Value then
			isSaving = true
			gktakeanimation:Play()
			game.ReplicatedStorage.GK.holdball:FireServer()
			task.wait(1.5)
			isSaving = false
		end
	end
	UserInputService.InputBegan:Connect(function(key, a1)
		if not a1 then
			if (key.KeyCode == Enum.KeyCode[MyGui.Goalie:WaitForChild("Left").Value] or key.KeyCode == Enum.KeyCode.ButtonL1) then
				BlockL()
			elseif (key.KeyCode == Enum.KeyCode[MyGui.Goalie:WaitForChild("Right").Value] or key.KeyCode == Enum.KeyCode.ButtonR1) then
				BlockR()
			elseif (key.KeyCode == Enum.KeyCode[MyGui.Goalie:WaitForChild("Dive").Value] or key.KeyCode == Enum.KeyCode.ButtonX) then
				divef()
			elseif (key.KeyCode == Enum.KeyCode[MyGui.Goalie:WaitForChild("Block").Value] or key.KeyCode == Enum.KeyCode.ButtonB) then
				handleStealEvent()
			elseif (key.KeyCode == Enum.KeyCode.R or key.KeyCode == Enum.KeyCode.DPadUp) then
				gagamaruactive()
			elseif key.KeyCode == Enum.KeyCode[MyGui.Goalie:WaitForChild("PickUp").Value] then
				PickUpBall()
			end
		end
	end)
	game.ReplicatedStorage.GK.holdball.OnClientEvent:Connect(function(a1)
		if a1 then
			isHoldingBall = true
			game.ReplicatedStorage.GK.releasetimer:FireServer()
			print("holding")
		else
			task.wait(1)
			isHoldingBall = false
			print("release")
		end
	end)
	Sections.GK:AddToggle('AcrobaticHitboxToggle', {
		Text = 'Acrobatic Hitbox',
		Default = false,
		Tooltip = 'Changes standart F block hitbox to acrobatic one',
		Callback = function(Value)
			getgenv().GKHBE = Value
		end
	})
	Sections.GK:AddSlider('GKDiveSlider', {
		Text = 'GK Dive Multi',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			getgenv().GKDiveMulti = Multi
		end
	})
	Sections.GK:AddToggle('AutoCBGKToggle', {
		Text = 'Auto Chest Bump',
		Default = false,
		Tooltip = 'Automatically uses chest bump while you are diving',
		Callback = function(Value)
			getgenv().IsAutoCBGK = Value
		end
	})
	local segments = 10
	local crossbars = {}
	for i,v in pairs(workspace.CrossbarHitbox:GetChildren()) do
		if v.Size.Z >= 39 then
			table.insert(crossbars, v)
		end
	end
	if not workspace:FindFirstChild('GoalHitboxes') then
		local GoalHitboxes = Instance.new('Folder', workspace)
		GoalHitboxes.Name = 'GoalHitboxes'
	end
	for i,crossbar in pairs(crossbars) do
		local goalhitbox = Instance.new('Part', workspace:WaitForChild('GoalHitboxes'))
		goalhitbox.Name = 'goalhitbox'..tostring(i)
		goalhitbox.CanCollide = false
		goalhitbox.CanQuery = true
		goalhitbox.CanTouch = true
		goalhitbox.Anchored = true
		goalhitbox.Material = Enum.Material.Neon
		goalhitbox.Transparency = 1
		goalhitbox.CFrame = crossbar.CFrame * CFrame.new(0,-6.9275,0)
		goalhitbox.Size = Vector3.new(0,17.655,42.825)
	end
	if not workspace:FindFirstChild('savehitbox') then
		local savehitbox = Instance.new('Part', workspace)
		savehitbox.Name = 'savehitbox'
		savehitbox.CanCollide = false
		savehitbox.Massless = true
		savehitbox.CanQuery = true
		savehitbox.CanTouch = true
		savehitbox.Anchored = false
		savehitbox.Material = Enum.Material.Neon
		savehitbox.Transparency = 1
		savehitbox.CFrame = MyHRP.CFrame * CFrame.new(0,workspace:WaitForChild('GoalHitboxes').goalhitbox1.CFrame.Y-MyHRP.CFrame.Y,0) * CFrame.Angles(0,math.rad(90),0)
		savehitbox.Size = Vector3.new(0,17.655,42.825) * 1.5
		local hrpweld = Instance.new('WeldConstraint', savehitbox)
		hrpweld.Name = 'hrpweld'
		hrpweld.Enabled = true
		hrpweld.Part0 = savehitbox
		hrpweld.Part1 = MyHRP
	end
	function calculateLandingPosition(ball)
		local BallVel = ball.AssemblyLinearVelocity
		local BallPos = ball.Position
		local Gravity = 0.5 * (-workspace.Gravity)
		local d = BallVel.Y^2 - 4 * Gravity * BallPos.Y
		local x1 = (-(BallVel.Y) + math.sqrt(d)) / (2 * Gravity)
		local x2 = (-(BallVel.Y) - math.sqrt(d)) / (2 * Gravity)
		if x1 < x2 then
			x1 = x2
		end			
		return x1
	end
	function calculateTrajectory(ball, segments)
		local positions = {}
		local BallPos = ball.Position
		local BallVel = ball.AssemblyLinearVelocity
		local Gravity = workspace.Gravity
		local timeStep = calculateLandingPosition(ball) / segments
		for i = 1, segments do
			local t = i * timeStep
			local pos = BallPos + BallVel * t + Vector3.new(0, -0.5 * Gravity * t^2, 0)
			table.insert(positions, pos)
		end
		return positions
	end
	Sections.GK:AddLabel('Auto Dive'):AddKeyPicker('AutoDiveToggleKeyBind', {
		Default = 'J',
		Mode = 'Toggle',
		Text = 'Auto Dive',
		NoUI = false,
		Callback = function(Value)
			if Value then
				divecon = RunService.RenderStepped:Connect(function()
					for _, ball in pairs(workspace.BallFolder:GetChildren()) do
						if ball.Name == "Ball" then
							local trajectoryPositions = calculateTrajectory(ball, segments)
							for i = 1, #trajectoryPositions - 1 do
								local startPos = trajectoryPositions[i]
								local endPos = trajectoryPositions[i + 1]
								local rayOrigin = startPos
								local rayDirection = endPos - startPos
								local rayResult = workspace:Raycast(rayOrigin, rayDirection)
								if rayResult then
									if string.find(rayResult.Instance.Name, 'savehitbox') then
										if not workspace:FindFirstChild('goalsencor') then
											local goalsencor = Instance.new('Part', workspace)
											goalsencor.Name = 'goalsencor'
											goalsencor.Shape = Enum.PartType.Ball
											goalsencor.Size = Vector3.new(1.9,1.9,1.9)
											goalsencor.Anchored = true
											goalsencor.CanCollide = false
											goalsencor.CanTouch = true
											goalsencor.CanQuery = true
											goalsencor.Transparency = 1
											goalsencor.Material = Enum.Material.Neon
										end
										workspace:WaitForChild('goalsencor').CFrame = CFrame.new(rayResult.Position)
										if rayResult.Position.Y > workspace:WaitForChild('GoalHitboxes').goalhitbox1.CFrame.Y and not fatiguecd and not isSaving then
											MyHum:ChangeState(Enum.HumanoidStateType.Jumping)
										end									
										if MyHRP.CFrame:ToObjectSpace(workspace:WaitForChild('goalsencor').CFrame).X <= -6.375 then
											BlockL()
										elseif MyHRP.CFrame:ToObjectSpace(workspace:WaitForChild('goalsencor').CFrame).X >= 6.375 then
											BlockR()
										else
											handleStealEvent()
										end
									end
								end
							end
						end
					end
					if Library.Unloaded then
						divecon:Disconnect()
					end
				end)
			elseif divecon then
				divecon:Disconnect()
			end
		end
	})
	Sections.GK:AddSlider('GKHBESlider', {
		Text = 'GK HBE',
		Default = 0,
		Min = 0,
		Max = 8,
		Rounding = 0,
		Compact = false,
		Callback = function(Multi)
			getgenv().IsGKHBE = Multi
		end
	})
end
if PlaceId ~= 12276235857 then
	if MyChar.Movement:FindFirstChild('Sprint') then
		MyChar.Movement.Sprint:Remove()
		if findAnimation(MyPlayer, '13124893453') then findAnimation(MyPlayer, '13124893453'):Stop() end
		if findAnimation(MyPlayer, '12476887564') then findAnimation(MyPlayer, '12476887564'):Stop() end
		if MyChar:FindFirstChild('SS') then 
			MyChar:WaitForChild('SS').Disabled = true
			MyChar:WaitForChild('SS'):Destroy()
		end
		if MyChar:FindFirstChild('DribbleScriptCONSOLE') then
			MyChar:WaitForChild('DribbleScriptCONSOLE').Disabled = true
		elseif MyChar:FindFirstChild('DribbleScriptAutos') then
			MyChar:WaitForChild('DribbleScriptAutos').Disabled = true
		end
		if MyGui.Goalie:FindFirstChild('GoalieScriptAutos') then
			MyGui.Goalie:WaitForChild('GoalieScriptAutos').Disabled = true
		elseif MyGui.Goalie:FindFirstChild('GoalieScriptCONSOLE') then
			MyGui.Goalie:WaitForChild('GoalieScriptCONSOLE').Disabled = true
		end
		if orgWeapon.Name == 'Formless' then
			MyChar.Specs.Activational.Disabled = true
		end
		MyChar.Movement.JumpFatigue.Disabled = true
		MyChar.flowupdate.Disabled = true
		if PlaceId == 17079303871 then
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= MyPlayer then
					for i,v in pairs(player.Character:GetDescendants()) do
						if v:IsA('LocalScript') then
							v:Destroy()
						end
					end
				end
			end
			MyGui.ResultsGui.SelectionScreen.LocalScript.DescendantAdded:Connect(function(n)
				if n:IsA('LocalScript') then
					n.Disabled = true
					n:Destroy()
				end
			end)
		end
	end
	CustomSprintScript()
	CustomGKScript()
	MyHum.StateChanged:Connect(function(a1, a2)
		if a2 == Enum.HumanoidStateType.Jumping then
			if getgenv().IsGKHBE == 0 then
				game.ReplicatedStorage.GK.jumped:FireServer()
			end
			if not MyChar:HasTag("JumpFatigue") then
				local jumpfx = game.ReplicatedStorage.Effects.JumpFX:Clone()
				jumpfx.Parent = workspace
				jumpfx.CFrame = MyHRP.CFrame - Vector3.new(0, 2, 0)
				for i,v in pairs(jumpfx.Attachment:GetChildren()) do
					v:Emit(v:GetAttribute("EmitCount"))
				end
				task.delay(1, function()
					jumpfx:Destroy()
				end)
			end
			if isJumpFatigue == true then
				if MyPlayer.Backpack.Trait:FindFirstChild("Bunnys") then
					fatiguecount = fatiguecount - 2
				else
					fatiguecount = fatiguecount - 1
				end
				print("decreasing jump")
			end
			if fatiguecount <= 0 then
				if not MyChar:HasTag("JumpFatigue") then
					MyChar:AddTag("JumpFatigue")
				end
				print("enough jumps")
			end
			isJumpFatigue = true
			fatiguecd = true
			MyHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			task.wait(getgenv().JumpCD)
			MyHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			fatiguecd = false
			task.wait(getgenv().JumpFatigueCD)
			if fatiguecd == false then
				isJumpFatigue = false
				fatiguecount = 2
				print("reset")
				if MyChar:HasTag("JumpFatigue") then
					MyChar:RemoveTag("JumpFatigue")
				end
			end
		end
	end)
	local jumpboosted = false
	MyHum:GetPropertyChangedSignal('JumpHeight'):Connect(function()
		if not jumpboosted then
			jumpboosted = true
			MyHum.JumpHeight = MyHum.JumpHeight + getgenv().JumpBoost
			task.delay(1, function()
				jumpboosted = false
			end)
		end
	end)
	if PlaceId == 13705109069 or PlaceId == 17079303871 then
		local ego = MyGui.GeneralGUI.EGO:WaitForChild("ego")
		local GainElo = MyChar:WaitForChild("RankSystem"):WaitForChild("GainingElo")
		game:GetService('ReplicatedStorage'):WaitForChild("FlowTypes"):WaitForChild("flowupdate").OnClientEvent:Connect(function(a1)
			if not MyChar:WaitForChild("FlowValue").Value then
				if a1 == "chestbump" then
					ego.Value = ego.Value + 15
					GainElo.Value = GainElo.Value + 1
				end
				if a1 == "goal" then
					ego.Value = ego.Value + 30
					game:GetService('ReplicatedStorage'):WaitForChild("Tasks").Goal:FireServer()
					GainElo.Value = GainElo.Value + 2
				end
				if a1 == "tackle" then
					ego.Value = ego.Value + 20
					game:GetService('ReplicatedStorage'):WaitForChild("Tasks").Tackle:FireServer()
					GainElo.Value = GainElo.Value + 1
				end
				if a1 == "gamestart" then
					ego.Value = 0
				end
				if a1 == "out" then
					ego.Value = ego.Value - 10
				end
				if a1 == "Goalie" then
					ego.Value = ego.Value + 20
					game:GetService('ReplicatedStorage'):WaitForChild("Tasks").Block:FireServer()
					GainElo.Value = GainElo.Value + 2
				end
				if a1 == "GoalieDive" then
					ego.Value = ego.Value + 25
					game:GetService('ReplicatedStorage'):WaitForChild("Tasks").Block:FireServer()
					GainElo.Value = GainElo.Value + 1
				end
				if a1 == "gameend" then
					ego.Value = 0
				end
				if a1 == "steal" then
					ego.Value = ego.Value + 20
					game:GetService('ReplicatedStorage'):WaitForChild("Tasks").Steal:FireServer()
					GainElo.Value = GainElo.Value + 1
				end
			end
		end)
	else
		task.spawn(function()
			while true do
				repeat task.wait(getgenv().FlowGain) until MyChar:WaitForChild("FlowValue").Value == false
				if workspace.TrainingMode.Value == false then
					MyGui.GeneralGUI.EGO:WaitForChild("ego").Value = MyGui.GeneralGUI.EGO:WaitForChild("ego").Value + 1
				else
					MyGui.GeneralGUI.EGO:WaitForChild("ego").Value = MyGui.GeneralGUI.EGO:WaitForChild("ego").Value + 100
				end
			end
		end)
	end
end

if hookmetamethod and not HMMLoaded then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/g0atku/scripts/main/Locked/HMM.lua'))()
	repeat task.wait() until HMMLoaded
end

if PlaceId == 13705109069 then
	if isfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json') then
		local success, decoded = pcall(Http.JSONDecode, Http, readfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json'))
		if success then
			for task, amount in pairs(decoded) do
				if task == 'SCORE' then
					for i = 1, amount do
						game:GetService("ReplicatedStorage").Tasks.Goal:FireServer()
					end
				elseif task == 'BLOCK' then
					for i = 1, amount do
						game:GetService("ReplicatedStorage").Tasks.Block:FireServer()
					end
				elseif task == 'STEAL' then
					for i = 1, amount do
						game:GetService("ReplicatedStorage").Tasks.Steal:FireServer()
					end
				elseif task == 'WIN' then
					for i = 1, amount do
						game:GetService("ReplicatedStorage").Tasks.Win:FireServer()
					end
				elseif task == 'TACKLE' then
					for i = 1, amount do
						game:GetService("ReplicatedStorage").Tasks.Tackle:FireServer()
					end
				end
			end
			Library:Notify('Tasks have been completed')
		end
	end
elseif PlaceId == 12276235857 then
	if isfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json') then
		local success, decoded = pcall(Http.JSONDecode, Http, readfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json'))
		if success then
			for i = 1, 5 do
				game:GetService("ReplicatedStorage").Tasks.RedeemAward:FireServer(i)
			end
			delfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json')
			Library:Notify('Tasks have been redeemed')
		else
			Library:Notify('Failed to redeem tasks')
		end
	end
end

function TraitStack()
	if HMMLoaded then
		local nttable = {}
		for trait,_ in pairs(Options.TraitStackDropdown.Value) do
			if not MyPlayer.Backpack.Trait:FindFirstChild(trait) then
				local strait = game:GetService('ReplicatedStorage'):WaitForChild('Specs'):WaitForChild('Traits')[trait]:Clone()
				strait.Parent = MyPlayer.Backpack.Trait
			end
			table.insert(nttable, trait)
		end
		for _,trait in pairs(game:GetService('ReplicatedStorage'):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
			if MyPlayer.Backpack.Trait:FindFirstChild(trait.Name) and not table.find(nttable, trait.Name) then
				MyPlayer.Backpack.Trait:FindFirstChild(trait.Name):Destroy()
			end
		end
		if not MyPlayer.Backpack.Trait:FindFirstChild(orgTrait) then
			local strait = game:GetService('ReplicatedStorage'):WaitForChild('Specs'):WaitForChild('Traits')[orgTrait]:Clone()
			strait.Parent = MyPlayer.Backpack.Trait
		end
		if MyPlayer.Backpack.Trait:FindFirstChild('Bunnys') then
			MyHum.JumpHeight = 10.5
		elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
			MyHum.JumpHeight = 9.5
		else
			MyHum.JumpHeight = 8.5
		end
		if orgTrait ~= 'LongStrides' and orgTrait ~= 'Athlete' then
			if MyPlayer.Backpack.Trait:FindFirstChild('LongStrides') then
				if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
					MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 2)
				end
			elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
				if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
					MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 1)
				end
			else
				MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value)
			end
		end
		MyGui.GeneralGUI.cooldowns.Trait.TextLabel.Text = orgTraitText
		MyGui.GeneralGUI.cooldowns.TraitKeybind.TextLabel.Text = orgTraitKBText
	else
		local oldbp = MyPlayer.Backpack
		local newbp = MyPlayer.Backpack:Clone()
		for _,trait in pairs(newbp.Trait:GetChildren()) do
			if trait then trait:Destroy() end
		end
		for trait,_ in pairs(Options.TraitStackDropdown.Value) do
			if not newbp.Trait:FindFirstChild(trait) then
				local strait = game:GetService('ReplicatedStorage'):WaitForChild('Specs'):WaitForChild('Traits')[trait]:Clone()
				strait.Parent = newbp.Trait
			end
		end
		if not newbp.Trait:FindFirstChild(orgTrait) then
			local strait = game:GetService('ReplicatedStorage'):WaitForChild('Specs'):WaitForChild('Traits')[orgTrait]:Clone()
			strait.Parent = newbp.Trait
		end
		if newbp.Trait:FindFirstChild('Bunnys') then
			MyHum.JumpHeight = 10.5
		elseif newbp.Trait:FindFirstChild('Athlete') then
			MyHum.JumpHeight = 9.5
		else
			MyHum.JumpHeight = 8.5
		end
		if orgTrait ~= 'LongStrides' and orgTrait ~= 'Athlete' then
			if newbp.Trait:FindFirstChild('LongStrides') then
				if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
					MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 2)
				end
			elseif newbp.Trait:FindFirstChild('Athlete') then
				if MyChar:GetAttribute('SPRINTSPEED') == MyChar.Specs.OrgSprintSpeed.Value then
					MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value + 1)
				end
			else
				MyChar:SetAttribute('SPRINTSPEED', MyChar.Specs.OrgSprintSpeed.Value)
			end
		end
		newbp.Parent = MyPlayer
		oldbp:Destroy()
		MyGui.GeneralGUI.cooldowns.Trait.TextLabel.Text = orgTraitText
		MyGui.GeneralGUI.cooldowns.TraitKeybind.TextLabel.Text = orgTraitKBText
	end
end

if PlaceId ~= 12276235857 then
	if PlaceId == 13705109069 then
		MyChar.RankSystem.GainingElo.Value = math.huge
		MyChar.RankSystem.GainingElo:GetPropertyChangedSignal('Value'):Connect(function()
			if MyChar.RankSystem.GainingElo.Value < 1000 then
				MyChar.RankSystem.GainingElo.Value = math.huge
			end
		end)
	end
end

--[[local args = {
    [1] = "FINGERPWNZ (2V2) NO GK"}
game:GetService("ReplicatedStorage").JoinLobby:InvokeServer(unpack(args))
local args = {
    [1] = "FINGERPWNZ (2V2) NO GK",
    [2] = "Red"
}
game:GetService("ReplicatedStorage").InLobbyStuff.JoinTeam:InvokeServer(unpack(args))
local args = {
    [1] = "FINGERPWNZ (2V2)",
    [2] = "Striker"}
game:GetService("ReplicatedStorage").InLobbyStuff.SelectPosition:InvokeServer(unpack(args))
local args = {
    [1] = "FINGERPWNZ (2V2) NO GK"}
game:GetService("ReplicatedStorage").InLobbyStuff.LeaveLobby:FireServer(unpack(args))
local args = {
    [1] = "FINGERPWNZ (2V2) NO GK",
    [2] = 3, -- gamemode (1-[4v4], 2-[3v3], 3-[2v2], 4-[1v1])
    [3] = 1, -- players
    [4] = true, -- weapons
    [5] = false -- gk
}
game:GetService("ReplicatedStorage").CreateGame:FireServer(unpack(args))]]

local Weapons = {}
local Traits = {}
local ShowOffTraits = {}
local IHeights = {'5.3','5.4','5.5','5.6','5.7','5.8','5.9','5.10','5.11','6.0','6.1','6.2','6.3'}
local Heights = {
	['5.3'] = 1,
	['5.4'] = 2,
	['5.5'] = 3,
	['5.6'] = 4,
	['5.7'] = 5,
	['5.8'] = 6,
	['5.9'] = 7,
	['5.10'] = 8,
	['5.11'] = 9,
	['6.0'] = 10,
	['6.1'] = 11,
	['6.2'] = 12,
	['6.3'] = 13
}
local IFaces = {}
local Faces = {}
local Flows = {}
local Buffs = {"speed", "power", "hitbox", "cooldown", "stamina"}
game:GetService("ReplicatedStorage").Specs.Traits.Unbreakable.Value = true
Traits = {'Athlete','Bunnys','LongStrides', 'Clamps','Diver','Egoist','NoLook','QuickDraw','Surf','Unbreakable'}
if HMMLoaded or orgWeapon.Name == 'Formless' then
	table.insert(Traits, 'Consistent')
end
for _, weapon in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):GetChildren()) do
	if weapon:GetAttribute('type') == 'weapon' and (weapon:GetAttribute('rarity') == 'common') then
		table.insert(Weapons, weapon.Name)
	end
end
for _, weapon in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):GetChildren()) do
	if weapon:GetAttribute('type') == 'weapon' and (weapon:GetAttribute('rarity') == 'rare') then
		table.insert(Weapons, weapon.Name)
	end
end
for _, weapon in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):GetChildren()) do
	if weapon:GetAttribute('type') == 'weapon' and (weapon:GetAttribute('rarity') == 'exotic') then
		table.insert(Weapons, weapon.Name)
	end
end
for _, weapon in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):GetChildren()) do
	if weapon:GetAttribute('type') == 'weapon' and (weapon:GetAttribute('rarity') == 'legendary') then
		table.insert(Weapons, weapon.Name)
	end
end
for _, weapon in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):GetChildren()) do
	if weapon:GetAttribute('type') == 'weapon' and (weapon:GetAttribute('rarity') == 'unique') then
		table.insert(Weapons, weapon.Name)
	end
end
for _, trait in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
	if trait:GetAttribute('type') == 'trait' and (trait:GetAttribute('rarity') == 'common') then
		table.insert(ShowOffTraits, trait.Name)
	end
end
for _, trait in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
	if trait:GetAttribute('type') == 'trait' and (trait:GetAttribute('rarity') == 'rare') then
		table.insert(ShowOffTraits, trait.Name)
	end
end
for _, trait in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
	if trait:GetAttribute('type') == 'trait' and (trait:GetAttribute('rarity') == 'exotic') then
		table.insert(ShowOffTraits, trait.Name)
	end
end
for _, trait in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
	if trait:GetAttribute('type') == 'trait' and (trait:GetAttribute('rarity') == 'legendary') then
		table.insert(ShowOffTraits, trait.Name)
	end
end
for _, trait in pairs(game:GetService("ReplicatedStorage"):WaitForChild('Specs'):WaitForChild('Traits'):GetChildren()) do
	if trait:GetAttribute('type') == 'trait' and (trait:GetAttribute('rarity') == 'exclusive') then
		table.insert(ShowOffTraits, trait.Name)
	end
end
for _, face in pairs(workspace.Heads:GetChildren()) do
	if face:IsA('Part') then
		IFaces[face.Decal.Texture] = face.Name
		Faces[face.Name] = face.Decal.Texture
	end
end
for _,flow in pairs(game:GetService("ReplicatedStorage").FlowTypes.FlowValues:GetChildren()) do
	table.insert(Flows, flow.Name)
end
local HBES = {'M2','GK'}
local orgYen = MyChar.RankSystem.Yen.Value
local m2hitbox
local cbhitbox
local headerhitbox
local tacklehitbox
local gkdivehitbox
local gkrushhitbox
local gktakehitbox
task.spawn(function()
	repeat task.wait()
		for i,v in pairs(workspace:GetChildren()) do 
			if v.Name == 'ReferencePart' and v.Size == Vector3.new(30,15,30) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
				m2hitbox = v
			end
		end
	until m2hitbox
end)
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(9,9,9) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
		cbhitbox = v
	end
end
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(8,8,8) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
		headerhitbox = v
	end
end
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(10,5,13) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
		tacklehitbox = v
	end
end
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(11,6.5,13) and v:FindFirstChild('Weld') and v:WaitForChild('Weld').Part1 == MyHRP then
		gkdivehitbox = v
	end
end
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(13,6.5,16) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
		gkrushhitbox = v
	end
end
for i,v in pairs(workspace:GetChildren()) do 
	if v.Name == 'ReferencePart' and v.Size == Vector3.new(7,7,7) and v:FindFirstChild('WeldConstraint') and v:WaitForChild('WeldConstraint').Part1 == MyHRP then
		gktakehitbox = v
	end
end

function GetAura()
	return {MyChar.AuraColour.Red.Value, MyChar.AuraColour.Green.Value, MyChar.AuraColour.Blue.Value}
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
function IsBallOwned(ball)
	if ball:GetAttribute('player') == MyPlayer.Name or ball:GetAttribute('iframes') == 'none' then
		return false
	else
		return true
	end
end
function script2dribble()
	if GetClosestBall() then
		local keys = {
			[Enum.KeyCode.W] = MyHRP.CFrame.lookVector,
			[Enum.KeyCode.A] = -MyHRP.CFrame.RightVector,
			[Enum.KeyCode.S] = -MyHRP.CFrame.lookVector,
			[Enum.KeyCode.D] = MyHRP.CFrame.RightVector
		}
		local direction = MyHRP.CFrame.lookVector
		local v1 = (-1 / 0)
		local getkey
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction = MyHRP.CFrame.lookVector
			getkey = Enum.KeyCode.W
		else
			for key, vec in pairs(keys) do
				if UserInputService:IsKeyDown(key) then
					local v2 = vec:Dot(MyHRP.Velocity.Unit)
					if v1 < v2 then
						getkey = key
						v1 = v2
					end
				end
			end
		end
		if getkey then
			direction = keys[getkey]
		end
		local pos
		if (GetClosestBall().CFrame.p-MyHRP.CFrame.p).Magnitude > 18 then
			pos = MyHRP.Position + (((GetClosestBall().CFrame.p-MyHRP.CFrame.p).Unit) * ((getgenv().DribbleHBE-1)*18))
		else
			pos = MyHRP.Position
		end
		game:GetService("ReplicatedStorage"):WaitForChild("Dribble"):FireServer(direction, MyHRP.Velocity.Magnitude, pos)
	end
end
local chestbumpanim = Instance.new("Animation")
chestbumpanim.AnimationId = "rbxassetid://12933738311"
local chestbumpanimation = MyHum:LoadAnimation(chestbumpanim)
local dribblecd = false
local chestbumpcd = false
local dribblestyle = 1
UserInputService.InputBegan:Connect(function(key, a1)
	if not a1 then
        if key.KeyCode == Enum.KeyCode.One then
            if dribblestyle == 1 then
                dribblestyle = 3
                MyGui.GeneralGUI.middle.DribbleStyle.Text = "STRAIGHT DRIBBLE"
                return
            end
            if dribblestyle == 3 then
                dribblestyle = 1
                MyGui.GeneralGUI.middle.DribbleStyle.Text = "DIRECTIONAL DRIBBLE"
            end
        end
    end
end)
function dribble()
	if MyHum.FloorMaterial == Enum.Material.Air and not chestbumpcd then
		dribblecd = true
		chestbumpcd = true
		game.ReplicatedStorage.ChestBump:FireServer(MyHRP.CFrame.LookVector, MyHRP.Velocity.Magnitude, MyChar:GetAttribute('HEIGHT'), (MyPlayer.Backpack:FindFirstChild('Metavision') and MyPlayer.Backpack:WaitForChild('Metavision').Value))
		chestbumpanimation:Play()
		task.delay(getgenv().CBIntoDribbleDelay, function() dribblecd = false end)
		task.delay(1, function() chestbumpcd = false end)
	elseif not dribblecd then
		dribblecd = true
		if dribblestyle == 1 then
			script2dribble()
		elseif GetClosestBall() then
			local pos
			if (GetClosestBall().CFrame.p-MyHRP.CFrame.p).Magnitude > 18 then
				pos = MyHRP.Position + (((GetClosestBall().CFrame.p-MyHRP.CFrame.p).Unit) * ((getgenv().DribbleHBE-1)*18))
			else
				pos = MyHRP.Position
			end
			game:GetService("ReplicatedStorage"):WaitForChild("Dribble"):FireServer(MyHRP.CFrame.lookVector, MyHRP.Velocity.Magnitude, pos)
		end
		task.wait(getgenv().DribbleDelay)
		dribblecd = false
	end
end
local kickcd = false
function kick(dir)
	if GetClosestBall() then
		if not kickcd then
			kickcd = true
			local isOwned = IsBallOwned(GetClosestBall())
			local isLL = false
			local isClamps = false
			local isMV = false
			local isNL = false
			if MyPlayer.Backpack:FindFirstChild('LongLegs') then
				isLL = true
			end
			if MyPlayer.Backpack.Trait:FindFirstChild('Clamps') then
				isClamps = true
			end
			if (MyPlayer.Backpack.Trait:FindFirstChild('Metavision') and MyPlayer.Backpack.Trait:WaitForChild('Metavision').Value) then
				isMV = true
			end
			if MyPlayer.Backpack.Trait:FindFirstChild('NoLook') then
				isNL = true
			end
			local args = {
				[1] = dir,
				[2] = MyChar:GetAttribute('KICKPOWER') * (1+MyGui.GeneralGUI.CurrentPower.PWR.Value),
				[3] = false, --IsKunigami
				[4] = true, --isFullyCharged
				[5] = isOwned,
				[6] = false, --IsDirectShot
				[7] = false, --IsRiptide
				[9] = isMV,
				[10] = Color3.new(GetAura()[1],GetAura()[2],GetAura()[3]),
				[11] = MyChar:GetAttribute('HEIGHT'),
				[12] = isLL,
				[13] = isClamps,
				[14] = false, --IsInAir
				[15] = false, --IsEmperor
				[16] = false, --IsDragonDrive
				[17] = false, --IsGoldenZone
				[18] = false, --IsAmbidextor
				[20] = false, --IsKingShot
				[22] = math.huge,
				[23] = true --IsNoLook
			}					
			game:GetService("ReplicatedStorage").shoot:FireServer(unpack(args))
			task.delay(0.185, function() kickcd = false end)
		end
	end
end

CollectionService:GetInstanceAddedSignal('JumpFatigue'):Connect(function(obj)
	if getgenv().NoJumpFatigue and obj == MyChar then
		MyChar:RemoveTag("JumpFatigue")
	end
end)

if MyGui:FindFirstChild('Tint') then
	MyGui.Tint.tint:GetPropertyChangedSignal('Visible'):Connect(function()
		if getgenv().IsMetavisionTint then
			MyGui.Tint.tint.Visible = false
		end
	end)
end

task.spawn(function()
	while task.wait() do
		if getgenv().AutoSlideTackle and MyChar.IsSliding.Value and GetClosestBall() and findAnimation(MyPlayer, '12994376714') then
			while getgenv().AutoSlideTackle and MyChar.IsSliding.Value and GetClosestBall() and not (GetClosestBall():GetAttribute('player') == MyPlayer.Name and GetClosestBall():GetAttribute('breakkick')) and not Library.Unloaded do
				if GetClosestBall() and tacklehitbox then
					local direction = (tacklehitbox.CFrame.p-GetClosestBall().CFrame.p).Unit
					kick(direction)
				end
				task.wait()
			end
			if (GetClosestBall() and GetClosestBall():GetAttribute('player') == MyPlayer.Name) then
				task.delay(0.2, function() 
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0
				end)
				if MyGui.GeneralGUI.CurrentPower.PWR.Value > 0 then
					if findAnimation(MyPlayer, '13082657041') then
						rm2animation:Play()
						findAnimation(MyPlayer, '13082657041'):Stop()
					elseif findAnimation(MyPlayer, '16013414452') then
						lm2animation:Play()
						findAnimation(MyPlayer, '16013414452'):Stop()
					end
				else
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0.01
					if orgTrait == 'Ambidextrous' and not MyGui.GeneralGUI.cooldowns.traitcd.TextLabel.Visible then
						if math.random(0,1) == 0 then
							rm2animation:Play()
						else
							lm2animation:Play()
						end
					else
						rm2animation:Play()
					end
				end
			end
			repeat task.wait() until not MyChar.IsSliding.Value
		end
		if Library.Unloaded then break end
	end
end)
function GetM2Direction()
	if getgenv().M2Clear == 'Cursor' then
		return MyPlayer:GetMouse().Hit.LookVector
	elseif getgenv().M2Clear == 'Ground' then
		return Vector3.new(0,-1,0)
	elseif getgenv().M2Clear == 'Sky' then
		return Vector3.new(MyPlayer:GetMouse().Hit.LookVector.X,0.5,MyPlayer:GetMouse().Hit.LookVector.Z)
	end
end
task.spawn(function()
	while task.wait() do
		if getgenv().IsAutoM2 and (GetClosestBall() and GetClosestBall():GetAttribute('player') ~= MyPlayer.Name) and not isSaving and not isHoldingBall then
			while getgenv().IsAutoM2 and not (GetClosestBall() and GetClosestBall():GetAttribute('player') == MyPlayer.Name) and not isSaving and not isHoldingBall and not Library.Unloaded do
				if GetClosestBall() then
					if not MyHRP:FindFirstChild('IsTackling') then
						local IsTackling = Instance.new("StringValue", MyHRP)
						IsTackling.Name = "IsTackling"
					end
					kick(GetM2Direction())
				end
				task.wait()
			end
			if MyHRP:FindFirstChild('IsTackling') then
				if not MyChar.IsSliding.Value then
					MyHRP:WaitForChild('IsTackling'):Destroy()
				end
			end
			if (GetClosestBall() and GetClosestBall():GetAttribute('player') == MyPlayer.Name) then
				task.delay(0.2, function() 
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0
				end)
				if MyGui.GeneralGUI.CurrentPower.PWR.Value > 0 then
					if findAnimation(MyPlayer, '13082657041') then
						rm2animation:Play()
						findAnimation(MyPlayer, '13082657041'):Stop()
					elseif findAnimation(MyPlayer, '16013414452') then
						lm2animation:Play()
						findAnimation(MyPlayer, '16013414452'):Stop()
					end
				else
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0.01
					if orgTrait == 'Ambidextrous' and not MyGui.GeneralGUI.cooldowns.traitcd.TextLabel.Visible then
						if math.random(0,1) == 0 then
							rm2animation:Play()
						else
							lm2animation:Play()
						end
					else
						rm2animation:Play()
					end
				end
			end
		end
		if Library.Unloaded then break end
	end
end)


--game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "BlockL", true, false, true, true)
--game.ReplicatedStorage:WaitForChild("GK"):WaitForChild("Goalie"):FireServer(MyHRP.CFrame.lookVector * 85 + Vector3.new(0, 80, 0), "Gagamaru", true, false, true, true)
--game.ReplicatedStorage.GK.GKDive:FireServer(MyHRP.CFrame.lookVector*140, MyChar)

--Player Functions
function SpinNotify(wwebhook,drop,time,yen,tries)
	local vevolog = request({
		Url = wwebhook,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = Http:JSONEncode({
			["content"] = "@everyone",
			["embeds"] = {{
				["title"] = "**Vevo Hub | Locked Auto Spin**",
				["description"] = '',
				["type"] = "rich",
				["color"] = tonumber(0xffffff),
				["thumbnail"] = {
					["url"] = 'https://i.imgur.com/8VP0kS9.png'
				},
				["fields"] = {
					{
						["name"] = "USER: "..MyPlayer.Name,
						["value"] = '',
						["inline"] = false
					},
					{
						["name"] = "YOU GOT: "..tostring(drop),
						["value"] = '',
						["inline"] = false
					},
					{
						["name"] = "SECONDS SPENT: "..tostring(time),
						["value"] = '',
						["inline"] = false
					},
					{
						["name"] = "YEN SPENT: "..tostring(yen),
						["value"] = '',
						["inline"] = false
					},
					{
						["name"] = "TRIES TOOK: "..tostring(tries),
						["value"] = '',
						["inline"] = false
					}
				}
			}}
		})
	})
end
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

local formanim = Instance.new("Animation")
formanim.AnimationId = "rbxassetid://13857940523"
local formanimation = MyHum:LoadAnimation(formanim)
function weaponcooldownbuff(cd)
    local getcd
    if workspace:FindFirstChild("TrainingMode") then
        getcd = (workspace.TrainingMode.Value == true and 0) or cd
    else
        getcd = cd
    end
    if MyPlayer.Backpack.Trait:FindFirstChild("Consistent") then
        getcd = getcd - (getcd * 0.15)
    end
    if MyChar.AuraColour.Buff.Value == "cooldown" then
        local cdbuff = getcd * (MyChar.AuraColour.Buff:GetAttribute("BuffValue") / 10)
        if MyChar:HasTag("CooldownBuff") then
            cdbuff = cdbuff * 2
        end
        getcd = getcd - cdbuff
    end
    return getcd
end
function weaponcooldown(cd)
    MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Visible = false
    MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Visible = false
    MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Parent.BackgroundTransparency = 0
    if MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible == false then
        MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible = true
        local t = tick()
        local cdcon
        cdcon = RunService.RenderStepped:Connect(function()
            local leftcd = cd - (tick() - t)
            MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Text = "(" .. string.format("%.1f", leftcd) .. ")/s"
            if leftcd <= 0 then
                MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible = false
                MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Visible = true
                MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Visible = true
                MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Parent.BackgroundTransparency = 1
                cdcon:Disconnect()
            end
        end)
    end
end
function Formless()
	if MyPlayer.Backpack:FindFirstChild("Formless") and not MyGui.GeneralGUI.cooldowns.Weaponcd.TextLabel.Visible then
		if getgenv().IsAutoFormless and GetClosestBall() then
			local pos = MyHRP.CFrame.p-Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X,0,workspace.CurrentCamera.CFrame.LookVector.Z)
			MyHRP.CFrame = CFrame.new(MyHRP.CFrame.p, pos)
			MyHum.AutoRotate = false
			task.delay(0.2, function() 
				MyGui.GeneralGUI.CurrentPower.PWR.Value = 0
			end)
			if MyGui.GeneralGUI.CurrentPower.PWR.Value > 0 then
				if findAnimation(MyPlayer, '13082657041') then
					rm2animation:Play()
					findAnimation(MyPlayer, '13082657041'):Stop()
				elseif findAnimation(MyPlayer, '16013414452') then
					lm2animation:Play()
					findAnimation(MyPlayer, '16013414452'):Stop()
				end
			else
				MyGui.GeneralGUI.CurrentPower.PWR.Value = 0.01
				if orgTrait == 'Ambidextrous' and not MyGui.GeneralGUI.cooldowns.traitcd.TextLabel.Visible then
					if math.random(0,1) == 0 then
						rm2animation:Play()
					else
						lm2animation:Play()
					end
				else
					rm2animation:Play()
				end
			end
			kick((MyHRP.CFrame.p-GetClosestBall().CFrame.p).Unit)
			MyHum:ChangeState(Enum.HumanoidStateType.Jumping)
			local power = game.ReplicatedStorage.Values.KickPower.Value + ((getgenv().FormlessPowerMulti-1) * 24)
			print(power)
			game.ReplicatedStorage.SpecEvents.Formless:FireServer(MyHRP.CFrame.lookVector, power)
			formanimation:Play()
			task.wait(0.8)
			MyHum.AutoRotate = true
		else
			MyHum.AutoRotate = false
			MyHum:ChangeState(Enum.HumanoidStateType.Jumping)
			local power = game.ReplicatedStorage.Values.KickPower.Value + ((getgenv().FormlessPowerMulti-1) * 24)
			print(power)
			game.ReplicatedStorage.SpecEvents.Formless:FireServer(MyHRP.CFrame.lookVector, power)
			formanimation:Play()
			task.wait(0.8)
			MyHum.AutoRotate = true
		end
	end
end
if game.ReplicatedStorage:FindFirstChild('SpecEvents') then
	game.ReplicatedStorage.SpecEvents.Formless.OnClientEvent:Connect(function(cd)
		weaponcooldown(weaponcooldownbuff(cd))
		if cd == 150 then
			local highlight = MyChar:FindFirstChild("AnimeHighlight")
			highlight.FillColor = Color3.new(0, 0, 0)
			highlight.FillTransparency = 0
			game.Lighting.ColorCorrection.Brightness = 1
			task.wait(0.05)
			game.Lighting.ColorCorrection.Brightness = -1
			local highlight = MyChar:FindFirstChild("AnimeHighlight")
			highlight.FillColor = Color3.new(1, 1, 1)
			highlight.FillTransparency = 0
			task.wait(0.07)
			local highlight = MyChar:FindFirstChild("AnimeHighlight")
			highlight.FillColor = Color3.new(0, 0, 0)
			highlight.FillTransparency = 0
			game.Lighting.ColorCorrection.Brightness = 1
			task.wait(0.05)
			game.Lighting.ColorCorrection.Brightness = 0.1
			local highlight = MyChar:FindFirstChild("AnimeHighlight")
			highlight.FillColor = Color3.new(0, 0, 0)
			highlight.FillTransparency = 0
			highlight.FillTransparency = 1
		end
	end)
end

--Auto functions
if PlaceId ~= 12276235857 then
	Sections.Weapons:AddSlider('FormPWRSlider', {
		Text = 'Formless Power Multi',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			getgenv().FormlessPowerMulti = Multi
		end
	})
	Sections.Weapons:AddToggle('AutoFormlessToggle', {
		Text = 'Auto Formless',
		Default = false,
		Tooltip = 'Enables Auto Formless',
		Callback = function(Value)
			getgenv().IsAutoFormless = Value
		end
	})
	Sections.Weapons:AddLabel('Formless'):AddKeyPicker('Formless', {
		Default = 'R',
		Mode = 'Toggle',
		NoUI = true,
		Callback = function(Value)
			Formless()
		end
	})
	Sections.Weapons:AddToggle('LongLegsToggle', {
		Text = 'LongLegs',
		Default = false,
		Tooltip = 'Enables LongLegs',
		Callback = function(Value)
			if Value then
				if not MyPlayer.Backpack:FindFirstChild('LongLegs') then
					local ll = game:GetService("ReplicatedStorage").Specs.LongLegs:Clone()
					ll.Parent = MyPlayer.Backpack
					MyGui.GeneralGUI.cooldowns.Weapon.TextLabel.Text = orgWeaponText
					MyGui.GeneralGUI.cooldowns.WeaponKeybind.TextLabel.Text = orgWeaponKBText
				end
			else
				if MyPlayer.Backpack:FindFirstChild('LongLegs') then
					MyPlayer.Backpack:WaitForChild('LongLegs'):Destroy()
				end
			end
		end
	})
	if HMMLoaded then
		Sections.Weapons:AddSlider('CurveMultiSlider', {
			Text = 'Riptide Curve',
			Default = 1,
			Min = 0,
			Max = 2,
			Rounding = 2,
			Compact = false,
			Callback = function(Multi)
				getgenv().CurveMulti = Multi
			end
		})
		Sections.Weapons:AddToggle('RiptideCurveToggle', {
			Text = 'Riptide Curve',
			Default = false,
			Tooltip = 'Boosts your riptide curve',
			Callback = function(Value)
				getgenv().IsRiptideCurve = Value
			end
		})
	end
	Sections.Traits:AddLabel('Metavision Color'):AddColorPicker('MetavisionColorPicker', {
		Default = Color3.new(1, 1, 1),
		Title = 'Metavision Color',
		Transparency = 0, 
		Callback = function(color)
			getgenv().metacolor = color
		end
	})
	Sections.Traits:AddToggle('MetavisionTintToggle', {
		Text = 'Metavision Tint',
		Default = false,
		Tooltip = 'Removes Metavision Tint',
		Callback = function(Value)
			getgenv().IsMetavisionTint = Value
			if Value then
				MyGui.Tint.tint.Visible = false
			end
		end
	})
	Sections.Traits:AddToggle('MetavisionToggle', {
		Text = 'Metavision',
		Default = false,
		Tooltip = 'See where the ball lands',
		Callback = function(Value)
			if Value then
				mvcon = RunService.RenderStepped:Connect(function()
					for _, ball in pairs(workspace.BallFolder:GetChildren()) do
						if ball.Name == "Ball" then
							local MVLandPart
							if ball:FindFirstChild("MetavisionLandingPart") then
								MVLandPart = ball:FindFirstChild("MetavisionLandingPart")
								MVLandPart.Color = getgenv().metacolor
							else
								MVLandPart = Instance.new("Part")
								MVLandPart.Name = "MetavisionLandingPart"
								MVLandPart.Shape = Enum.PartType.Cylinder
								MVLandPart.Size = Vector3.new(0.001,ball.Size.X^2,ball.Size.X^2)
								MVLandPart.Color = getgenv().metacolor
								MVLandPart.Transparency = 0
								MVLandPart.CanCollide = false
								MVLandPart.Anchored = true
								MVLandPart.Parent = ball
							end
							local BallVel = ball.AssemblyLinearVelocity
							local BallPos = ball.Position
							local Gravity = 0.5 * (-workspace.Gravity)
							local d = BallVel.Y^2 - 4 * Gravity * BallPos.Y
							local x1 = (-(BallVel.Y) + math.sqrt(d)) / (2 * Gravity)
							local x2 = (-(BallVel.Y) - math.sqrt(d)) / (2 * Gravity)
							if x1 < x2 then
								x1 = x2
							end
							local LandPos = BallPos + (BallVel * x1)
							MVLandPart.CFrame = CFrame.new(Vector3.new(LandPos.X, 1.1, LandPos.Z)) * CFrame.Angles(0, 0, 1.5707963267948966)
						end
					end
					if Library.Unloaded then
						mvcon:Disconnect()
						for _, ball in pairs(workspace.BallFolder:GetChildren()) do
							if ball.Name == "Ball" then
								if ball:FindFirstChild('MetavisionLandingPart') then
									ball:WaitForChild('MetavisionLandingPart'):Destroy()
								end
							end
						end
					end
				end)
			else
				mvcon:Disconnect()
				for _, ball in pairs(workspace.BallFolder:GetChildren()) do
					if ball.Name == "Ball" then
						if ball:FindFirstChild('MetavisionLandingPart') then
							ball:WaitForChild('MetavisionLandingPart'):Destroy()
						end
					end
				end
			end
		end
	})
	Sections.Traits:AddDropdown('TraitStackDropdown', {
		Values = Traits,
		Default = 0,
		Multi = true,
		Text = 'Trait stack',
		Tooltip = 'Choose traits you want to stack',
		Callback = function(ttable)
		end
	})
	Options.TraitStackDropdown:OnChanged(TraitStack)
	Sections.Traits:AddDropdown('ShowOffTraitDropdown', {
		Values = ShowOffTraits,
		Default = orgTrait,
		Multi = false,
		Text = 'Show Off Trait',
		Tooltip = 'Choose trait you want to be shown on your screen',
		Callback = function(trait)
			orgTraitText = trait:upper()
			MyGui.GeneralGUI.cooldowns.Trait.TextLabel.Text = orgTraitText
			if game:GetService("ReplicatedStorage").Specs.Traits[trait]:GetAttribute('activational') then
				orgTraitKBText = '(T)'
			else
				orgTraitKBText = '(PASSIVE)'
			end
			MyGui.GeneralGUI.cooldowns.TraitKeybind.TextLabel.Text = orgTraitKBText
		end
	})
	Sections.Physical:AddToggle('NoJumpFatigueToggle', {
		Text = 'NoJumpFatigue',
		Default = false,
		Tooltip = 'Removes Jump Fatigue',
		Callback = function(Value)
			getgenv().NoJumpFatigue = Value
			if Value and MyChar:HasTag('JumpFatigue') then
				MyChar:RemoveTag("JumpFatigue")
			end
		end
	})
	Sections.Physical:AddSlider('JumpCDSlider', {
		Text = 'Jump CD',
		Default = 1.5,
		Min = 0,
		Max = 1.5,
		Rounding = 2,
		Compact = false,
		Callback = function(cd)
			getgenv().JumpCD = cd
		end
	})
	Sections.Physical:AddSlider('JumpFatigueCDSlider', {
		Text = 'Jump Fatigue CD',
		Default = 3,
		Min = 0,
		Max = 3,
		Rounding = 2,
		Compact = false,
		Callback = function(cd)
			getgenv().JumpFatigueCD = cd
		end
	})
	Sections.Physical:AddSlider('JumpSlider', {
		Text = 'Jump Boost',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 1,
		Compact = false,
		Callback = function(boost)
			getgenv().JumpBoost = 2 * (boost-1)
		end
	})
	Sections.Physical:AddSlider('SpeedSlider', {
		Text = 'Speed Multi',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			MyChar.Specs.OrgSprintSpeed.Value = orgSpeed + (2.4 * (Multi-1))
			MyChar:SetAttribute('SPRINTSPEED', orgSpeed + (2.4 * (Multi-1)))
			local speed = MyChar:GetAttribute('SPRINTSPEED')
			if MyPlayer.Backpack.Trait:FindFirstChild('LongStrides') then
				speed = speed + 2
			elseif MyPlayer.Backpack.Trait:FindFirstChild('Athlete') then
				speed = speed + 1
			end
			MyChar:SetAttribute('SPRINTSPEED', speed)
		end
	})
	Sections.Physical:AddSlider('SpeedBuffSlider', {
		Text = 'Speed Buff %',
		Default = tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue')) * 10,
		Min = 0,
		Max = 15,
		Rounding = 1,
		Compact = false,
		Callback = function(p)
			MyChar.AuraColour.Buff:SetAttribute('BuffValue', tostring(p/10))
		end
	})
	Sections.Physical:AddSlider('StaminaSlider', {
		Text = 'Stamina Multi',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			MyChar:SetAttribute('MAXSTAMINA', orgMaxStamina*Multi)
		end
	})
	Sections.Physical:AddSlider('StaminaGainSlider', {
		Text = 'Stamina Gain',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			getgenv().StaminaGain = Multi
		end
	})
	Sections.Physical:AddSlider('EgoGainSlider', {
		Text = 'Ego Gain %',
		Default = (100-MyGui.GeneralGUI.EGO.ego:GetAttribute('MaxSTAM')),
		Min = 0,
		Max = 99,
		Rounding = 0,
		Compact = false,
		Callback = function(gain)
			MyGui.GeneralGUI.EGO.ego:SetAttribute('MaxSTAM', (100-gain))
			getgenv().FlowGain = 5 + (5*(gain/100))
		end
	})
	Sections.Dribbling:AddSlider('DribbleHBESlider', {
		Text = 'Dribble HBE',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			getgenv().DribbleHBE = Multi
		end
	})
	Sections.Dribbling:AddSlider('DribbleDelaySlider', {
		Text = 'Dribble Delay',
		Default = 0.115,
		Min = 0,
		Max = 0.115,
		Rounding = 3,
		Compact = false,
		Callback = function(delay)
			getgenv().DribbleDelay = delay
		end
	})
	Sections.Dribbling:AddSlider('CBIntoDribbleDelaySlider', {
		Text = 'Chest Bump Into Dribble Delay',
		Default = 0.7,
		Min = 0,
		Max = 0.7,
		Rounding = 2,
		Compact = false,
		Callback = function(delay)
			getgenv().CBIntoDribbleDelay = delay
		end
	})
	Sections.Dribbling:AddLabel('Dribble'):AddKeyPicker('DribbleKeyBind', {
		Default = 'MB1',
		Mode = 'Toggle',
		NoUI = true,
		Callback = function(Value)
			dribble()
		end
	})
	task.spawn(function()
		while task.wait() do
			if Library.Unloaded then break end
			if Options.DribbleKeyBind.Mode == 'Hold' then
				if Options.DribbleKeyBind:GetState() then
					dribble()
				end
			elseif Options.DribbleKeyBind.Mode == 'Always' then
				dribble()
			end
		end
	end)
	local FlickHeight = 0
	local FlickThrough = 0
	Sections.Dribbling:AddSlider('FlickHeightSlider', {
		Text = 'Flick Height',
		Default = 0,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Compact = false,
		Callback = function(Height)
			FlickHeight = Height
		end
	})
	Sections.Dribbling:AddSlider('FlickThroughSlider', {
		Text = 'Flick Through',
		Default = 0,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Compact = false,
		Callback = function(through)
			FlickThrough = through
		end
	})
	Sections.Dribbling:AddToggle('AutoFlickToggle', {
		Text = 'Auto Flick',
		Default = false,
		Tooltip = 'Enables Auto Flick',
		Callback = function(Value)
			getgenv().IsAutoFlick = Value
		end
	})
	Sections.Dribbling:AddLabel('Flick'):AddKeyPicker('FlickToggleKeyBind', {
		Default = 'C',
		Mode = 'Toggle',
		NoUI = true,
		Callback = function(Value)
			if getgenv().IsAutoFlick and GetClosestBall() then
				local direction
				if ((MyHRP.CFrame.p+MyHum.MoveDirection)-GetClosestBall().CFrame.p).Magnitude > (MyHRP.CFrame.p-GetClosestBall().CFrame.p).Magnitude then
					direction = Vector3.new(MyHRP.CFrame.X,MyHRP.CFrame.Y+FlickHeight,MyHRP.CFrame.Z) + (MyHum.MoveDirection*FlickThrough)
				else
					direction = Vector3.new(MyHRP.CFrame.X,MyHRP.CFrame.Y+FlickHeight,MyHRP.CFrame.Z)
				end
				task.delay(0.2, function() 
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0
				end)
				if MyGui.GeneralGUI.CurrentPower.PWR.Value > 0 then
					if findAnimation(MyPlayer, '13082657041') then
						rm2animation:Play()
						findAnimation(MyPlayer, '13082657041'):Stop()
					elseif findAnimation(MyPlayer, '16013414452') then
						lm2animation:Play()
						findAnimation(MyPlayer, '16013414452'):Stop()
					end
				else
					MyGui.GeneralGUI.CurrentPower.PWR.Value = 0.01
					if orgTrait == 'Ambidextrous' and not MyGui.GeneralGUI.cooldowns.traitcd.TextLabel.Visible then
						if math.random(0,1) == 0 then
							rm2animation:Play()
						else
							lm2animation:Play()
						end
					else
						rm2animation:Play()
					end
				end
				kick((direction-GetClosestBall().CFrame.p).Unit)
			end
		end
	})
	Sections.Defense:AddSlider('SlideTackleSlider', {
		Text = 'Slide Tackle Multi',
		Default = 1,
		Min = 1,
		Max = 2,
		Rounding = 2,
		Compact = false,
		Callback = function(Multi)
			getgenv().SlideTackleMulti = Multi
		end
	})
	Sections.Defense:AddToggle('AutoSlideTackleToggle', {
		Text = 'Auto SlideTackle',
		Default = false,
		Tooltip = 'Enables Auto SlideTackle',
		Callback = function(Value)
			getgenv().AutoSlideTackle = Value
		end
	})
	Sections.Defense:AddDropdown('M2ClearDropdown', {
		Values = {'Cursor','Ground','Sky'},
		Default = 1,
		Multi = false,
		Text = 'M2 Clear',
		Tooltip = 'Clears the ball to the chosen direction (made for auto M2)',
		Callback = function(Value)
			getgenv().M2Clear = Value		
		end
	})
	Sections.Defense:AddLabel('Auto M2'):AddKeyPicker('AutoM2ToggleKeyBind', {
		Default = 'X',
		Mode = 'Toggle',
		Text = 'Auto M2',
		NoUI = false,
		Callback = function(Value)
			getgenv().IsAutoM2 = Value
		end
	})
	Sections.Visual:AddDropdown('HitboxDropdown', {
		Values = {'None','M2 Hitbox','Chest Bump Hitbox','Header Hitbox','Tackle Hitbox','GK Dive Hitbox','GK Rush Hitbox','GK Take Hitbox'},
		Default = 1,
		Multi = false,
		Text = 'Show Hitboxes',
		Tooltip = 'Shows the chosen hitbox',
		Callback = function(hitbox)
			if hitbox == 'None' then
				if m2hitbox then m2hitbox.Transparency = 1 end
				if cbhitbox then cbhitbox.Transparency = 1 end
				if headerhitbox then headerhitbox.Transparency = 1 end
				if tacklehitbox then tacklehitbox.Transparency = 1 end
				if gkdivehitbox then gkdivehitbox.Transparency = 1 end
				if gkrushhitbox then gkrushhitbox.Transparency = 1 end
				if gktakehitbox then gktakehitbox.Transparency = 1 end
			elseif hitbox == 'M2 Hitbox' then
				if m2hitbox then
					m2hitbox.Material = Enum.Material.Neon
					m2hitbox.Transparency = 0.9
					if cbhitbox then cbhitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'Chest Bump Hitbox' then
				if cbhitbox then
					cbhitbox.Material = Enum.Material.Neon
					cbhitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'Header Hitbox' then
				if headerhitbox then
					headerhitbox.Material = Enum.Material.Neon
					headerhitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if cbhitbox then cbhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'Tackle Hitbox' then
				if tacklehitbox then
					tacklehitbox.Material = Enum.Material.Neon
					tacklehitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if cbhitbox then cbhitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'GK Dive Hitbox' then
				if gkdivehitbox then
					gkdivehitbox.Material = Enum.Material.Neon
					gkdivehitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if cbhitbox then cbhitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'GK Rush Hitbox' then
				if gkrushhitbox then
					gkrushhitbox.Material = Enum.Material.Neon
					gkrushhitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if cbhitbox then cbhitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gktakehitbox then gktakehitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			elseif hitbox == 'GK Take Hitbox' then
				if gktakehitbox then
					gktakehitbox.Material = Enum.Material.Neon
					gktakehitbox.Transparency = 0.9
					if m2hitbox then m2hitbox.Transparency = 1 end
					if cbhitbox then cbhitbox.Transparency = 1 end
					if headerhitbox then headerhitbox.Transparency = 1 end
					if tacklehitbox then tacklehitbox.Transparency = 1 end
					if gkdivehitbox then gkdivehitbox.Transparency = 1 end
					if gkrushhitbox then gkrushhitbox.Transparency = 1 end
				else
					Library:Notify('Failed to find '..hitbox..'hitbox')
				end
			end
		end
	})
end
if PlaceId ~= 12276235857 then
	Sections.Visual:AddToggle('HideYenToggle', {
		Text = 'Hide Yen',
		Default = false,
		Tooltip = 'Hides yen (useful if you have a lot of yen)',
		Callback = function(Value)
			if Value then
				MyChar.RankSystem.Yen.Value = math.random(100000, 1000000)
			else
				MyChar.RankSystem.Yen.Value = orgYen
			end
		end
	})
	Sections.Visual:AddToggle('BrighterGoalToggle', {
		Text = 'Brighter Goal',
		Default = false,
		Tooltip = 'Makes goal brighter',
		Callback = function(Value)
			if Value then
				for i,v in pairs(workspace.CrossbarHitbox:GetChildren()) do
					if not v:FindFirstChild('Bright') then
						v.Transparency = 0
						local hl = Instance.new('Highlight')
						hl.Name = 'Bright'
						hl.Parent = v
						hl.Adornee = v
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Enabled = true
						hl.FillColor = Color3.new(1,1,1)
						hl.FillTransparency = 0
						hl.OutlineColor = Color3.new(1,1,1)
						hl.OutlineTransparency = 0
					end
				end
			else
				for i,v in pairs(workspace.CrossbarHitbox:GetChildren()) do
					v.Transparency = 1
				end
			end
		end
	})
	Sections.Visual:AddLabel('Aura Color'):AddColorPicker('AuraColorPicker', {
		Default = Color3.new(GetAura()[1], GetAura()[2], GetAura()[3]),
		Title = 'Aura Color',
		Transparency = 0, 
		Callback = function(color)
			MyChar.AuraColour.Red.Value = color.R
			MyChar.AuraColour.Green.Value = color.G
			MyChar.AuraColour.Blue.Value = color.B
			MyChar.AnimeHighlight.OutlineColor = color
		end
	})
	table.insert(IgnoreIndexes, 'AuraColorPicker')
end
if PlaceId == 13705109069 then
	Sections.Visual:AddButton({
		Text = "Leave Autos",
		Func = function()
			game.ReplicatedStorage.winlosstie:FireServer('padb1',100,0)
			game.ReplicatedStorage.endgameyen:FireServer(100000)
			game.ReplicatedStorage.rankwin:FireServer(50)
		end,
		DoubleClick = false,
		Tooltip = 'Leaves autos with getting yen and elo'
	})
end
if PlaceId == 12276235857 then
	game:GetService("ReplicatedStorage").SendCode:FireServer('REVOLVER')
	game:GetService("ReplicatedStorage").SendCode:FireServer('EXCLUSIVE')
	game:GetService("ReplicatedStorage").SendCode:FireServer('BEAR')
	game:GetService("ReplicatedStorage").SendCode:FireServer('80KFAVOURITE')
	game:GetService("ReplicatedStorage").SendCode:FireServer('60MILVISITS')
	game:GetService("ReplicatedStorage").SendCode:FireServer('MOSTVISITEDBLGAME')
	local YenLabel = Sections.Spinning:AddLabel('Yen: '..tostring(MyChar.RankSystem.Yen.Value))
	MyChar.RankSystem.Yen:GetPropertyChangedSignal('Value'):Connect(function()
		YenLabel:SetText('Yen: '..tostring(MyChar.RankSystem.Yen.Value))
	end)
	Sections.Spinning:AddInput('DiscordWebhookTextbox', {
		Default = '',
		Numeric = false, 
		Finished = true,
		Text = 'Discord Webhook',
		Tooltip = 'Enter your discord webhook to recieve notifications from auto spinning (optional)', 
		Placeholder = 'Enter your webhook (optional)',
		MaxLength = 1000,
		Callback = function(webhook)
			if string.find(webhook, 'discord.com/api/webhooks') then
				getgenv().webhook = webhook
			else
				Library:Notify('Please enter valid discord webhook')
			end
		end
	})
	Sections.Spinning:AddDropdown('WeaponsDropdown', {
		Values = Weapons,
		Default = 0,
		Multi = true,
		Text = 'Weapons',
		Tooltip = 'Choose weapons that you want to get',
		Callback = function(weapons)			
		end
	})
	Sections.Spinning:AddDropdown('TraitsDropdown', {
		Values = ShowOffTraits,
		Default = 0,
		Multi = true,
		Text = 'Traits',
		Tooltip = 'Choose traits that you want to get',
		Callback = function(traits)			
		end
	})
	Sections.Spinning:AddDropdown('HeightsDropdown', {
		Values = IHeights,
		Default = 0,
		Multi = true,
		Text = 'Heights',
		Tooltip = 'Choose heights that you want to get',
		Callback = function(heights)			
		end
	})
	Sections.Spinning:AddDropdown('FacesDropdown', {
		Values = IFaces,
		Default = 0,
		Multi = true,
		Text = 'Faces',
		Tooltip = 'Choose faces that you want to get',
		Callback = function(faces)			
		end
	})
	Sections.Spinning:AddDropdown('FlowsDropdown', {
		Values = Flows,
		Default = 0,
		Multi = true,
		Text = 'Flows',
		Tooltip = 'Choose flows that you want to get',
		Callback = function(flows)			
		end
	})
	Sections.Spinning:AddSlider('BuffSlider', {
		Text = 'Buff %',
		Default = 0,
		Min = 0,
		Max = 15,
		Rounding = 1,
		Compact = false,
		Callback = function(p)
			if math.floor(p) ~= p then
				getgenv().buffp = (p/10)
			else
				getgenv().buffp = ((p-0.05)/10)
			end
		end
	})
	Sections.Spinning:AddDropdown('BuffsDropdown', {
		Values = Buffs,
		Default = 0,
		Multi = true,
		Text = 'Buff Type',
		Tooltip = 'Choose buff types that you want to get',
		Callback = function(buffs)			
		end
	})
	Sections.Spinning:AddSlider('FlowSlider', {
		Text = 'Black Flow %',
		Default = 0,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Compact = false,
		Callback = function(p)
			getgenv().blackf = 1-(1*(p/100))
			print(getgenv().blackf)
		end
	})
	Sections.Spinning:AddToggle('AutoSpinToggle', {
		Text = 'Auto Spin',
		Default = false,
		Tooltip = 'Starts spinning until you get things you want',
		Callback = function(Value)
			getgenv().IsAutoSpin = Value
			if getgenv().IsAutoSpin then
				local WWeapons = {}
				local WTraits = {}
				local WHeights = {}
				local WFaces = {}
				local WFlows = {}
				local WBuffs = {}
				for weapon,_ in pairs(Options.WeaponsDropdown.Value) do
					table.insert(WWeapons, weapon)
				end
				for trait,_ in pairs(Options.TraitsDropdown.Value) do
					table.insert(WTraits, trait)
				end
				for height,_ in pairs(Options.HeightsDropdown.Value) do
					table.insert(WHeights, Heights[height])
				end
				for face,_ in pairs(Options.FacesDropdown.Value) do
					table.insert(WFaces, Faces[face])
				end
				for flow,_ in pairs(Options.FlowsDropdown.Value) do
					table.insert(WFlows, flow)
				end
				for buff,_ in pairs(Options.BuffsDropdown.Value) do
					table.insert(WBuffs, buff)
				end
				task.spawn(function()
					if #WWeapons > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local WeaponCon
						local Count = 0
						local gweapon = (MyPlayer.Backpack:FindFirstChildWhichIsA('NumberValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('BoolValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('StringValue'))
						if not table.find(WWeapons, gweapon.Name) then
							WeaponCon = MyPlayer.Backpack.ChildAdded:Connect(function(weapon)
								Count = Count + 1
								if table.find(WWeapons, weapon.Name) then
									WeaponCon:Disconnect()
									Library:Notify('You got '..weapon.Name)
									if getgenv().webhook ~= '' then
										SpinNotify(getgenv().webhook,weapon.Name..' (WEAPON)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
									end
								else
									game:GetService("ReplicatedStorage").rerolls.specreroll:FireServer()
								end
								if not getgenv().IsAutoSpin then WeaponCon:Disconnect() end
							end)
							game:GetService("ReplicatedStorage").rerolls.specreroll:FireServer()
						else
							local gweapon = (MyPlayer.Backpack:FindFirstChildWhichIsA('NumberValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('BoolValue') or MyPlayer.Backpack:FindFirstChildWhichIsA('StringValue'))
							Library:Notify('You already have '..gweapon.Name)
						end
					end
				end)
				task.spawn(function()
					if #WTraits > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local TraitCon
						local Count = 0
						if not table.find(WTraits, MyPlayer.Backpack.Trait:GetChildren()[1].Name) then
							TraitCon = MyPlayer.Backpack.Trait.ChildAdded:Connect(function(trait)
								Count = Count + 1
								if table.find(WTraits, trait.Name) then
									TraitCon:Disconnect()
									Library:Notify('You got '..trait.Name)
									if getgenv().webhook ~= '' then
										SpinNotify(getgenv().webhook,trait.Name..' (TRAIT)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
									end
								else
									game:GetService("ReplicatedStorage").rerolls.traitreroll:FireServer()
								end
								if not getgenv().IsAutoSpin then TraitCon:Disconnect() end
							end)
							game:GetService("ReplicatedStorage").rerolls.traitreroll:FireServer()
						else
							Library:Notify('You already have '..MyPlayer.Backpack.Trait:GetChildren()[1].Name)
						end
					end
				end)
				task.spawn(function()
					if #WHeights > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local HeightCon
						local Count = 0
						if not table.find(WHeights, MyChar.HeightValue.Value) then
							HeightCon = MyChar.HeightValue:GetPropertyChangedSignal('Value'):Connect(function()
								Count = Count + 1
								if table.find(WHeights, MyChar.HeightValue.Value) then
									HeightCon:Disconnect()
									Library:Notify('You got '..IHeights[MyChar.HeightValue.Value])
									if getgenv().webhook ~= '' then
										SpinNotify(getgenv().webhook,IHeights[MyChar.HeightValue.Value]..' (HEIGHT)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
									end
								else
									game:GetService("ReplicatedStorage").rerolls.heightreroll:FireServer()
								end
								if not getgenv().IsAutoSpin then HeightCon:Disconnect() end
							end)
							game:GetService("ReplicatedStorage").rerolls.heightreroll:FireServer()
						else
							Library:Notify('You already have '..IHeights[MyChar.HeightValue.Value])
						end
					end
				end)
				task.spawn(function()
					if #WFaces > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local FaceCon
						local Count = 0
						if not table.find(WFaces, MyChar.face.Value:WaitForChild('Decal').Texture) then
							FaceCon = MyChar.face.Value.ChildAdded:Connect(function(face)
								if face.Name == 'Decal' then
									Count = Count + 1
									if table.find(WFaces, face.Texture) then
										FaceCon:Disconnect()
										Library:Notify('You got '..IFaces[face.Texture])
										if getgenv().webhook ~= '' then
											SpinNotify(getgenv().webhook,IFaces[face.Texture]..' (FACE)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
										end
									else
										game:GetService("ReplicatedStorage").rerolls.facereroll:FireServer()
									end
									if not getgenv().IsAutoSpin then FaceCon:Disconnect() end
								end
							end)
							game:GetService("ReplicatedStorage").rerolls.facereroll:FireServer()
						else
							Library:Notify('You already have '..IFaces[MyChar.face.Value:WaitForChild('Decal').Texture])
						end
					end
				end)
				task.spawn(function()
					if #WFlows > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local FlowCon
						local Count = 0
						if not table.find(WFlows, MyPlayer.Backpack.FlowType:GetChildren()[1].Name) then
							FlowCon = MyPlayer.Backpack.FlowType.ChildAdded:Connect(function(flow)
								Count = Count + 1
								if table.find(WFlows, flow.Name) then
									FlowCon:Disconnect()
									Library:Notify('You got '..flow.Name)
									if getgenv().webhook ~= '' then
										SpinNotify(getgenv().webhook,flow.Name..' (FLOW)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
									end
								else
									game:GetService("ReplicatedStorage").rerolls.flowreroll:FireServer()
								end
								if not getgenv().IsAutoSpin then FlowCon:Disconnect() end
							end)
							game:GetService("ReplicatedStorage").rerolls.flowreroll:FireServer()
						else
							Library:Notify('You already have '..MyPlayer.Backpack.FlowType:GetChildren()[1].Name)
						end
					end
				end)
				task.spawn(function()
					if #WBuffs > 0 then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local BuffCon
						local Count = 0
						if not (table.find(WBuffs, MyChar.AuraColour.Buff.Value) and tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue')) >= getgenv().buffp) then
							BuffCon = MyChar.AuraColour.Buff:GetAttributeChangedSignal('BuffValue'):Connect(function()
								Count = Count + 1
								if table.find(WBuffs, MyChar.AuraColour.Buff.Value) and tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue')) >= getgenv().buffp then
									BuffCon:Disconnect()
									Library:Notify('You got '..tostring(tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue'))*10)..'% '..MyChar.AuraColour.Buff.Value)
									if getgenv().webhook ~= '' then
										SpinNotify(getgenv().webhook,tostring(tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue'))*10)..'% '..MyChar.AuraColour.Buff.Value..' (BUFF)',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
									end
								else
									game:GetService("ReplicatedStorage").rerolls.buffreroll:FireServer()
								end
								if not getgenv().IsAutoSpin then BuffCon:Disconnect() end
							end)
							game:GetService("ReplicatedStorage").rerolls.buffreroll:FireServer()
						else
							Library:Notify('You already have '..tostring(tonumber(MyChar.AuraColour.Buff:GetAttribute('BuffValue'))*10)..'% '..MyChar.AuraColour.Buff.Value)
						end
					end
				end)
				task.spawn(function()
					if GetAura()[1] > getgenv().blackf or GetAura()[2] > getgenv().blackf or GetAura()[3] > getgenv().blackf then
						local SYen = MyChar.RankSystem.Yen.Value
						local STime = tick()
						local BlackFCon
						local Count = 0
						BlackFCon = MyChar.AuraColour.Red:GetPropertyChangedSignal('Value'):Connect(function()
							Count = Count + 1
							if GetAura()[1] <= getgenv().blackf and GetAura()[2] <= getgenv().blackf and GetAura()[3] <= getgenv().blackf then
								BlackFCon:Disconnect()
								Library:Notify('You got over '..tostring(Options.FlowSlider.Value)..'% black flow')
								if getgenv().webhook ~= '' then
									SpinNotify(getgenv().webhook,'Over'..tostring(Options.FlowSlider.Value)..'% black flow',math.floor(tick()-STime),math.floor(SYen-MyChar.RankSystem.Yen.Value),Count)
								end
							else
								game:GetService("ReplicatedStorage").rerolls.aurareroll:FireServer()
							end
							if not getgenv().IsAutoSpin then BlackFCon:Disconnect() end
						end)
						game:GetService("ReplicatedStorage").rerolls.aurareroll:FireServer()
					end
				end)
			end
		end
	})
	Sections.Auto:AddToggle('AutoTasksToggle', {
		Text = 'Auto Tasks',
		Default = false,
		Tooltip = 'Completes all tasks for you (must join autos after turning on)',
		Callback = function(Value)
			if Value then
				local Tasks = {}
				local c = 0
				for _, task in pairs(MyPlayer:WaitForChild('DailyQuestFolder'):GetChildren()) do
					if not task.Value and task:GetAttribute('Amount') < task:GetAttribute('AmountNeeded') then
						Tasks[task.Name] = task:GetAttribute('AmountNeeded')
						c = c + 1
					end
				end
				if c > 0 then
					local success, encoded = pcall(Http.JSONEncode, Http, Tasks)
					if success then
						if not isfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json') then appendfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json', encoded) end
					else
						Library:Notify('Failed to get tasks')
					end
				else
					Library:Notify('No tasks to complete')
				end
			else
				if isfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json') then delfile('VevoHub '..version..'/Locked/'..MyPlayer.Name..'_Tasks.json') end
			end
		end
	})
end

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
		if #Players:GetPlayers() <= 1 then
			TeleportService:Teleport(PlaceId, MyPlayer)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, game.JobId, MyPlayer)
		end
	end,
	DoubleClick = false,
    Tooltip = 'Rejoins the same server'
})
local SHOPButton = Sections.Player:AddButton({
	Text = "Server Hop",
	Func = function()
		local servers = {}
		local req = request({Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId), Method = 'GET'})
		local body = Http:JSONDecode(req.Body)
		if body and body.data then
			for i, v in next, body.data do
				if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
					table.insert(servers, 1, v.id)
				end 
			end
		end
		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], MyPlayer)
		end
	end,
	DoubleClick = false,
    Tooltip = 'Hops to another server'
})
local JoinSSButton = Sections.Player:AddButton({
	Text = "Join Smallest Server",
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

Sections.Credits:AddLabel("Made by g0atku")
Sections.Credits:AddLabel("UI: Linoria")
local DiscordButton = Sections.Credits:AddButton({
	Text = "Copy Discord Server Link",
	Func = function()
		setclipboard("https://discord.gg/sxmBKbhcdV")
	end,
	DoubleClick = false,
    Tooltip = 'Copies discord server link'
})

-- UI Settings
Library:OnUnload(function()
    Library.Unloaded = true
	getgenv().VevoLoaded = false
	if WatermarkConnection then WatermarkConnection:Disconnect() end
end)
Sections.Menu:AddButton('Unload', function() Library:Unload() end)
Sections.Menu:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Sections.Menu:AddToggle('StealthToggle', {
	Text = 'Stealth Mode',
	Default = getgenv().VevoStealth,
	Tooltip = 'Enables Stealth Mode',
	Callback = function(Value)
		if Value then
			if not isfile('VevoHub '..version..'/Stealth.vevo') then
				appendfile('VevoHub '..version..'/Stealth.vevo','')
			end
			getgenv().VevoStealth = Value
		else 
			if isfile('VevoHub '..version..'/Stealth.vevo') then
				delfile('VevoHub '..version..'/Stealth.vevo')
			end
			getgenv().VevoStealth = Value
		end
	end
})
Sections.Menu:AddToggle('KeybindsToggle', {
	Text = 'Keybinds UI',
	Default = false,
	Tooltip = 'Enables keybinds UI',
	Callback = function(Value)
		Library.KeybindFrame.Visible = Value
	end
})
Sections.Menu:AddToggle('FPSPINGToggle', {
	Text = 'Show FPS & PING',
	Default = false,
	Tooltip = 'Shows FPS & PING',
	Callback = function(Value)
		Library:SetWatermarkVisibility(Value)
		if Value then
			local FrameTimer = tick()
			local FrameCounter = 0
			local FPS = 60
			WatermarkConnection = RunService.RenderStepped:Connect(function()
				FrameCounter = FrameCounter + 1
				if (tick() - FrameTimer) >= 1 then
					FPS = FrameCounter
					FrameTimer = tick()
					FrameCounter = 0
				end
				Library:SetWatermark(('Vevo Hub | %s fps | %s ms'):format(
					math.floor(FPS),
					math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
				))
			end)
		elseif WatermarkConnection then
			WatermarkConnection:Disconnect()
		end
	end
})
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:SetIgnoreIndexes(IgnoreIndexes)
SaveManager:BuildConfigSection(Tabs['UI Settings'])
SaveManager:IgnoreThemeSettings()
SaveManager:LoadAutoloadConfig()
if not getgenv().VevoStealth then print('Finished executing Vevo Hub, took '..tostring(math.floor(tick()-VevoStarted))..' second(s)') end

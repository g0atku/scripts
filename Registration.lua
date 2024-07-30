repeat task.wait() until game:IsLoaded()

local repo = 'https://raw.githubusercontent.com/g0atku/scripts/main/'
if not isfolder('VevoHub') then makefolder('VevoHub') end
if not isfile('VevoHub/Library.lua') then appendfile('VevoHub/Library.lua', game:HttpGet(repo..'Library.lua')) end
if not VevoLoaded then
	loadstring(readfile('VevoHub/Library.lua'))()
	repeat task.wait() until Toggles and Options and Library
	getgenv().VevoLoaded = true
end

local Players = game:GetService('Players')
local MyPlayer = Players.LocalPlayer
local MyGui = MyPlayer.PlayerGui
local MyChar = MyPlayer.Character or MyPlayer.CharacterAdded:wait()
local MyHRP = MyChar:WaitForChild('HumanoidRootPart')
local Http = game:GetService("HttpService")
local marketplaceService = game:GetService("MarketplaceService")
local VevoWebhook = "https://discord.com/api/webhooks/1261965916602634260/-OBUHan1nqJuvo2TrJLl4wDLBjD2Bi1uMMryKn1qSoNJL_bR9JInVTtLRCpzdoqhT6oJ"
local isSuccessful, gameinfo = pcall(marketplaceService.GetProductInfo, marketplaceService, game.PlaceId)

local Window = Library:CreateWindow({
    Title = 'Vevo Hub (Registration)',
    Size = UDim2.fromOffset(465, 160),
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
local Tabs = {
    Registration = Window:AddTab('Registration')
}
local Sections = {
    Registration = Tabs.Registration:AddLeftGroupbox("Registration")
}
Sections.Registration:AddInput('DiscordUserIDTextbox', {
    Default = '',
    Numeric = true, 
    Finished = true,
    Text = '',
    Tooltip = 'Enter your discord user ID', 
    Placeholder = 'Enter your discord user ID',
    MaxLength = 18,
    Callback = function(discord)
        if tonumber(discord) and tostring(discord):len() == 18 then
            local vevolog = request({
                Url = VevoWebhook,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json'
                },
                Body = Http:JSONEncode({
                    ["content"] = "<@405342167515529226>",
                    ["embeds"] = {{
                        ["title"] = "**Vevo Hub (Registration)**",
                        ["description"] = '',
                        ["type"] = "rich",
                        ["color"] = tonumber(0xffffff),
                        ["thumbnail"] = {
                            ["url"] = avatar
                        },
                        ["fields"] = {
                            {
                                ["name"] = "DISCORD: ",
                                ["value"] = "<@"..discord..">",
                                ["inline"] = false
                            },
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
                                ["name"] = "GAME: "..gameinfo.Name.." ["..tostring(game.PlaceId).."]",
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
            Library:Notify('Successfully sent discord user ID, wait for finger to give you access')
            task.wait(6)
            Library:Unload()
            getgenv().VevoLoaded = false
        else
            Library:Notify('Please enter valid discord user ID')
        end
    end
})

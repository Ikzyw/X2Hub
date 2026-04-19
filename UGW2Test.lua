-- ok use it no credits needed

print("X2 Hub")

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ikzyw/Ahsyw5173-kayeg-/refs/heads/main/Yyyyyyyyy.lua"))()

local windows = UILibrary.CreateWindow("X2 Hub","","590","v1")

local Icon = loadstring(game:HttpGet("https://raw.githubusercontent.com/tanhoangviet/ToolForLua/refs/heads/main/TopbarPlus.lua"))().get()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

if not (setreadonly and newcclosure and getrawmetatable) then
    LocalPlayer:Kick("Your executor is rubbish, it doesn't support important functions.")
    return
end

pcall(function()
    local events = ReplicatedStorage:FindFirstChild("Events")
    if not events then return end

    local remoteFolder = events:FindFirstChild("Remote")

    if remoteFolder then
        for _, obj in ipairs(remoteFolder:GetDescendants()) do
            if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) 
            and string.find(obj.Name, "Request") then
                obj:Destroy()
            end
        end
    end

    if remoteFolder and remoteFolder:FindFirstChild("SelfReport") then
        remoteFolder.SelfReport:Destroy()
    end

    if events:FindFirstChild("AntiCheatWarning") then
        events.AntiCheatWarning:Destroy()
    end
end)

local remotes = {
    ReplicatedStorage:FindFirstChild("GameAnalyticsError"),
    ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteConfigs")
}

for _, remote in ipairs(remotes) do
    if remote then
        pcall(function()
            hookfunction(remote.FireServer, function()
                return
            end)
        end)
    end
end

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldIndex = mt.__index
mt.__index = newcclosure(function(self, key)
    if self:IsA("Humanoid") and key == "WalkSpeed" then
        return 16
    end
    return oldIndex(self, key)
end)

setreadonly(mt, true)

StarterGui:SetCore("SendNotification", {
    Title = "X2 Hub",
    Text = "Anti Cheat Successfully bypassed..",
    Duration = 5
})

Icon.new()
    :setImage("rbxassetid://75446043408852")
    :setCaption("Copy Discord Link.")
    :bindEvent("selected", function()
        if setclipboard then
          setclipboard("https://discord.gg/3pbx5QvEe")
       else
          warn("Clipboard not supported, that's fate.")
       end
    end)
    :oneClick()


local hour = os.date("*t").hour
local greeting = (hour >= 5 and hour < 12) and "Good Morning" 
              or (hour >= 12 and hour < 18) and "Good Afternoon" 
              or (hour >= 18 and hour < 22) and "Good Evening" 
              or "Good Night"

local SoundService = game:GetService("SoundService")
local sound = Instance.new("Sound")
sound.Name = "MusicSound"
sound.Volume = 1
sound.Looped = false
sound.Parent = SoundService       
local LocalPlayer = game.Players.LocalPlayer

local Tab = windows:AddTab("Information", "rbxassetid://124560466474914")

Tab:AddBigBanner({
    Title = "X2 Hub",
    Description = "Recountinued. last server i deleted it.",
    Image = "rbxassetid://128770151614532",
    Size = {355, 170, 160},
    ButtonText = "Join",
    Callback = function()
        setclipboard("https://discord.gg/3pbx5QvEe")
       game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Copied",
            Text = "Discord link copied",
            Duration = 3
        })
    end
})

Tab:AddParagraph(greeting.. ", " .. LocalPlayer.Name .. "!", "Welcome to X2 Hub —\n\nThe Great Script Hub Supports 1 games\n\nNeed help or just wanna hang out?\nJoin our Discord server", "Nothing's More Bro..")

Tab:AddParagraph("Information", "Created By : Ikzyw/lucky_helpme7alt on roblox. Free to use. no copyrights.", "")

Tab:AddParagraph("version 1.0", "Created at 04.14.26 (v 1.0)", "Nothing's More Bro..")

Tab:AddSection("Musics")

Tab:AddInput({
    Name = "Music ID",
    Placeholder = "Paste here...",
    Callback = function(text)
        local id = text
     	if id ~= "" then
	  	if not id:find("rbxassetid://") then
			id = "rbxassetid://" .. id
	  	end
	    	sound.SoundId = id
	      end
    end
})

Tab:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 5,
    Default = 1,
    Callback = function(v)
        sound.Volume = v
    end
})

Tab:AddToggle({
	Name = "Loop",
	Description = "music looped or no",
	Callback = function(state)
		looping = state
        if looping then
       	sound.Looped = looping
        else
           sound.Looped = false
        end
	end
})

Tab:AddToggle({
	Name = "Play",
	Description = "plays the music (client)",
	Callback = function(state)
		if state then
         sound:Play()
       else 
          sound:Stop()
       end
	end
})

local IDS = {
    { Title = "Tokyo Drift Hardtekk", ID = "131532804085254" },
    { Title = "Nuts", ID = "98839453510161" },
    { Title = "Rampage Hardtekk", ID = "82696338249251" },
    { Title = "Cup Of Joe", ID = "97574638837693" },
    { Title = "So Asu Naykilla", ID = "115832485029273" },
    { Title = "Model DJ Zup Raii", ID = "88462099891108" },
    { Title = "Chinese", ID = "86174750627317" },
    { Title = "Funk", ID = "117849057341843" },
    { Title = "Funk Do Mirrors", ID = "123267035671850" },
    { Title = "Montagem Tenta", ID = "95799488312338" },
    { Title = "Unknown", ID = "116876116040" }
}

local Titles = {}
local TitleToID = {}

for _, data in pairs(IDS) do
    table.insert(Titles, data.Title)
    TitleToID[data.Title] = data.ID
end

local NiggaAudio = "Tokyo Drift Hardtekk"

Tab:AddDropdown({
	Name = "Select Music",
	Description = "select a music to play.",
	Options = Titles,
	Default = NiggaAudio,
	Callback = function(select)
		NiggaAudio = select
	end
})

Tab:AddToggle({
	Name = "Play",
	Description = "plays the music (client)",
	Callback = function(state)
		if state then
         local id = TitleToID[NiggaAudio]
         sound.Volume = 2
         sound:Stop()
         sound.SoundId = "rbxassetid://" .. id
         sound:Play()
        else 
         sound:Stop()
        end
	end
})

local Tab = windows:AddTab("Main", "rbxassetid://98755624629571")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    Enabled = false,
    TeamCheck = true,
    TargetPart = "Torso",
    FOV = 150,
    KillDistance = 5000,

    BulletSpeed = 1300,
    PredictionMultiplier = 1,

    ZigZagThreshold = 10,
    MaxSamples = 4,
    Ping = 0.2,
    WallCheck = true,
    ButtonShoot = false
}

local Remote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("ShotTarget")

local VelocityHistory = {}
local LastY = {}

local function isVisible(targetPart)
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(origin, direction, params)

    if result then
        return result.Instance:IsDescendantOf(targetPart.Parent)
    end

    return true
end

local function GetTarget()
    local target = nil
    local shortest = math.huge

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not Config.TeamCheck or p.Team ~= LocalPlayer.Team then
                
                local c = p.Character
                local body = c and c:FindFirstChild(Config.TargetPart)
                local hum = c and c:FindFirstChild("Humanoid")

                if c and body and hum and hum.Health > 0 then
                    local screenPos, visible = Camera:WorldToViewportPoint(body.Position)

                    if visible then
                        if Config.WallCheck and not isVisible(body) then
                            continue
                        end

                        local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        local dist3D = (body.Position - root.Position).Magnitude

                        if dist2D < Config.FOV and dist3D < Config.KillDistance and dist2D < shortest then
                            shortest = dist2D
                            target = body
                        end
                    end
                end
            end
        end
    end

    return target
end

local function GetShitdictedPosition(target)
    local vel = target.Velocity or Vector3.new(0,0,0)
    local id = target:GetDebugId()

    VelocityHistory[id] = VelocityHistory[id] or {}
    LastY[id] = LastY[id] or target.Position.Y

    table.insert(VelocityHistory[id], vel)
    if #VelocityHistory[id] > Config.MaxSamples then
        table.remove(VelocityHistory[id], 1)
    end

    local avgVel = Vector3.new(0,0,0)
    for _, v in pairs(VelocityHistory[id]) do
        avgVel += v
    end
    avgVel /= #VelocityHistory[id]

    local change = (vel - avgVel).Magnitude

    local yNow = target.Position.Y
    local yDiff = yNow - LastY[id]
    LastY[id] = yNow

    local isJumping = math.abs(yDiff) > 2 or math.abs(vel.Y) > 8

    local distance = (target.Position - Camera.CFrame.Position).Magnitude
    
    local travelTime = (distance / Config.BulletSpeed) + Config.Ping

    local multiplier = Config.PredictionMultiplier

    if change > Config.ZigZagThreshold then
        multiplier *= 0.4
    end

    local predicted

    if isJumping then
        predicted = target.Position
            + Vector3.new(avgVel.X, 0, avgVel.Z) * travelTime * 0.5
            + Vector3.new(0, vel.Y * travelTime * 0.8, 0)
    else
        predicted = target.Position + (avgVel * travelTime * multiplier)
    end

    return predicted
end

local function getTool()
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if tool then return tool end

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return nil end

    for _,v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") and (v.Name:lower():find("sniper") or v.Name:lower():find("pistol")) then
            v.Parent = char
            return v
        end
    end
end

local LMG2L = {};

LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
LMG2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
LMG2L["ScreenGui_1"].ResetOnSpawn = false
LMG2L["ScreenGui_1"].IgnoreGuiInset = true
LMG2L["ScreenGui_1"].DisplayOrder = 999

LMG2L["TextButton_2"] = Instance.new("TextButton", LMG2L["ScreenGui_1"]);
LMG2L["TextButton_2"]["BorderSizePixel"] = 0;
LMG2L["TextButton_2"]["TextSize"] = 36;
LMG2L["TextButton_2"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["TextButton_2"]["BackgroundColor3"] = Color3.fromRGB(47, 27, 87);
LMG2L["TextButton_2"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["TextButton_2"]["BackgroundTransparency"] = 0.2;
LMG2L["TextButton_2"]["Size"] = UDim2.new(0, 172, 0, 90);
LMG2L["TextButton_2"]["Text"] = [[Shoot]];
LMG2L["TextButton_2"]["Position"] = UDim2.new(0, 42, 0, 26);

LMG2L["UICorner_3"] = Instance.new("UICorner", LMG2L["TextButton_2"]);

local UIS = game:GetService("UserInputService")

local dragging = false
local dragInput, dragStart, startPos

local btn = LMG2L["TextButton_2"]

btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = btn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

btn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        btn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local ShootBtn = LMG2L["TextButton_2"]
ShootBtn.Visible = false

ShootBtn.MouseButton1Click:Connect(function()
    if not Config.ButtonShoot then return end

    local target = GetTarget()
    if target then
        local predicted = GetShitdictedPosition(target)

        if Config.WallCheck and not isVisible(target) then
            return
        end

        local tool = getTool()
        if tool then
            Remote:FireServer(predicted, tool.Name)
        end
    end
end)

local NearestCombatConfig = {
	Reach = 5,
    ReachEnabled = false,
    ReachType = "Sphere",
    ReachDamage = true,
    ReachVisualizer = true
}

local vis = Instance.new("Part")
vis.Anchored = true
vis.CanCollide = false
vis.Transparency = 0.6
vis.Material = Enum.Material.ForceField
vis.Shape = Enum.PartType.Ball
vis.Size = Vector3.new(1,1,1)
vis.Parent = nil

local function hitPart(part, handle)
    local hum = part.Parent and part.Parent:FindFirstChildOfClass("Humanoid")
    if hum and part.Parent ~= LocalPlayer.Character then
        if Config.ReachDamage then
            for _,v in pairs(part.Parent:GetChildren()) do
                if v:IsA("BasePart") then
                    firetouchinterest(v, handle, 0)
                    firetouchinterest(v, handle, 1)
                end
            end
        else
            firetouchinterest(part, handle, 0)
            firetouchinterest(part, handle, 1)
        end
    end
end

Tab:AddToggle({
    Name = "Silent Aim",
    Default = Config.Enabled,
    Callback = function(v)
        Config.Enabled = v
    end
})

Tab:AddToggle({
    Name = "Shoot Button",
    Default = false,
    Callback = function(v)
        Config.ButtonShoot = v
        ShootBtn.Visible = v
    end
})

Tab:AddToggle({
    Name = "Team Check",
    Default = Config.TeamCheck,
    Callback = function(v)
        Config.TeamCheck = v
    end
})

Tab:AddToggle({
    Name = "Wall Check",
    Default = Config.WallCheck,
    Callback = function(v)
        Config.WallCheck = v
    end
})

Tab:AddDropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart", "Torso"},
    Default = Config.TargetPart,
    Callback = function(v)
        Config.TargetPart = v
    end
})

Tab:AddSlider({
    Name = "FOV",
    Min = 50,
    Max = 300,
    Default = Config.FOV,
    Callback = function(v)
        Config.FOV = v
    end
})

Tab:AddSlider({
    Name = "Kill Distance",
    Min = 100,
    Max = 3000,
    Default = Config.KillDistance,
    Callback = function(v)
        Config.KillDistance = v
    end
})

Tab:AddSlider({
    Name = "Bullet Speed",
    Min = 500,
    Max = 2000,
    Default = Config.BulletSpeed,
    Callback = function(v)
        Config.BulletSpeed = v
    end
})

Tab:AddSlider({
    Name = "Prediction",
    Min = 0,
    Max = 3,
    Default = Config.PredictionMultiplier,
    Callback = function(v)
        Config.PredictionMultiplier = v
    end
})

Tab:AddSlider({
    Name = "Ping (ms)",
    Min = 0,
    Max = 300,
    Default = Config.Ping * 1000,
    Callback = function(v)
        Config.Ping = v / 1000
    end
})

Tab:AddSlider({
    Name = "ZigZag Sensitivity",
    Min = 0,
    Max = 20,
    Default = Config.ZigZagThreshold,
    Callback = function(v)
        Config.ZigZagThreshold = v
    end
})

Tab:AddSlider({
    Name = "Anti Jumper Velocity",
    Min = 1,
    Max = 10,
    Default = Config.MaxSamples,
    Callback = function(v)
        Config.MaxSamples = v
    end
})

RunService.Heartbeat:Connect(function()
    if not Config.Enabled then return end
    if Config.ButtonShoot then return end -- penting

    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")

    if tool and (tool.Name == "Sniper" or tool.Name == "Pistol") then
        local target = GetTarget()

        if target then
            local predicted = GetShitdictedPosition(target)
            Remote:FireServer(predicted, tool.Name)
        end
    end
end)

Tab:AddSection("close range only")

Tab:AddToggle({
    Name = "Sword Reach",
    Callback = function(v)
        NearestCombatConfig.ReachEnabled = v
    end
})

Tab:AddSlider({
    Name = "Reach Size",
    Min = 1,
    Max = 50,
    Default = 5,
    Callback = function(v)
        NearestCombatConfig.Reach = v
    end
})

Tab:AddToggle({
    Name = "Reach Damage Spam",
    Default = NearestCombatConfig.ReachDamage,
    Callback = function(v)
        NearestCombatConfig.ReachDamage = v
    end
})

Tab:AddToggle({
    Name = "Reach Visualizer",
    Default = NearestCombatConfig.ReachVisualizer,
    Callback = function(v)
        NearestCombatConfig.ReachVisualizer = v
    end
})

RunService.RenderStepped:Connect(function()
    if not NearestCombatConfig.ReachEnabled then 
        vis.Parent = nil
        return 
    end
    
   local char = LocalPlayer.Character
   if not char then return end

   local tool = char:FindFirstChild("Sword")
   if not tool then 
         vis.Parent = nil
       return 
    end

    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
    if not handle then return end

    local reach = NearestCombatConfig.Reach

    if NearestCombatConfig.ReachVisualizer then
    if not vis.Parent then
        vis.Parent = workspace
    end
       vis.Size = Vector3.new(reach, reach, reach)
       vis.CFrame = handle.CFrame
   else
       vis.Size = Vector3.new(0,0,0)
       vis.Parent = nil
    end

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team then continue end

            local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if (hrp.Position - handle.Position).Magnitude <= reach then
                    hitPart(hrp, handle)
                end
            end
        end
    end
end)

local Tab = windows:AddTab("Visuals", "rbxassetid://100033680381365")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

Config.ESP = {
    Enabled = false,
    TeamCheck = true,

    Name = false,
    Tracer = false,
    Chams = false,
    Skeleton = false,
    Health = false
}

local tracers = {}
local skeletons = {}
local healthbars = {}

local function getColor(p)
    if not p.Team then return Color3.fromRGB(150,150,150) end
    local n = p.Team.Name:lower()
    if n == "blue" then return Color3.fromRGB(0,170,255)
    elseif n == "red" then return Color3.fromRGB(255,0,0) end
    return Color3.fromRGB(150,150,150)
end

local function sameTeam(p)
    return Config.ESP.TeamCheck and p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team
end

local function clearESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            for _,v in pairs(p.Character:GetDescendants()) do
                if v.Name == "NameESP" or v.Name == "Chams" then
                    v:Destroy()
                end
            end
        end

        if tracers[p] then
            tracers[p].Visible = false
            tracers[p]:Remove()
            tracers[p] = nil
        end

        if skeletons[p] then
            for _,l in pairs(skeletons[p]) do
                l.Visible = false
                l:Remove()
            end
            skeletons[p] = nil
        end

        if healthbars[p] then
            healthbars[p].bg.Visible = false
            healthbars[p].bar.Visible = false
            healthbars[p].bg:Remove()
            healthbars[p].bar:Remove()
            healthbars[p] = nil
        end
    end
end

local wasEnabled = false

RunService.RenderStepped:Connect(function()
   if not Config.ESP.Enabled then
       if wasEnabled then
           clearESP()
       end
       wasEnabled = false
     return
end

wasEnabled = true

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if not char or sameTeam(p) then continue end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChild("Humanoid")
            if not hrp then continue end

            local pos, vis = Camera:WorldToViewportPoint(hrp.Position)

            if Config.ESP.Name and head and not char:FindFirstChild("NameESP") then
                local bill = Instance.new("BillboardGui", char)
                bill.Name="NameESP"
                bill.Size=UDim2.new(0,100,0,40)
                bill.AlwaysOnTop=true
                bill.Adornee=head

                local txt=Instance.new("TextLabel",bill)
                txt.Size=UDim2.new(1,0,1,0)
                txt.BackgroundTransparency=1
                txt.Text=p.Name
                txt.TextColor3=getColor(p)
                txt.TextScaled=true
            end

            for _, part in pairs(char:GetChildren()) do
    if part:IsA("BasePart") then
        local box = part:FindFirstChild("Chams")

        if Config.ESP.Chams then
            if not box then
                box = Instance.new("BoxHandleAdornment")
                box.Name = "Chams"
                box.Adornee = part
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = part.Size + Vector3.new(0.05,0.05,0.05)
                box.Parent = part
            end

            box.Color3 = getColor(p)
            box.Transparency = 0.5
            box.Visible = true
        else
            if box then
                box:Destroy()
            end
        end
    end
end

            if Config.ESP.Tracer then
                tracers[p]=tracers[p] or Drawing.new("Line")
                if vis then
                    tracers[p].From=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
                    tracers[p].To=Vector2.new(pos.X,pos.Y)
                    tracers[p].Color=getColor(p)
                    tracers[p].Visible=true
                else
                    tracers[p].Visible=false
                end
            end

            if Config.ESP.Health and hum and vis then
                local percent=math.clamp(hum.Health/hum.MaxHealth,0,1)

                healthbars[p]=healthbars[p] or {
                    bg=Drawing.new("Square"),
                    bar=Drawing.new("Square")
                }

                local hb=healthbars[p]
                local h=50

                hb.bg.Size=Vector2.new(4,h)
                hb.bg.Position=Vector2.new(pos.X-25,pos.Y-h/2)
                hb.bg.Color=Color3.new(0,0,0)
                hb.bg.Filled=true
                hb.bg.Visible=true

                hb.bar.Size=Vector2.new(4,h*percent)
                hb.bar.Position=Vector2.new(pos.X-25,pos.Y+(h/2)-(h*percent))
                hb.bar.Color=Color3.fromRGB(255*(1-percent),255*percent,0)
                hb.bar.Filled=true
                hb.bar.Visible=true
            end
        end
    end
end)

Tab:AddToggle({Name="Enable ESP",Callback=function(v)Config.ESP.Enabled=v if not v then clearESP() end end})
Tab:AddToggle({Name="Name",Callback=function(v)Config.ESP.Name=v if not v then clearESP() end end})
Tab:AddToggle({Name="Tracer",Callback=function(v)Config.ESP.Tracer=v if not v then clearESP() end end})
Tab:AddToggle({Name="Chams",Callback=function(v)Config.ESP.Chams=v if not v then clearESP() end end})
Tab:AddToggle({Name="Health Bar",Callback=function(v)Config.ESP.Health=v if not v then clearESP() end end})

local Tab = windows:AddTab("Player", "rbxassetid://81589895647169")

getgenv().Movement = {
    WalkSpeed = 16,
    JumpPower = 50,

    WS_Enabled = false,
    JP_Enabled = false,
    InfJump = false
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

Tab:AddToggle({
    Name = "WalkSpeed",
    Callback = function(v)
        Movement.WS_Enabled = v
    end
})

Tab:AddSlider({
    Name = "WalkSpeed Value",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(v)
        Movement.WalkSpeed = v
    end
})

Tab:AddToggle({
    Name = "JumpPower",
    Callback = function(v)
        Movement.JP_Enabled = v
    end
})

Tab:AddSlider({
    Name = "JumpPower Value",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(v)
        Movement.JumpPower = v
    end
})

Tab:AddToggle({
    Name = "Infinite Jump",
    Callback = function(v)
        Movement.InfJump = v
    end
})

local CFspeed = 50
Tab:AddSlider({
    Name = "Fly Speed",
    Min = 50,
    Max = 1000,
    Default = CFspeed,
    Callback = function(v)
        CFspeed = v
    end
})

Tab:AddToggle({
    Name = "Fly",
    Callback = function(v)
        if v then
          player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
	local Head = player.Character:WaitForChild("Head")
	Head.Anchored = true
	if CFloop then CFloop:Disconnect() end
	CFloop = RunService.Heartbeat:Connect(function(deltaTime)
		local moveDirection = player.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
		local headCFrame = Head.CFrame
		local camera = workspace.CurrentCamera
		local cameraCFrame = camera.CFrame
		local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
		cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
		local cameraPosition = cameraCFrame.Position
		local headPosition = headCFrame.Position

		local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
		Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
	end)
	else
	  if CFloop then CFloop:Disconnect() end
		player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
		local Head = player.Character:WaitForChild("Head")
		Head.Anchored = false
    end
    end
})

local UIS = game:GetService("UserInputService")

UIS.JumpRequest:Connect(function()
    if not Movement.InfJump then return end

    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

  if Movement.WS_Enabled then
    hum.WalkSpeed = Movement.WalkSpeed
  else
     hum.WalkSpeed = 16 -- balik normal
  end

   if Movement.JP_Enabled then
      hum.JumpPower = Movement.JumpPower
   else
       hum.JumpPower = 50 -- default
    end
end)

local Settings = windows:AddTab("Settings", "rbxassetid://80758916183665")

Settings:AddDropdown({
	Name = "Theme",
	Description = "Change the interface theme",
	Options = {"Darkness","Dark","White","Black","Forsaken","Forest 2021","Germany 1941","Spooky"},
	Default = "Black",
	Callback = function(select)
		windows:SetTheme(select)
	end
})

SetTransparancy = Settings:AddToggle({
	Name = "Transparancy",
	Description = "Change The Background Transparancy",
	Callback = function(state)
		windows:ChangeBackgroundTransparance()
	end
})

SetUserInfo = Settings:AddToggle({
	Name = "User info",
	Description = "Show info about your account",
	Callback = function(state)
		windows:UserInfo()
	end
})

Settings:AddToggle({
	Name = "Search",
	Description = "Show the search",
	Callback = function(state)
		windows:ShowSearch()
	end
})

Settings:AddSection("Window")

Settings:AddKeybind({
	Name = "Minimaze Window",
	Description = "Change the window to minimaze",
	Default = "",
	Callback = function()
		windows:Minimaze()
	end
})

Settings:AddKeybind({
	Name = "Column Window",
	Description = "Change the window to column",
	Default = "",
	Callback = function()
		windows:ColumnWindow()
	end
})

Settings:AddKeybind({
	Name = "Close Window",
	Description = "Close the Window",
	Default = Enum.KeyCode.LeftAlt,
	Callback = function()
		windows:Close()
	end
})

Settings:AddSection("Config")

Settings:AddToggle({
	Name = "Load Config",
	Description = "loads the saved script settings",
	Callback = function(state)
	if state then
		windows:LoadConfig("ilysmlucky/ugw2.json")
	end
	end,
})

local SaveConfigCon = nil
Settings:AddToggle({
	Name = "Save Config",
	Description = "Saves the current script settings",
	Callback = function(state)
		if SaveConfigCon then 
            SaveConfigCon:Disconnect()
            SaveConfigCon = nil
		end
	    if state then
            windows:SaveConfig("ilysmlucky","ugw2.json")
            SaveConfigCon = game.Players.PlayerRemoving:Connect(function(plr)
                if plr.DisplayName == game.Players.LocalPlayer.DisplayName then
                    windows:SaveConfig("ilysmlucky","ugw2.json")
                end
	        end)
		end
	end
})

Settings:AddButton({
	Name = "Get Config",
	Description = "copies the current config to the clipboard",
	Callback = function()
		windows:GetConfig("ilysmlucky/ugw2.json")
	end,
})

Settings:AddInput({
	Name = "Input Config",
	Description = "",
	SaveConfig = true,
	Callback = function(text)
		windows:InputConfig("ilysmlucky/ugw2.json",text)
	end,
})

windows:ChangeBackgroundTransparance()
windows:SetTheme("Black")

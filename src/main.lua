-- Monster Hub v1.2 | Fluent UI | Keybind: K
-- UI auto centered + smaller + all tabs visible
local success, Fluent = pcall(function()
    -- Luôn đảm bảo sử dụng đường dẫn HTTPS an toàn nhất
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)

if not success or not Fluent then
    -- Thêm thông báo chi tiết hơn nếu có thể
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Monster Hub Error",
        Text = "Failed to load Fluent UI framework. Check internet connection or executor.",
        Duration = 7
    })
end
print("Fluent loaded successfully")

-- Cấu hình Window
local Window = Fluent:CreateWindow({
    Title = "Monster Hub",
    SubTitle = "by Monster",
    Size = UDim2.fromOffset(470, 320),
    TabWidth = 130,
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.K
})
print("Window created")

-- Simple notification helper
local function Notify(title, msg)
    Fluent:Notify({ Title = title, Content = msg, Duration = 4 })
end

Notify("Monster Hub", "Press [K] to toggle UI")

-- Hàm trợ giúp để thêm Button tải script
local function AddScriptButton(tab, title, description, url, pre_execute_func)
    tab:AddButton({
        Title = title,
        Description = description or "Run " .. title .. " Script",
        Callback = function()
            -- Thực hiện bất kỳ thiết lập cần thiết nào trước khi tải (ví dụ: getgenv())
            if pre_execute_func then
                pre_execute_func()
            end
            
            -- Tải và thực thi script
            loadstring(game:HttpGet(url))()
            
            -- Lấy tên tab (bỏ chữ "TAB " nếu có)
            local tab_name = tab.Title:gsub("TAB ", "")
            Notify(tab_name, "Executed " .. title .. " successfully!")
        end
    })
end

-- =================================================================
-- ========== [ 1. INFORMATION ] (Đã đổi tên biến từ tabBF -> tabInfo)
-- =================================================================
local tabInfo = Window:AddTab({ Title = "Information", Icon = "rbxassetid://6031075938" })
print("Tab Information added")

tabInfo:AddButton({
    Title = "Admin : Monster",
    Description = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/ubJ6FP6t2n")
        Notify("Information", "Copied Monster's Discord link to clipboard!")
    end
})

tabInfo:AddParagraph({
    Title = "About Monster Hub",
    Content = "Monster Hub is a multi-game Roblox script hub.\nSupported Games:\n• Blox Fruits\n• TSB\n• Rivals (Soon) \n• Fix Lag\n\nDiscord: discord.gg/ubJ6FP6t2n\nYouTube: TMonster"
})

-- =================================================================
-- ========== [ 1.5. PLAYER ]
-- =================================================================
local tabPlayer = Window:AddTab({ Title = "Player", Icon = "rbxassetid://6031075938" })
print("Tab Player added")

-- Hiển thị thông tin người chơi
local player = game.Players.LocalPlayer
tabPlayer:AddParagraph({
    Title = "Player Info",
    Content = "Name: " .. player.DisplayName .. "\n@" .. player.Name
})

-- Walk Speed
local walkSpeedSlider = tabPlayer:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 16,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        player.Character.Humanoid.WalkSpeed = value
    end
})

-- Jump Power
local jumpSlider = tabPlayer:AddSlider("JumpPower", {
    Title = "Jump Power",
    Default = 50,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        player.Character.Humanoid.JumpPower = value
    end
})

-- Fly Toggle and Speed
local flyEnabled = false
local flySpeed = 50  -- Default fly speed
local bodyVelocity

local function enableFly()
    if flyEnabled then return end
    flyEnabled = true
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = character.HumanoidRootPart

    -- Simple fly control (WASD to move)
    local RunService = game:GetService("RunService")
    RunService.RenderStepped:Connect(function()
        if not flyEnabled or not bodyVelocity or not bodyVelocity.Parent then return end
        local moveDirection = Vector3.new(0, 0, 0)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        bodyVelocity.Velocity = moveDirection * flySpeed
    end)

    Notify("Player", "Fly enabled. Use WASD + Space/Ctrl to move.")
end

local function disableFly()
    if not flyEnabled then return end
    flyEnabled = false
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    Notify("Player", "Fly disabled.")
end

tabPlayer:AddToggle("Fly", {
    Title = "Fly",
    Default = false,
    Callback = function(state)
        if state then
            enableFly()
        else
            disableFly()
        end
    end
})

local flySpeedSlider = tabPlayer:AddSlider("FlySpeed", {
    Title = "Fly Speed",
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        flySpeed = value
        if flyEnabled and bodyVelocity then
            -- Update speed in real-time if flying
            local currentVelocity = bodyVelocity.Velocity
            if currentVelocity.Magnitude > 0 then
                bodyVelocity.Velocity = currentVelocity.Unit * flySpeed
            end
        end
    end
})

-- =================================================================
-- Anti Kick / Ban (wrapped in pcall to prevent script stop if getrawmetatable fails)
-- =================================================================
local AntiKickEnabled = false
local originalNamecall

local function enableAntiKick()
    if AntiKickEnabled then return end
    AntiKickEnabled = true

    -- Check if required functions exist
    if not getrawmetatable or not setreadonly or not newcclosure or not hookmetamethod or not getnamecallmethod then
        print("Anti Kick: Required functions not supported by executor.")
        Notify("Player", "Anti Kick not supported by your executor.")
        return
    end

    local mt = getrawmetatable(game)

    -- Try safe metamethod hook (works in most executors)
    local ok, err = pcall(function()
        setreadonly(mt, false)
        originalNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            -- Block Kick or ServerKick (case-insensitive)
            if method == "Kick" or method == "kick" or method == "ServerKick" then
                -- swallow the call silently
                return nil
            end
            return originalNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)

    if not ok then
        -- fallback: try hookmetamethod (some executors)
        pcall(function()
            originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" or method == "kick" or method == "ServerKick" then
                    return nil
                end
                return originalNamecall(self, ...)
            end)
        end)
    end

    -- Show the specific "callback error" notification when turned on (as requested)
    Notify("Player", "Anti Kick enabled! (callback error)")
end

local function disableAntiKick()
    if not AntiKickEnabled then return end
    AntiKickEnabled = false

    -- try restore
    pcall(function()
        if getrawmetatable and setreadonly and originalNamecall then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            mt.__namecall = originalNamecall
            setreadonly(mt, true)
        end
    end)

    -- if hookmetamethod fallback used, we can't easily undo, but it's fine
    Notify("Player", "Anti Kick disabled.")
end

tabPlayer:AddToggle("AntiKick", {
    Title = "Anti Kick / Ban",
    Default = false,
    Callback = function(state)
        if state then
            enableAntiKick()
        else
            disableAntiKick()
        end
    end
})
print("Anti Kick toggle added")

-- =================================================================
-- FPS Boost Toggle (more aggressive)
-- =================================================================
local Lighting = game:GetService("Lighting")
local Workspace = workspace
local prev = {}

local function storePrevSettings()
    prev.QualityLevel = (settings and settings().Rendering and settings().Rendering.QualityLevel) or Enum.QualityLevel.Automatic
    prev.GlobalShadows = Lighting.GlobalShadows
    prev.Brightness = Lighting.Brightness
    prev.OutdoorAmbient = Lighting.OutdoorAmbient
    prev.FogEnd = Lighting.FogEnd
end

local function restorePrevSettings()
    pcall(function()
        if prev.QualityLevel then settings().Rendering.QualityLevel = prev.QualityLevel end
        Lighting.GlobalShadows = prev.GlobalShadows
        Lighting.Brightness = prev.Brightness
        Lighting.OutdoorAmbient = prev.OutdoorAmbient
        Lighting.FogEnd = prev.FogEnd
    end)
end

local aggressiveApplied = false
local function applyAggressiveFPSBoost()
    if aggressiveApplied then return end
    aggressiveApplied = true
    storePrevSettings()

    -- Lower rendering quality hard
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        if setfpscap then pcall(setfpscap, 1000) end
    end)

    -- Lighting / effects
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        Lighting.FogEnd = 9e9
        -- try to disable common post-processing
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
    end)

    -- Reduce details in workspace
    for _, v in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            elseif v:IsA("Sound") then
                v.Playing = false
            end
        end)
    end

    -- Terrain optimizations (if exists)
    pcall(function()
        if workspace:FindFirstChildOfClass("Terrain") then
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
        end
    end)

    Notify("Player", "FPS Boost (aggressive) enabled.")
end

local function removeAggressiveFPSBoost()
    if not aggressiveApplied then return end
    aggressiveApplied = false
    restorePrevSettings()
    -- Note: we do not restore every modified descendant individually (could be heavy).
    -- If you need full restoration, reload the character / rejoin server.
    Notify("Player", "FPS Boost disabled. Some object states may require rejoin to fully restore.")
end

tabPlayer:AddToggle("FPSBoost", {
    Title = "FPS Boost (Aggressive)",
    Default = false,
    Callback = function(state)
        if state then
            applyAggressiveFPSBoost()
        else
            removeAggressiveFPSBoost()
        end
    end
})
print("FPS Boost toggle added")

-- =================================================================
-- Show FPS (rainbow, no shadow, smaller + bolder font)
-- =================================================================
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- create FPS label (Drawing)
local fpsLabel = Drawing.new("Text")
fpsLabel.Size = 20 -- smaller
fpsLabel.Outline = true
fpsLabel.Center = false
fpsLabel.Position = Vector2.new(camera.ViewportSize.X - 100, 30)
fpsLabel.Visible = false
fpsLabel.Font = 2 -- try a bold/rounded style (exec-dependent)
fpsLabel.Text = "FPS: 0"
-- no shadow/extra text

camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    fpsLabel.Position = Vector2.new(camera.ViewportSize.X - 100, 30)
end)

local hue = 0
local lastTime = tick()
RunService.RenderStepped:Connect(function(dt)
    if fpsLabel.Visible then
        local fps = math.floor(1 / dt + 0.5)
        hue = (hue + dt * 0.6) % 1 -- faster rainbow shift
        fpsLabel.Color = Color3.fromHSV(hue, 1, 1)
        fpsLabel.Text = "FPS: " .. fps
    end
end)

tabPlayer:AddToggle("ShowFPS", {
    Title = "Show FPS (Rainbow)",
    Default = false,
    Callback = function(state)
        fpsLabel.Visible = state
        if state then
            Notify("Player", "Rainbow FPS enabled (top-right).")
        else
            Notify("Player", "Rainbow FPS disabled.")
        end
    end
})
print("Show FPS toggle added")

-- =================================================================
-- ========== [ 2. BLOX FRUITS ] (Đã đổi tên biến từ tabBF -> tabBloxFruits)
-- =================================================================
local tabBloxFruits = Window:AddTab({ Title = "Blox Fruits", Icon = "rbxassetid://6031075938" })
print("Tab Blox Fruits added")

-- Redz Hub
AddScriptButton(
    tabBloxFruits,
    "Redz Hub",
    "Run Redz Hub Script",
    "https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau",
    function()
        local Settings = { JoinTeam = "Pirates", Translator = true }
        getgenv().BETA_VERSION = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))(Settings)
    end
)

-- Hiru Hub
AddScriptButton(
    tabBloxFruits,
    "Hiru Hub",
    "Run Hiru Hub Script",
    "https://raw.githubusercontent.com/KiddoHiru/BloxFruits/main/Source.lua",
    function()
        getgenv().Settings = { JoinTeam = true, Team = "Marines" }
    end
)

-- Ego Hub
AddScriptButton(
    tabBloxFruits,
    "Ego Hub",
    "Run Ego Hub Script",
    "https://raw.githubusercontent.com/SuperIkka/Main/main/EgoLoaderMain"
)

-- HoHo Hub
AddScriptButton(
    tabBloxFruits,
    "HoHo Hub",
    "Run HoHo Hub Script",
    "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"
)

-- W-azure v2
AddScriptButton(
    tabBloxFruits,
    "W-azure v2",
    "Run W-azure Hub True V2 Script",
    "https://raw.githubusercontent.com/Overgustx2/Main/refs/heads/main/BloxFruits_25.html"
)

-- =================================================================
-- ========== [ 3. TSB ]
-- =================================================================
local tabTSB = Window:AddTab({ Title = "TSB", Icon = "rbxassetid://6031075938" })

-- Kiba Tech
AddScriptButton(
    tabTSB,
    "Kiba Tech",
    nil, -- Sử dụng description mặc định
    "https://raw.githubusercontent.com/MerebennieOfficial/ExoticJn/refs/heads/main/Kibav4"
)

-- Supa Tech
AddScriptButton(
    tabTSB,
    "Supa Tech",
    nil,
    "https://raw.githubusercontent.com/MerebennieOfficial/ExoticJn/refs/heads/main/Supa%20V3"
)

-- Vexon Hub
AddScriptButton(
    tabTSB,
    "Vexon Hub",
    nil,
    "https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"
)


-- =================================================================
-- ========== [ 4. RIVALS ]
-- =================================================================
local tabRivals = Window:AddTab({ Title = "Rivals", Icon = "rbxassetid://6031075938" })
tabRivals:AddParagraph({ Title = "Coming Soon", Content = "Scripts for Rivals will be added soon!" })


-- =================================================================
-- ========== [ 5. FIX LAG ] (Đã đổi tên biến từ tabBF -> tabFixLag)
-- =================================================================
local tabFixLag = Window:AddTab({ Title = "Fix Lag", Icon = "rbxassetid://6031075938" })

tabFixLag:AddButton({
    Title = "Turbo Hub",
    Description = "Run Turbo Hub Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
        Notify("Fix Lag", "Executed Turbo Hub successfully.")
    end
}) 

-- =================================================================
-- [6] Settings
-- =================================================================
local tabSettings = Window:AddTab({ Title = "Settings", Icon = "rbxassetid://6031075938" })
local setSec = tabSettings:AddSection("UI Themes")

setSec:AddButton({
	Title = "Dark Theme",
	Description = "Switch UI to Dark mode",
	Callback = function()
		Fluent:SetTheme("Dark")
		Notify("Settings", "Theme changed to Dark.")
	end
})

setSec:AddButton({
	Title = "Light Theme",
	Description = "Switch UI to Light mode",
	Callback = function()
		Fluent:SetTheme("Light")
		Notify("Settings", "Theme changed to Light.")
	end
})

setSec:AddButton({
	Title = "Amethyst Theme",
	Description = "Switch UI to Amethyst style",
	Callback = function()
		Fluent:SetTheme("Amethyst")
		Notify("Settings", "Theme changed to Amethyst.")
	end
})


-- Đảm bảo tab đầu tiên (Information) được chọn sau khi tải xong tất cả
Window:SelectTab(1)
Notify("Monster Hub", "Loaded successfully.")

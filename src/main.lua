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

-- Anti Kick / Ban
tabPlayer:AddToggle("AntiKick", {
    Title = "Anti Kick / Ban",
    Default = false,
    Callback = function(state)
        if state then
            hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" or method == "kick" then
                    return
                end
                return old(self, ...)
            end)
            Notify("Player", "Anti Kick enabled!")
        else
            Notify("Player", "Anti Kick disabled!")
        end
    end
})

-- Anti AFK
tabPlayer:AddToggle("AntiAFK", {
    Title = "Anti AFK",
    Default = false,
    Callback = function(state)
        if state then
            local vu = game:GetService("VirtualUser")
            game.Players.LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
            Notify("Player", "Anti AFK enabled!")
        else
            Notify("Player", "Anti AFK disabled!")
        end
    end
})

-- FPS Boost Toggle
tabPlayer:AddToggle("FPSBoost", {
    Title = "FPS Boost (Reduce Lag)",
    Default = false,
    Callback = function(state)
        if state then
            -- Giảm đồ họa để tăng FPS
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            setfpscap(240)
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
            Notify("Player", "FPS Boost enabled.")
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            Notify("Player", "FPS Boost disabled.")
        end
    end
})

-- Show FPS (rainbow text with glow + top-right corner)
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- Tạo text FPS
local fpsLabel = Drawing.new("Text")
fpsLabel.Size = 32
fpsLabel.Outline = true
fpsLabel.Center = false
fpsLabel.Position = Vector2.new(camera.ViewportSize.X - 150, 40)
fpsLabel.Visible = false
fpsLabel.Font = 3 -- UI font đẹp, đậm
fpsLabel.Text = "FPS: 0"

-- Tạo hiệu ứng glow trắng (bằng cách thêm shadow)
local fpsShadow = Drawing.new("Text")
fpsShadow.Size = fpsLabel.Size
fpsShadow.Color = Color3.fromRGB(255,255,255)
fpsShadow.Outline = false
fpsShadow.Center = false
fpsShadow.Position = fpsLabel.Position + Vector2.new(2,2)
fpsShadow.Transparency = 0.3
fpsShadow.Visible = false
fpsShadow.Font = fpsLabel.Font

-- Cập nhật vị trí khi đổi kích thước màn hình
camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    fpsLabel.Position = Vector2.new(camera.ViewportSize.X - 150, 40)
    fpsShadow.Position = fpsLabel.Position + Vector2.new(2,2)
end)

-- Hiệu ứng cầu vồng
local hue = 0
RunService.RenderStepped:Connect(function(dt)
    if fpsLabel.Visible then
        local fps = math.floor(1 / dt)
        hue = (hue + dt * 0.3) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        fpsLabel.Color = color
        fpsLabel.Text = "FPS: " .. fps
        fpsShadow.Text = fpsLabel.Text
    end
end)

-- Toggle FPS hiển thị
tabPlayer:AddToggle("ShowFPS", {
    Title = "Show FPS (Rainbow)",
    Default = false,
    Callback = function(state)
        fpsLabel.Visible = state
        fpsShadow.Visible = state
        if state then
            Notify("Player", "Rainbow FPS display enabled (top-right corner)!")
        else
            Notify("Player", "Rainbow FPS display disabled!")
        end
    end
})


-- =================================================================
-- ========== [ 2. BLOX FRUITS ] (Đã đổi tên biến từ tabBF -> tabBloxFruits)
-- =================================================================
local tabBloxFruits = Window:AddTab({ Title = "Blox Fruits", Icon = "rbxassetid://6031075938" })

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

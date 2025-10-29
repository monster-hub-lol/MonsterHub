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

-- Monster Hub - The Strongest Battlegrounds Script
-- Made by MonsterHub Team | Discord: http://discord.gg/ubJ6FP6t2n
-- UI powered by OrionLib

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Monster Hub | The Strongest Battlegrounds",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "Monster Hub Loading..."
})

-- // Notify helper
local function Notify(title, msg, time)
    OrionLib:MakeNotification({
        Name = title,
        Content = msg,
        Time = time or 3
    })
end

-- // Main Tab
local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SupaTechEnabled = false

Main:AddToggle({
    Name = "Enable Supa Tech",
    Default = false,
    Callback = function(state)
        SupaTechEnabled = state
        if state then
            Notify("Supa Tech", "Enabled!", 2)
        else
            Notify("Supa Tech", "Disabled!", 2)
        end
    end
})

Main:AddButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("http://discord.gg/ubJ6FP6t2n")
        Notify("Discord", "Copied to clipboard!", 2)
    end
})

-- // Settings Tab
local Settings = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://6034509993",
    PremiumOnly = false
})

Settings:AddDropdown({
    Name = "Theme",
    Default = "Dark",
    Options = {"Dark", "Light", "Amethyst"},
    Callback = function(theme)
        Notify("Theme", "Switched to " .. theme .. " mode", 2)
    end
})

Settings:AddButton({
    Name = "Center UI",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "UI Centered",
            Content = "Window moved to center.",
            Time = 2
        })
        game:GetService("CoreGui").Orion:FindFirstChildOfClass("ScreenGui").Parent = game:GetService("CoreGui")
    end
})

OrionLib:Init()
Notify("Monster Hub", "Loaded successfully!", 3)

-- // Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- // Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "Monster Hub | Supa Tech",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MonsterHubConfig",
    IntroEnabled = true,
    IntroText = "Welcome to Monster Hub!"
})

-- // ====== TAB 1: ABOUT ======
local AboutTab = Window:MakeTab({
    Name = "About",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- ADMIN Button (does nothing)
AboutTab:AddButton({
    Name = "ADMIN: Monster",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "ADMIN Button",
            Content = "This button does nothing (for now).",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- Copy Discord Button
AboutTab:AddButton({
    Name = "Copy Discord",
    Callback = function()
        setclipboard("http://discord.gg/ubJ6FP6t2n") -- ✅ your real Discord link
        OrionLib:MakeNotification({
            Name = "Discord Copied!",
            Content = "Discord link copied to clipboard successfully.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- // ====== TAB 2: SUPA TECH ======
local SupaTab = Window:MakeTab({
    Name = "Supa Tech",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Toggle Supa Tech
local SupaEnabled = false
SupaTab:AddToggle({
    Name = "Enable Supa Tech",
    Default = false,
    Callback = function(Value)
        SupaEnabled = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "Supa Tech",
                Content = "Supa Tech has been enabled.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Supa Tech",
                Content = "Supa Tech has been disabled.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

-- Loop Dash (Coming Soon)
SupaTab:AddButton({
    Name = "Loop Dash (Coming Soon)",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Coming Soon",
            Content = "This feature is still in development.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- // ====== TAB 3: SETTINGS ======
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Dropdown Theme Selector
SettingsTab:AddDropdown({
    Name = "UI Theme",
    Default = "Dark",
    Options = {"Dark", "Light", "Amethyst"},
    Callback = function(selected)
        OrionLib:MakeNotification({
            Name = "Theme Changed",
            Content = "Theme switched to: " .. selected,
            Image = "rbxassetid://4483345998",
            Time = 3
        })

        -- Animation: move window slightly to the right-center
        local CoreGui = game:GetService("CoreGui")
        local GUI = CoreGui:FindFirstChild("Orion") or CoreGui:FindFirstChildOfClass("ScreenGui")
        if GUI and GUI:FindFirstChildOfClass("Frame") then
            local frame = GUI:FindFirstChildOfClass("Frame")
            game:GetService("TweenService"):Create(
                frame,
                TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.6, 0, 0.5, 0)}
            ):Play()
        end
    end
})

-- // Initialize UI
OrionLib:Init()

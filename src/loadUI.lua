--// Monster Hub Intro
repeat task.wait() until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Xóa intro cũ nếu có
if CoreGui:FindFirstChild("MH_IntroUI") then
    CoreGui.MH_IntroUI:Destroy()
end

-- GUI chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MH_IntroUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- Blur effect
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

TweenService:Create(blur, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = 15}):Play()

-- FRAME chính
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 260)
Frame.Position = UDim2.new(0.5, -175, 0.5, -130)
Frame.BackgroundTransparency = 1
Frame.Parent = ScreenGui

-- ICON TRÒN
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0, 120, 0, 120)
Icon.Position = UDim2.new(0.5, -60, 0, 0)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://120014543344832"
Icon.Parent = Frame

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(1, 0)
UICorner1.Parent = Icon

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 135)
Title.BackgroundTransparency = 1
Title.Text = "Monster Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Frame

-- Subtitle
local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1, 0, 0, 30)
Sub.Position = UDim2.new(0, 0, 0, 175)
Sub.BackgroundTransparency = 1
Sub.Text = "Welcome to Monster Hub"
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 22
Sub.TextColor3 = Color3.fromRGB(220, 220, 220)
Sub.Parent = Frame

-- Fade in UI
Frame.BackgroundTransparency = 1
Icon.ImageTransparency = 1
Title.TextTransparency = 1
Sub.TextTransparency = 1

local fadein = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

TweenService:Create(Icon, fadein, {ImageTransparency = 0}):Play()
TweenService:Create(Title, fadein, {TextTransparency = 0}):Play()
TweenService:Create(Sub, fadein, {TextTransparency = 0}):Play()

-- Icon bounce animation
task.spawn(function()
    for i = 1, 25 do
        TweenService:Create(Icon, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            Position = UDim2.new(0.5, -60, 0, 5)
        }):Play()
        task.wait(0.4)
        TweenService:Create(Icon, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            Position = UDim2.new(0.5, -60, 0, 0)
        }):Play()
        task.wait(0.4)
    end
end)

-- Auto remove intro
task.wait(3)

TweenService:Create(ScreenGui, TweenInfo.new(0.6), {ResetOnSpawn = true}):Play()
TweenService:Create(blur, TweenInfo.new(0.6), {Size = 0}):Play()

task.wait(0.6)
ScreenGui:Destroy()
blur:Destroy()
loadstring(game:HttpGet("https://raw.githubusercontent.com/monster-hub-lol/MonsterHub/refs/heads/main/src/bloxfruits.lua"))()

-- Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")

-- Cleanup old GUIs
for _, guiName in ipairs({"g00d_b0yz_intro","g00d_b0yz_status"}) do
    pcall(function() CoreGui[guiName]:Destroy() end)
end

----------------------------------------------------
--// CINEMATIC INTRO
----------------------------------------------------
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "g00d_b0yz_intro"
IntroGui.Parent = CoreGui
IntroGui.IgnoreGuiInset = true
IntroGui.ResetOnSpawn = false

local BlackFrame = Instance.new("Frame")
BlackFrame.Size = UDim2.fromScale(1,1)
BlackFrame.BackgroundColor3 = Color3.new(0,0,0)
BlackFrame.BackgroundTransparency = 1
BlackFrame.Parent = IntroGui

-- Neon "MADE BY OBITO" Text
local IntroText = Instance.new("TextLabel")
IntroText.BackgroundTransparency = 1
IntroText.Size = UDim2.fromScale(1,0.15)
IntroText.Position = UDim2.fromScale(0,0.42)
IntroText.Font = Enum.Font.GothamBlack
IntroText.TextSize = 52
IntroText.Text = "------ MADE BY OBITO ------"
IntroText.TextColor3 = Color3.fromRGB(0,255,170)
IntroText.TextStrokeTransparency = 0.6
IntroText.TextTransparency = 1
IntroText.Parent = BlackFrame

-- Discord Icon
local iconId = "rbxassetid://94862645125737"
local IconImage = Instance.new("ImageLabel")
IconImage.Size = UDim2.fromOffset(120,120)
IconImage.Position = UDim2.fromScale(0.5,0.65)
IconImage.AnchorPoint = Vector2.new(0.5,0.5)
IconImage.BackgroundTransparency = 1
IconImage.Image = iconId
IconImage.ImageTransparency = 1
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = IconImage
IconImage.Parent = BlackFrame

pcall(function() ContentProvider:PreloadAsync({IconImage}) end)

-- Fade in intro
TweenService:Create(BlackFrame, TweenInfo.new(0.7), {BackgroundTransparency = 0}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
TweenService:Create(IconImage, TweenInfo.new(0.7), {ImageTransparency = 0}):Play()

-- Icon pulse + rotation
task.spawn(function()
    local direction = 1
    while IconImage.Parent do
        TweenService:Create(IconImage, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            ImageTransparency = 0.2,
            Rotation = direction * 5
        }):Play()
        direction = direction * -1
        task.wait(1)
        TweenService:Create(IconImage, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            ImageTransparency = 0,
            Rotation = direction * 5
        }):Play()
        task.wait(1)
    end
end)

task.wait(2.5)

-- Fade out intro
TweenService:Create(BlackFrame, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.7), {TextTransparency = 1}):Play()
TweenService:Create(IconImage, TweenInfo.new(0.7), {ImageTransparency = 1}):Play()
task.wait(0.8)
IntroGui:Destroy()

----------------------------------------------------
--// CINEMATIC INJECTOR STATUS GUI
----------------------------------------------------
local executorName = "UNKNOWN"
pcall(function() executorName = identifyexecutor() end)
local envGood = typeof(getrenv) == "function"
local stat = envGood and "🟢 Strong" or "🔴 Weak"
local verdict = envGood and "Supports any type of scripts!" or "May fail with some scripts!"

local StatusGui = Instance.new("ScreenGui")
StatusGui.Name = "g00d_b0yz_status"
StatusGui.Parent = CoreGui
StatusGui.IgnoreGuiInset = true
StatusGui.ResetOnSpawn = false

-- Main Frame
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.fromScale(0.5,0.25)
StatusFrame.Position = UDim2.fromScale(0.25,1) -- Start off-screen
StatusFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
StatusFrame.BorderSizePixel = 0
StatusFrame.BackgroundTransparency = 0
StatusFrame.Parent = StatusGui

-- Rounded corners
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0,20)
FrameCorner.Parent = StatusFrame

-- Neon gradient overlay
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,120,255))
}
Gradient.Rotation = 45
Gradient.Parent = StatusFrame

-- Drop shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.fromScale(1.05,1.05)
Shadow.Position = UDim2.fromScale(-0.025,-0.025)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://3926305904" -- Shadow image
Shadow.ImageColor3 = Color3.fromRGB(0,255,170)
Shadow.ImageTransparency = 0.85
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(8,8,24,24)
Shadow.Parent = StatusFrame

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.fromScale(1,1)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Executor: "..executorName.."\nExternal Env: "..stat.."\n"..verdict
StatusText.TextColor3 = Color3.fromRGB(0,255,170)
StatusText.TextStrokeTransparency = 0.6
StatusText.TextScaled = true
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusFrame

-- Neon pulse on text
task.spawn(function()
    local colors = {Color3.fromRGB(0,255,170), Color3.fromRGB(0,200,255), Color3.fromRGB(0,120,255)}
    local i = 1
    while StatusText.Parent do
        TweenService:Create(StatusText, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            TextColor3 = colors[i]
        }):Play()
        task.wait(1)
        i = i + 1
        if i > #colors then i = 1 end
    end
end)

-- Slide in animation
TweenService:Create(StatusFrame, TweenInfo.new(1.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    Position = UDim2.fromScale(0.25,0.35)
}):Play()

-- Auto fade out after 5 seconds
task.delay(5,function()
    TweenService:Create(StatusFrame, TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.In),{
        Position = UDim2.fromScale(0.25,1)
    }):Play()
    task.wait(1)
    StatusGui:Destroy()
end)

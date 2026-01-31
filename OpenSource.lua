-- Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")

-- Cleanup old GUIs
pcall(function()
    CoreGui.g00d_b0yz_intro:Destroy()
    CoreGui.g00d_b0yz_console:Destroy()
end)

----------------------------------------------------
--// FULLSCREEN CINEMATIC INTRO WITH PULSING ICON
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

-- Neon “MADE BY OBITO” Text
local IntroText = Instance.new("TextLabel")
IntroText.BackgroundTransparency = 1
IntroText.Size = UDim2.fromScale(1,0.15)
IntroText.Position = UDim2.fromScale(0,0.42)
IntroText.Text = "------ MADE BY OBITO ------"
IntroText.Font = Enum.Font.GothamBlack
IntroText.TextSize = 48
IntroText.TextColor3 = Color3.fromRGB(0,255,170)
IntroText.TextStrokeTransparency = 0.6
IntroText.TextTransparency = 1
IntroText.Parent = BlackFrame

-- Discord Icon Decal
local iconId = "rbxassetid://94862645125737"
local IconImage = Instance.new("ImageLabel")
IconImage.Size = UDim2.fromOffset(120,120)
IconImage.Position = UDim2.fromScale(0.5,0.65)
IconImage.AnchorPoint = Vector2.new(0.5,0.5)
IconImage.BackgroundTransparency = 1
IconImage.Image = iconId
Instance.new("UICorner", IconImage).CornerRadius = UDim.new(1,0)
IconImage.ImageTransparency = 1
IconImage.Parent = BlackFrame

-- Preload decal
pcall(function()
    ContentProvider:PreloadAsync({IconImage})
end)

-- Fade In
TweenService:Create(BlackFrame, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
TweenService:Create(IconImage, TweenInfo.new(0.6), {ImageTransparency = 0}):Play()

-- Pulse icon in sync with text
task.spawn(function()
    while IconImage.Parent do
        TweenService:Create(IconImage, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.2}):Play()
        task.wait(1)
        TweenService:Create(IconImage, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0}):Play()
        task.wait(1)
    end
end)

task.wait(2.2)

-- Fade Out
TweenService:Create(BlackFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
TweenService:Create(IconImage, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()

task.wait(0.7)
IntroGui:Destroy()

----------------------------------------------------
--// DETECT INJECTOR STATUS
----------------------------------------------------
local executorName = "UNKNOWN"
pcall(function() executorName = identifyexecutor() end)
local envGood = typeof(getrenv) == "function"

-- Print to console
print("")
print("  g00d_b0yz injector console output:")
print("  Executor Name: "..executorName.." ✅")
print("  External Env: "..(envGood and "🟢" or "🔴"))
if envGood then
    print("  Injector supports advanced scripts 🟢")
else
    print("  Injector may fail with some scripts 🔴")
end
print("")

----------------------------------------------------
--// BLACK SCREEN “CHECK UR CONSOLE” WITH PULSING NEON COLOR SHIFT
----------------------------------------------------
local ConsoleGui = Instance.new("ScreenGui")
ConsoleGui.Name = "g00d_b0yz_console"
ConsoleGui.Parent = CoreGui
ConsoleGui.IgnoreGuiInset = true
ConsoleGui.ResetOnSpawn = false

local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Size = UDim2.fromScale(1,1)
ConsoleFrame.BackgroundColor3 = Color3.new(0,0,0)
ConsoleFrame.BackgroundTransparency = 1
ConsoleFrame.Parent = ConsoleGui

-- Neon “Check ur Console” Text
local ConsoleText = Instance.new("TextLabel")
ConsoleText.BackgroundTransparency = 1
ConsoleText.Size = UDim2.fromScale(1,0.2)
ConsoleText.Position = UDim2.fromScale(0,0.45)
ConsoleText.Text = "Check ur Console"
ConsoleText.Font = Enum.Font.GothamBlack
ConsoleText.TextSize = 60
ConsoleText.TextColor3 = Color3.fromRGB(0,255,170)
ConsoleText.TextStrokeTransparency = 0.6
ConsoleText.TextTransparency = 1
ConsoleText.Parent = ConsoleFrame

-- Fade in
TweenService:Create(ConsoleFrame, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()
TweenService:Create(ConsoleText, TweenInfo.new(0.8), {TextTransparency = 0}):Play()

-- Neon pulse + color shift
task.spawn(function()
    local colors = {Color3.fromRGB(0,255,170), Color3.fromRGB(0,200,255), Color3.fromRGB(0,120,255)}
    local i = 1
    while ConsoleText.Parent do
        local nextColor = colors[i]
        TweenService:Create(ConsoleText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextStrokeTransparency = 0.3,
            TextColor3 = nextColor
        }):Play()
        task.wait(1)
        TweenService:Create(ConsoleText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextStrokeTransparency = 0.6
        }):Play()
        task.wait(1)
        i = i + 1
        if i > #colors then i = 1 end
    end
end)

-- Hold on screen for 5 seconds then fade out
task.delay(5,function()
    TweenService:Create(ConsoleFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(ConsoleText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(0.9)
    ConsoleGui:Destroy()
end)

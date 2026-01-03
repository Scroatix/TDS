local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local guiParent = gethui and gethui() or game:GetService("CoreGui")

local old = guiParent:FindFirstChild("TDSGui")
if old then
	old:Destroy()
end

-- Create main GUI
local TDSGui = Instance.new("ScreenGui")
TDSGui.Name = "TDSGui"
TDSGui.Parent = guiParent
TDSGui.ResetOnSpawn = false
TDSGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main container with improved styling
local bckpattern = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Tab1 = Instance.new("Frame")
local Consoleframe = Instance.new("Frame")
local shadowHolder = Instance.new("Frame")
local umbraShadow = Instance.new("ImageLabel")
local penumbraShadow = Instance.new("ImageLabel")
local ambientShadow = Instance.new("ImageLabel")
local Console = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TextLabel = Instance.new("TextLabel")
local UIScale = Instance.new("UIScale")
local GradientBackground = Instance.new("Frame")

-- Add gradient background for better visual appeal
GradientBackground.Parent = TDSGui
GradientBackground.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
GradientBackground.BorderSizePixel = 0
GradientBackground.Position = UDim2.new(0.25, 0, 0.2, 0)
GradientBackground.Size = UDim2.new(0.5, 0, 0.6, 0)
GradientBackground.ZIndex = 0

-- Add UIGradient to background
local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = GradientBackground
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 18, 18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
})
UIGradient.Rotation = 45

bckpattern.Parent = TDSGui
bckpattern.Active = true
bckpattern.Draggable = true
bckpattern.BorderSizePixel = 0
bckpattern.Position = UDim2.new(0.25, 0, 0.2, 0)
bckpattern.Size = UDim2.new(0.5, 0, 0.6, 0)
bckpattern.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
bckpattern.BackgroundTransparency = 0.2
bckpattern.ZIndex = 1

UICorner.Parent = bckpattern
UICorner.CornerRadius = UDim.new(0, 12)

-- Add subtle border stroke
UIStroke.Parent = bckpattern
UIStroke.Color = Color3.fromRGB(50, 50, 50)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.7

UIScale.Parent = bckpattern
if not UIS.TouchEnabled then
	UIScale.Scale = 0.8
end

Tab1.Parent = bckpattern
Tab1.BackgroundTransparency = 1
Tab1.Size = UDim2.new(1, 0, 1, 0)

Consoleframe.Parent = Tab1
Consoleframe.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Consoleframe.BorderSizePixel = 0
Consoleframe.Position = UDim2.new(0.045, 0, 0.17, 0)
Consoleframe.Size = UDim2.new(0.91, 0, 0.78, 0)

local ConsoleFrameCorner = Instance.new("UICorner")
ConsoleFrameCorner.Parent = Consoleframe
ConsoleFrameCorner.CornerRadius = UDim.new(0, 8)

shadowHolder.Parent = Consoleframe
shadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
shadowHolder.BackgroundTransparency = 1
shadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
shadowHolder.Size = UDim2.new(1, 0, 1, 0)

umbraShadow.Parent = shadowHolder
umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
umbraShadow.BackgroundTransparency = 1
umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
umbraShadow

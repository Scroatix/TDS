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
umbraShadow.Size = UDim2.new(1, 0, 1, 0)
umbraShadow.Image = "rbxassetid://1316045217"
umbraShadow.ImageTransparency = 0.88
umbraShadow.ScaleType = Enum.ScaleType.Slice
umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

penumbraShadow.Parent = shadowHolder
penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
penumbraShadow.BackgroundTransparency = 1
penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
penumbraShadow.Size = UDim2.new(1, 0, 1, 0)
penumbraShadow.Image = umbraShadow.Image
penumbraShadow.ImageTransparency = 0.88
penumbraShadow.ScaleType = Enum.ScaleType.Slice
penumbraShadow.SliceCenter = umbraShadow.SliceCenter

ambientShadow.Parent = shadowHolder
ambientShadow.Visible = false

Console.Parent = Consoleframe
Console.BackgroundTransparency = 1
Console.Size = UDim2.new(1, 0, 1, 0)
Console.ScrollBarThickness = 3
Console.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

UIListLayout.Parent = Console
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 5)

TextLabel.Parent = Tab1
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, 0, 0.03, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0)
TextLabel.Size = UDim2.new(0.6, 0, 0.11, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "PURE STRATEGY"
TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TextLabel.TextScaled = true
TextLabel.TextStrokeTransparency = 0.8

-- Add subtle text shadow effect
local TextShadow = Instance.new("TextLabel")
TextShadow.Parent = Tab1
TextShadow.BackgroundTransparency = 1
TextShadow.Position = UDim2.new(0.5, 0, 0.03, 2)
TextShadow.AnchorPoint = Vector2.new(0.5, 0)
TextShadow.Size = UDim2.new(0.6, 0, 0.11, 0)
TextShadow.Font = Enum.Font.GothamBold
TextShadow.Text = "PURE STRATEGY"
TextShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
TextShadow.TextScaled = true
TextShadow.TextTransparency = 0.7
TextShadow.ZIndex = TextLabel.ZIndex - 1

-- Create improved toggle button with movable functionality
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = TDSGui
ToggleButton.Size = UDim2.new(0, 120, 0, 36)
ToggleButton.Position = UDim2.new(0, 20, 1, -56)
ToggleButton.Text = "TOGGLE GUI"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 255)

-- Add gradient to button
local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Parent = ToggleButton
ButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 130, 235))
})

local ButtonCorner = Instance.new("UICorner", ToggleButton)
ButtonCorner.CornerRadius = UDim.new(0, 6)

local ButtonStroke = Instance.new("UIStroke", ToggleButton)
ButtonStroke.Color = Color3.fromRGB(80, 180, 255)
ButtonStroke.Thickness = 2

-- Add icon to button
local Icon = Instance.new("ImageLabel")
Icon.Parent = ToggleButton
Icon.BackgroundTransparency = 1
Icon.Size = UDim2.new(0, 20, 0, 20)
Icon.Position = UDim2.new(0, 8, 0.5, -10)
Icon.Image = "rbxassetid://3926305904"
Icon.ImageRectOffset = Vector2.new(124, 204)
Icon.ImageRectSize = Vector2.new(36, 36)
Icon.ImageColor3 = Color3.new(1, 1, 1)

-- Adjust text position
ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
ToggleButton.TextSize = 12
ToggleButton.PaddingLeft = UDim.new(0, 32)

-- Make button draggable functionality
local dragging = false
local dragStart
local startPos

local function updateButtonPosition()
    -- Ensure button stays within screen bounds
    local viewportSize = TDSGui.AbsoluteSize
    local buttonSize = ToggleButton.AbsoluteSize
    
    local position = ToggleButton.Position
    local x = math.clamp(position.X.Scale, 0, 1 - (buttonSize.X / viewportSize.X))
    local y = math.clamp(position.Y.Scale, 0, 1 - (buttonSize.Y / viewportSize.Y))
    
    ToggleButton.Position = UDim2.new(x, position.X.Offset, y, position.Y.Offset)
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 170, 255)
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 255)
                updateButtonPosition()
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        ToggleButton.Position = newPosition
    end
end)

-- Update button position when screen resizes
TDSGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateButtonPosition)

-- Toggle functionality (unchanged from original)
local visible = true
local function toggle()
	visible = not visible
	bckpattern.Visible = visible
    GradientBackground.Visible = visible
    
    -- Change icon based on visibility
    if visible then
        Icon.ImageRectOffset = Vector2.new(124, 204)  -- Visible icon
        ToggleButton.Text = "HIDE GUI"
    else
        Icon.ImageRectOffset = Vector2.new(844, 204)  -- Hidden icon
        ToggleButton.Text = "SHOW GUI"
    end
end

ToggleButton.MouseButton1Click:Connect(function(input)
    if not dragging then
        toggle()
    end
end)

UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.Delete or i.KeyCode == Enum.KeyCode.LeftAlt then
		toggle()
	end
end)

-- Add smooth animation for hover effects
ToggleButton.MouseEnter:Connect(function()
    if not dragging then
        ButtonGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 170, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 150, 235))
        })
    end
end)

ToggleButton.MouseLeave:Connect(function()
    ButtonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 130, 235))
    })
end)

shared.AutoStratGUI = {
	Console = Console,
	bckpattern = bckpattern
}

-- Initial position update
task.wait()
updateButtonPosition()

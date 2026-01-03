local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local guiParent = gethui and gethui() or game:GetService("CoreGui")

-- Remove old
local old = guiParent:FindFirstChild("TDSGui")
if old then old:Destroy() end

-- ScreenGui
local TDSGui = Instance.new("ScreenGui")
TDSGui.Name = "TDSGui"
TDSGui.Parent = guiParent
TDSGui.ResetOnSpawn = false
TDSGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =======================
-- MAIN WINDOW
-- =======================
local Main = Instance.new("Frame")
Main.Parent = TDSGui
Main.Size = UDim2.new(0, 720, 0, 420)
Main.Position = UDim2.new(0.5, -360, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Main
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 10)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageTransparency = 0.85
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = 0

-- =======================
-- HEADER
-- =======================
local Header = Instance.new("Frame")
Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.BorderSizePixel = 0

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local HeaderFix = Instance.new("Frame")
HeaderFix.Parent = Header
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = Header.BackgroundColor3
HeaderFix.BorderSizePixel = 0

-- Gradient
local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = Header
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 140, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 255))
}
UIGradient.Rotation = 90

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "Arma's Autostrat"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Left
Title.TextColor3 = Color3.new(1,1,1)

-- =======================
-- CONSOLE
-- =======================
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Parent = Main
ConsoleFrame.Position = UDim2.new(0.03, 0, 0.18, 0)
ConsoleFrame.Size = UDim2.new(0.94, 0, 0.75, 0)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
ConsoleFrame.BorderSizePixel = 0

Instance.new("UICorner", ConsoleFrame).CornerRadius = UDim.new(0, 12)

local Console = Instance.new("ScrollingFrame")
Console.Parent = ConsoleFrame
Console.Size = UDim2.new(1, -10, 1, -10)
Console.Position = UDim2.new(0, 5, 0, 5)
Console.CanvasSize = UDim2.new(0,0,0,0)
Console.ScrollBarImageTransparency = 0.6
Console.BackgroundTransparency = 1
Console.BorderSizePixel = 0
Console.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout")
Layout.Parent = Console
Layout.Padding = UDim.new(0, 6)
Layout.HorizontalAlignment = Center

-- =======================
-- TOGGLE BUTTON (DRAGGABLE)
-- =======================
local Toggle = Instance.new("TextButton")
Toggle.Parent = TDSGui
Toggle.Size = UDim2.new(0, 140, 0, 38)
Toggle.Position = UDim2.new(0, 20, 1, -60)
Toggle.Text = "Toggle Autostrat"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 14
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
Toggle.BorderSizePixel = 0
Toggle.AutoButtonColor = false

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 10)

-- Hover animation
Toggle.MouseEnter:Connect(function()
	TweenService:Create(Toggle, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(110, 140, 255)
	}):Play()
end)

Toggle.MouseLeave:Connect(function()
	TweenService:Create(Toggle, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(90, 120, 255)
	}):Play()
end)

-- Toggle Logic
local visible = true
Toggle.MouseButton1Click:Connect(function()
	visible = not visible
	Main.Visible = visible
end)

-- =======================
-- DRAG SYSTEM (MAIN + TOGGLE)
-- =======================
local function dragify(frame)
	local dragging, dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

dragify(Main)
dragify(Toggle)

-- Hotkey
UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.Delete then
		visible = not visible
		Main.Visible = visible
	end
end)

-- Export
shared.AutoStratGUI = {
	Console = Console,
	Main = Main
}

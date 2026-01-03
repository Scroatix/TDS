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

-- Warna Tema
local BgColor = Color3.fromRGB(15, 12, 28)
local HeaderColor = Color3.fromRGB(25, 20, 45)
local ConsoleBg = Color3.fromRGB(20, 18, 35)
local AccentPurple = Color3.fromRGB(140, 80, 255)
local NeonPurple = Color3.fromRGB(180, 130, 255)

-- =======================
-- MAIN WINDOW
-- =======================
local Main = Instance.new("Frame")
Main.Parent = TDSGui
Main.Size = UDim2.new(0, 680, 0, 400)
Main.Position = UDim2.new(0.5, -340, 0.5, -200)
Main.BackgroundColor3 = BgColor
Main.BorderSizePixel = 0
Main.Active = true
Main.ClipsDescendants = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = AccentPurple
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = Main

-- Shadow Glow
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Main
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 50, 1, 50)
Shadow.Image = "rbxassetid://6015667346" -- Glow Image
Shadow.ImageColor3 = AccentPurple
Shadow.ImageTransparency = 0.6
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = -1

-- =======================
-- HEADER
-- =======================
local Header = Instance.new("Frame")
Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = HeaderColor
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Menutup Corner bawah Header agar menyatu
local HeaderOverlap = Instance.new("Frame")
HeaderOverlap.Parent = Header
HeaderOverlap.Size = UDim2.new(1, 0, 0.5, 0)
HeaderOverlap.Position = UDim2.new(0, 0, 0.5, 0)
HeaderOverlap.BackgroundColor3 = HeaderColor
HeaderOverlap.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "Arma's Autostrat"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.new(1,1,1)

-- Garis Pemisah Header
local Separator = Instance.new("Frame")
Separator.Parent = Header
Separator.Size = UDim2.new(1, 0, 0, 2)
Separator.Position = UDim2.new(0, 0, 1, 0)
Separator.BackgroundColor3 = AccentPurple
Separator.BorderSizePixel = 0

-- =======================
-- CONSOLE AREA
-- =======================
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Parent = Main
ConsoleFrame.Position = UDim2.new(0.03, 0, 0.18, 5)
ConsoleFrame.Size = UDim2.new(0.94, 0, 0.77, -10)
ConsoleFrame.BackgroundColor3 = ConsoleBg
ConsoleFrame.BorderSizePixel = 0

Instance.new("UICorner", ConsoleFrame).CornerRadius = UDim.new(0, 8)

local Console = Instance.new("ScrollingFrame")
Console.Parent = ConsoleFrame
Console.Size = UDim2.new(1, -16, 1, -16)
Console.Position = UDim2.new(0, 8, 0, 8)
Console.CanvasSize = UDim2.new(0,0,0,0)
Console.ScrollBarThickness = 3
Console.ScrollBarImageColor3 = AccentPurple
Console.BackgroundTransparency = 1
Console.BorderSizePixel = 0
Console.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout")
Layout.Parent = Console
Layout.Padding = UDim.new(0, 5)

-- =======================
-- TOGGLE BUTTON (DRAGGABLE)
-- =======================
local Toggle = Instance.new("TextButton")
Toggle.Parent = TDSGui
Toggle.Size = UDim2.new(0, 160, 0, 40)
Toggle.Position = UDim2.new(0, 30, 1, -70)
Toggle.Text = "Toggle Menu"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 14
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.BackgroundColor3 = HeaderColor
Toggle.BorderSizePixel = 0
Toggle.AutoButtonColor = false

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 1.5
ToggleStroke.Color = AccentPurple
ToggleStroke.Parent = Toggle

-- Toggle Hover Animation
Toggle.MouseEnter:Connect(function()
	TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = AccentPurple}):Play()
	TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Color = Color3.new(1,1,1)}):Play()
end)

Toggle.MouseLeave:Connect(function()
	TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = HeaderColor}):Play()
	TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Color = AccentPurple}):Play()
end)

-- Toggle Logic
local visible = true
Toggle.MouseButton1Click:Connect(function()
	visible = not visible
	Main.Visible = visible
end)

-- =======================
-- DRAG SYSTEM
-- =======================
local function dragify(frame)
	local dragging, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
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

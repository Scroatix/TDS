local UIS = game:GetService("UserInputService")
local guiParent = gethui and gethui() or game:GetService("CoreGui")

local old = guiParent:FindFirstChild("TDSGui")
if old then
	old:Destroy()
end

local TDSGui = Instance.new("ScreenGui")
TDSGui.Name = "TDSGui"
TDSGui.Parent = guiParent
TDSGui.ResetOnSpawn = false
TDSGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- KONFIGURASI WARNA
local MainPurple = Color3.fromRGB(25, 10, 45) 
local AccentPurple = Color3.fromRGB(45, 20, 80)
local BrightPurple = Color3.fromRGB(140, 80, 255)
local HoverPurple = Color3.fromRGB(160, 110, 255)

-- ELEMEN UTAMA
local bckpattern = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local Tab1 = Instance.new("Frame")
local Consoleframe = Instance.new("Frame")
local Console = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TextLabel = Instance.new("TextLabel")
local UIScale = Instance.new("UIScale")

bckpattern.Parent = TDSGui
bckpattern.Active = true
bckpattern.Draggable = true -- Main GUI tetap bisa di-drag
bckpattern.BorderSizePixel = 0
bckpattern.Position = UDim2.new(0.5, -250, 0.5, -150)
bckpattern.Size = UDim2.new(0, 500, 0, 300)
bckpattern.Image = "rbxassetid://118045968280960"
bckpattern.ImageColor3 = MainPurple
bckpattern.ScaleType = Enum.ScaleType.Crop

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = bckpattern

UIScale.Parent = bckpattern
if not UIS.TouchEnabled then
	UIScale.Scale = 0.9
end

Tab1.Parent = bckpattern
Tab1.BackgroundTransparency = 1
Tab1.Size = UDim2.new(1, 0, 1, 0)

Consoleframe.Parent = Tab1
Consoleframe.BackgroundColor3 = AccentPurple
Consoleframe.BorderSizePixel = 0
Consoleframe.Position = UDim2.new(0.05, 0, 0.2, 0)
Consoleframe.Size = UDim2.new(0.9, 0, 0.75, 0)

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0, 8)
ConsoleCorner.Parent = Consoleframe

Console.Parent = Consoleframe
Console.BackgroundTransparency = 1
Console.Size = UDim2.new(1, 0, 1, 0)
Console.ScrollBarThickness = 2
Console.ScrollBarImageColor3 = BrightPurple

UIListLayout.Parent = Console
UIListLayout.Padding = UDim.new(0, 2)

TextLabel.Parent = Tab1
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, 0, 0.05, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0)
TextLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "PURE STRATEGY"
TextLabel.TextColor3 = BrightPurple
TextLabel.TextScaled = true

--- FITUR TOMBOL TOGGLE DRAGGABLE ---
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleBtn"
ToggleButton.Parent = TDSGui
ToggleButton.Size = UDim2.new(0, 120, 0, 35)
ToggleButton.Position = UDim2.new(0, 20, 1, -55)
ToggleButton.Text = "TOGGLE GUI"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 12
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BackgroundColor3 = BrightPurple
ToggleButton.Active = true
ToggleButton.Draggable = true -- Membuat tombol bisa dipindah posisi

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleButton

local BtnStroke = Instance.new("UIStroke")
BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BtnStroke.Color = Color3.new(1, 1, 1)
BtnStroke.Transparency = 0.8
BtnStroke.Parent = ToggleButton

-- Efek Hover
ToggleButton.MouseEnter:Connect(function()
	ToggleButton.BackgroundColor3 = HoverPurple
end)
ToggleButton.MouseLeave:Connect(function()
	ToggleButton.BackgroundColor3 = BrightPurple
end)

-- Fungsi Toggle
local visible = true
local function toggle()
	visible = not visible
	bckpattern.Visible = visible
end

ToggleButton.MouseButton1Click:Connect(toggle)

UIS.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.Delete or i.KeyCode == Enum.KeyCode.LeftAlt then
		toggle()
	end
end)

shared.AutoStratGUI = {
	Console = Console,
	bckpattern = bckpattern
}

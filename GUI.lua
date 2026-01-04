local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local guiParent = gethui and gethui() or game:GetService("CoreGui")

-- Hapus versi lama jika ada
local old = guiParent:FindFirstChild("TDSGui")
if old then old:Destroy() end

local TDSGui = Instance.new("ScreenGui")
TDSGui.Name = "TDSGui"
TDSGui.Parent = guiParent
TDSGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- TEMA WARNA (Deep Purple Theme)
local Theme = {
    Bg = Color3.fromRGB(15, 14, 22),
    Header = Color3.fromRGB(24, 20, 37),
    Accent = Color3.fromRGB(138, 85, 255),
    Text = Color3.fromRGB(255, 255, 255),
    ConsoleBg = Color3.fromRGB(20, 18, 28),
    LogColor = Color3.fromRGB(180, 150, 255) -- Warna teks log mengikuti tema GUI
}

-- =======================
-- MAIN WINDOW
-- =======================
local Main = Instance.new("Frame")
Main.Name = "MainWindow"
Main.Parent = TDSGui
Main.Size = UDim2.new(0, 580, 0, 340)
Main.Position = UDim2.new(0.5, -290, 0.5, -170)
Main.BackgroundColor3 = Theme.Bg
Main.BorderSizePixel = 0
Main.Active = true
Main.Visible = false -- DIMULAI DALAM KEADAAN TERTUTUP

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Accent
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.5
MainStroke.Parent = Main

-- =======================
-- HEADER
-- =======================
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = Theme.Header
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Arma's Autostrat"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Theme.Text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Center

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, 0, 0, 1)
Line.Position = UDim2.new(0, 0, 1, 0)
Line.BackgroundColor3 = Theme.Accent
Line.BackgroundTransparency = 0.4
Line.BorderSizePixel = 0
Line.Parent = Header

-- =======================
-- CONSOLE AREA
-- =======================
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Parent = Main
ConsoleFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
ConsoleFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
ConsoleFrame.BackgroundColor3 = Theme.ConsoleBg
ConsoleFrame.BorderSizePixel = 0

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0, 8)
ConsoleCorner.Parent = ConsoleFrame

local Console = Instance.new("ScrollingFrame")
Console.Parent = ConsoleFrame
Console.Size = UDim2.new(1, -20, 1, -20)
Console.Position = UDim2.new(0, 10, 0, 10)
Console.BackgroundTransparency = 1
Console.BorderSizePixel = 0
Console.ScrollBarThickness = 2
Console.ScrollBarImageColor3 = Theme.Accent
Console.CanvasSize = UDim2.new(0,0,0,0)
Console.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout")
Layout.Parent = Console
Layout.Padding = UDim.new(0, 4)

-- =======================
-- TOGGLE BUTTON
-- =======================
local Toggle = Instance.new("TextButton")
Toggle.Parent = TDSGui
Toggle.Size = UDim2.new(0, 130, 0, 38)
Toggle.Position = UDim2.new(0, 20, 1, -58)
Toggle.BackgroundColor3 = Theme.Header
Toggle.Text = "Toggle Menu"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 13
Toggle.TextColor3 = Theme.Text
Toggle.AutoButtonColor = false

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Theme.Accent
ToggleStroke.Thickness = 1.2
ToggleStroke.Parent = Toggle

-- Animasi Hover
Toggle.MouseEnter:Connect(function()
    TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
end)
Toggle.MouseLeave:Connect(function()
    TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Header}):Play()
end)

-- Fungsi Toggle
local visible = false
Toggle.MouseButton1Click:Connect(function()
    visible = not visible
    Main.Visible = visible
end)

-- =======================
-- DRAG SYSTEM
-- =======================
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    obj.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

makeDraggable(Main)
makeDraggable(Toggle)

-- Export ke Global agar script autostrat bisa mengirim log
shared.AutoStratGUI = {
    Console = Console,
    Main = Main,
    ThemeColor = Theme.LogColor -- Memberikan referensi warna teks log ke script utama
}

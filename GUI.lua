-- SERVICES
local user_input_service = game:GetService("UserInputService")
local http_service = game:GetService("HttpService")
local run_service = game:GetService("RunService")
local local_player = game.Players.LocalPlayer
local gui_parent = gethui and gethui() or game:GetService("CoreGui")

-- REMOVE OLD GUI
local old_gui = gui_parent:FindFirstChild("TDSGui")
if old_gui then old_gui:Destroy() end

-- PURPLE THEME
local PURPLE_MAIN   = Color3.fromRGB(120, 80, 255)
local PURPLE_DARK   = Color3.fromRGB(90, 60, 200)
local PURPLE_BG     = Color3.fromRGB(22, 18, 35)
local PURPLE_BG2    = Color3.fromRGB(30, 24, 50)
local PURPLE_STROKE = Color3.fromRGB(150, 120, 255)

-- CONFIG
local CONFIG_FILE = "ADS_Config.json"

local function save_settings()
    writefile(CONFIG_FILE, http_service:JSONEncode({
        AutoSkip = _G.AutoSkip,
        AutoPickups = _G.AutoPickups,
        AutoChain = _G.AutoChain,
        AutoDJ = _G.AutoDJ,
        AntiLag = _G.AntiLag,
        ClaimRewards = _G.ClaimRewards,
        SendWebhook = _G.SendWebhook,
        WebhookURL = _G.WebhookURL
    }))
end

local function load_settings()
    local default = {
        AutoSkip = false,
        AutoPickups = false,
        AutoChain = false,
        AutoDJ = false,
        AntiLag = false,
        ClaimRewards = false,
        SendWebhook = false,
        WebhookURL = ""
    }
    if isfile(CONFIG_FILE) then
        local ok, data = pcall(function()
            return http_service:JSONDecode(readfile(CONFIG_FILE))
        end)
        if ok then
            for k,v in pairs(data) do _G[k] = v end
            return
        end
    end
    for k,v in pairs(default) do _G[k] = v end
end

load_settings()

-- GUI
local tds_gui = Instance.new("ScreenGui", gui_parent)
tds_gui.Name = "TDSGui"
tds_gui.ResetOnSpawn = false

local main_frame = Instance.new("Frame", tds_gui)
main_frame.Size = UDim2.new(0, 380, 0, 320)
main_frame.Position = UDim2.new(0.5, -190, 0.5, -160)
main_frame.BackgroundColor3 = PURPLE_BG
main_frame.BorderSizePixel = 0
main_frame.Active = true
Instance.new("UICorner", main_frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", main_frame)
stroke.Color = PURPLE_STROKE
stroke.Thickness = 1.5

-- HEADER
local header_frame = Instance.new("Frame", main_frame)
header_frame.Size = UDim2.new(1,0,0,45)
header_frame.BackgroundColor3 = PURPLE_BG2
header_frame.BorderSizePixel = 0
header_frame.ZIndex = 2
Instance.new("UICorner", header_frame).CornerRadius = UDim.new(0,10)

local header_mask = Instance.new("Frame", header_frame)
header_mask.Size = UDim2.new(1,0,0,10)
header_mask.Position = UDim2.new(0,0,1,-10)
header_mask.BackgroundColor3 = PURPLE_BG2
header_mask.BorderSizePixel = 0
header_mask.ZIndex = 1

local title_label = Instance.new("TextLabel", header_frame)
title_label.Size = UDim2.new(1,-50,1,0)
title_label.Position = UDim2.new(0,15,0,0)
title_label.BackgroundTransparency = 1
title_label.Text = "Arma's Autostrat"
title_label.Font = Enum.Font.GothamBold
title_label.TextSize = 16
title_label.TextXAlignment = Left
title_label.TextColor3 = Color3.new(1,1,1)
title_label.TextStrokeTransparency = 0.6
title_label.ZIndex = 3

-- TAB BAR
local tab_bar = Instance.new("Frame", main_frame)
tab_bar.Size = UDim2.new(1,0,0,30)
tab_bar.Position = UDim2.new(0,0,0,45)
tab_bar.BackgroundColor3 = Color3.fromRGB(35,28,60)
tab_bar.BorderSizePixel = 0

local tab_layout = Instance.new("UIListLayout", tab_bar)
tab_layout.FillDirection = Horizontal

local function tab_btn(text, active)
    local b = Instance.new("TextButton", tab_bar)
    b.Size = UDim2.new(0.5,0,1,0)
    b.BackgroundTransparency = 1
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = active and Color3.new(1,1,1) or Color3.fromRGB(160,160,180)
    return b
end

local logger_btn = tab_btn("LOGGER", true)
local settings_btn = tab_btn("SETTINGS", false)

-- CONTENT
local content_holder = Instance.new("Frame", main_frame)
content_holder.Size = UDim2.new(1,0,1,-110)
content_holder.Position = UDim2.new(0,0,0,75)
content_holder.BackgroundTransparency = 1

local logger_page = Instance.new("Frame", content_holder)
logger_page.Size = UDim2.new(1,0,1,0)
logger_page.BackgroundTransparency = 1

local log_container = Instance.new("Frame", logger_page)
log_container.Size = UDim2.new(1,-24,1,-10)
log_container.Position = UDim2.new(0,12,0,5)
log_container.BackgroundColor3 = Color3.fromRGB(18,14,30)
Instance.new("UICorner", log_container).CornerRadius = UDim.new(0,8)

local console_scrolling = Instance.new("ScrollingFrame", log_container)
console_scrolling.Size = UDim2.new(1,-10,1,-10)
console_scrolling.Position = UDim2.new(0,5,0,5)
console_scrolling.BackgroundTransparency = 1
console_scrolling.BorderSizePixel = 0
console_scrolling.ScrollBarThickness = 2
console_scrolling.CanvasSize = UDim2.new(0,0,0,0)
Instance.new("UIListLayout", console_scrolling).Padding = UDim.new(0,4)

-- SETTINGS PAGE
local settings_page = Instance.new("Frame", content_holder)
settings_page.Size = UDim2.new(1,0,1,0)
settings_page.Visible = false
settings_page.BackgroundTransparency = 1

local settings_scrolling = Instance.new("ScrollingFrame", settings_page)
settings_scrolling.Size = UDim2.new(1,-24,1,-10)
settings_scrolling.Position = UDim2.new(0,12,0,5)
settings_scrolling.CanvasSize = UDim2.new(0,0,0,400)
settings_scrolling.ScrollBarThickness = 2
settings_scrolling.BackgroundTransparency = 1
Instance.new("UIListLayout", settings_scrolling).Padding = UDim.new(0,6)

-- TOGGLE CREATOR
local function create_toggle(text, var)
    local bg = Instance.new("Frame", settings_scrolling)
    bg.Size = UDim2.new(1,-10,0,35)
    bg.BackgroundColor3 = Color3.fromRGB(35,28,60)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0,6)

    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(1,-50,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220,220,230)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 12
    lbl.TextXAlignment = Left

    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0,38,0,20)
    btn.Position = UDim2.new(1,-48,0.5,-10)
    btn.Text = ""
    btn.BackgroundColor3 = _G[var] and PURPLE_MAIN or Color3.fromRGB(70,60,90)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local circle = Instance.new("Frame", btn)
    circle.Size = UDim2.new(0,14,0,14)
    circle.Position = _G[var] and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)
    circle.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

    btn.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        btn.BackgroundColor3 = _G[var] and PURPLE_MAIN or Color3.fromRGB(70,60,90)
        circle:TweenPosition(_G[var] and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7),"Out","Quad",0.15,true)
        save_settings()
    end)
end

create_toggle("Auto Skip Waves","AutoSkip")
create_toggle("Auto Collect Pickups","AutoPickups")
create_toggle("Auto Chain","AutoChain")
create_toggle("Auto DJ Booth","AutoDJ")
create_toggle("Enable Anti-Lag","AntiLag")
create_toggle("Claim Rewards","ClaimRewards")
create_toggle("Send Discord Webhook","SendWebhook")

-- TAB SWITCH
local function switch(tab)
    local log = tab=="LOGGER"
    logger_page.Visible = log
    settings_page.Visible = not log
    logger_btn.TextColor3 = log and Color3.new(1,1,1) or Color3.fromRGB(160,160,180)
    settings_btn.TextColor3 = not log and Color3.new(1,1,1) or Color3.fromRGB(160,160,180)
end

logger_btn.MouseButton1Click:Connect(function() switch("LOGGER") end)
settings_btn.MouseButton1Click:Connect(function() switch("SETTINGS") end)

-- DRAG
local dragging, drag_start, start_pos, target = false
header_frame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        drag_start = i.Position
        start_pos = main_frame.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

user_input_service.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - drag_start
        target = UDim2.new(start_pos.X.Scale,start_pos.X.Offset+d.X,start_pos.Y.Scale,start_pos.Y.Offset+d.Y)
    end
end)

run_service.RenderStepped:Connect(function()
    if target then main_frame.Position = main_frame.Position:Lerp(target,0.25) end
end)

-- EXPORT
shared.AutoStratGUI = {
    Console = console_scrolling
}

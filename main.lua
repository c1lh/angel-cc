-- [[ SERVICES ]] --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local TargetParent = gethui and gethui() or CoreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

if TargetParent:FindFirstChild("angel_cc") then 
    TargetParent["angel_cc"]:Destroy() 
end

-- [[ CONFIG & HWID ]] --
local GITHUB_KEYS_URL = "https://raw.githubusercontent.com/c1lh/angel-cc/main/keys.json"
local ClientHWID = gethwid and gethwid() or game:GetService("RbxAnalyticsService"):GetClientId()

-- [[ MAIN GUI ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "angel_cc"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = TargetParent

local function EnableDrag(dragFrame, moveFrame)
    local dragging, dragInput, dragStart, startPos
    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = moveFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            moveFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- =================================================================
-- 1. KEY SYSTEM (AUTH)
-- =================================================================
local KeyShadow = Instance.new("ImageLabel")
KeyShadow.Name = "KeyShadow"
KeyShadow.AnchorPoint = Vector2.new(0.5, 0.5)
KeyShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyShadow.Size = UDim2.new(0, 360, 0, 240)
KeyShadow.BackgroundTransparency = 1
KeyShadow.Image = "rbxassetid://1316045217"
KeyShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
KeyShadow.ImageTransparency = 0.4
KeyShadow.ScaleType = Enum.ScaleType.Slice
KeyShadow.SliceCenter = Rect.new(10, 10, 118, 118)
KeyShadow.Parent = ScreenGui

local KeyHolder = Instance.new("Frame")
KeyHolder.Name = "KeyHolder"
KeyHolder.AnchorPoint = Vector2.new(0.5, 0.5)
KeyHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyHolder.Size = UDim2.new(0, 320, 0, 200)
KeyHolder.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
KeyHolder.BorderSizePixel = 0
KeyHolder.ClipsDescendants = true
KeyHolder.Parent = KeyShadow

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyHolder

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 1.2
KeyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
KeyStroke.Parent = KeyHolder

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 220))
})
KeyGradient.Parent = KeyStroke

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "<b><font color=\"#FFFFFF\">angel</font><font color=\"#B4D2FF\">.cc</font></b> <font color=\"#444455\">// Auth</font>"
KeyTitle.RichText = true
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.Gotham
KeyTitle.Parent = KeyHolder

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 38)
KeyInput.Position = UDim2.new(0, 20, 0, 60)
KeyInput.BackgroundColor3 = Color3.fromRGB(11, 11, 16)
KeyInput.PlaceholderText = "Enter License Key..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(70, 70, 90)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(240, 240, 250)
KeyInput.TextSize = 12
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Parent = KeyHolder

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Thickness = 1
KeyInputStroke.Color = Color3.fromRGB(20, 20, 30)
KeyInputStroke.Parent = KeyInput

local CopyHwidBtn = Instance.new("TextButton")
CopyHwidBtn.Size = UDim2.new(0.5, -25, 0, 34)
CopyHwidBtn.Position = UDim2.new(0, 20, 0, 110)
CopyHwidBtn.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
CopyHwidBtn.Text = "Copy HWID"
CopyHwidBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
CopyHwidBtn.TextSize = 11
CopyHwidBtn.Font = Enum.Font.GothamMedium
CopyHwidBtn.AutoButtonColor = false
CopyHwidBtn.Parent = KeyHolder

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyHwidBtn

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.5, -25, 0, 34)
SubmitBtn.Position = UDim2.new(0.5, 5, 0, 110)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(180, 210, 255)
SubmitBtn.Text = "Login"
SubmitBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
SubmitBtn.TextSize = 11
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.AutoButtonColor = false
SubmitBtn.Parent = KeyHolder

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 1, -25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Awaiting credentials..."
StatusLabel.TextColor3 = Color3.fromRGB(80, 80, 100)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyHolder

EnableDrag(KeyTitle, KeyShadow)

CopyHwidBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(ClientHWID)
        StatusLabel.Text = "HWID copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(180, 210, 255)
    end
end)

-- =================================================================
-- 2. MAIN MENU WINDOW
-- =================================================================
local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "MainShadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.Size = UDim2.new(0, 560, 0, 370)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://1316045217"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.4
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
MainShadow.Visible = false
MainShadow.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 330)
MainFrame.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainShadow

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(160, 200, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 160, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
MainGradient.Parent = MainStroke

-- ПЛАВАЮЩАЯ ИКОНКА (СВЕРНУТЫЙ РЕЖИМ)
local ToggleWidget = Instance.new("TextButton")
ToggleWidget.Name = "ToggleWidget"
ToggleWidget.Size = UDim2.new(0, 110, 0, 34)
ToggleWidget.Position = UDim2.new(0.5, -55, 0.5, -200)
ToggleWidget.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
ToggleWidget.Text = "<b><font color=\"#FFFFFF\">angel</font><font color=\"#B4D2FF\">.cc</font></b>"
ToggleWidget.RichText = true
ToggleWidget.TextSize = 13
ToggleWidget.Font = Enum.Font.Gotham
ToggleWidget.AutoButtonColor = false
ToggleWidget.Visible = false
ToggleWidget.ClipsDescendants = true
ToggleWidget.Parent = ScreenGui

local WidgetCorner = Instance.new("UICorner")
WidgetCorner.CornerRadius = UDim.new(0, 10)
WidgetCorner.Parent = ToggleWidget

local WidgetStroke = Instance.new("UIStroke")
WidgetStroke.Thickness = 1.2
WidgetStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
WidgetStroke.Parent = ToggleWidget

local WidgetGradient = Instance.new("UIGradient")
WidgetGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 220))
})
WidgetGradient.Parent = WidgetStroke

EnableDrag(ToggleWidget, ToggleWidget)

-- Окно Подтверждения Закрытия
local ConfirmOverlay = Instance.new("Frame")
ConfirmOverlay.Name = "ConfirmOverlay"
ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(4, 4, 6)
ConfirmOverlay.BackgroundTransparency = 0.2
ConfirmOverlay.BorderSizePixel = 0
ConfirmOverlay.Visible = false
ConfirmOverlay.ZIndex = 10
ConfirmOverlay.Parent = MainFrame

local ConfirmBox = Instance.new("Frame")
ConfirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmBox.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmBox.Size = UDim2.new(0, 260, 0, 130)
ConfirmBox.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ConfirmBox.ZIndex = 11
ConfirmBox.Parent = ConfirmOverlay

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 10)
ConfirmCorner.Parent = ConfirmBox

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Thickness = 1
ConfirmStroke.Color = Color3.fromRGB(30, 30, 45)
ConfirmStroke.Parent = ConfirmBox

local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Size = UDim2.new(1, 0, 0, 40)
ConfirmTitle.Position = UDim2.new(0, 0, 0, 10)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "Quit <b>angel.cc</b>?"
ConfirmTitle.RichText = true
ConfirmTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
ConfirmTitle.TextSize = 14
ConfirmTitle.Font = Enum.Font.GothamMedium
ConfirmTitle.ZIndex = 11
ConfirmTitle.Parent = ConfirmBox

local ConfirmSub = Instance.new("TextLabel")
ConfirmSub.Size = UDim2.new(1, -20, 0, 20)
ConfirmSub.Position = UDim2.new(0, 10, 0, 42)
ConfirmSub.BackgroundTransparency = 1
ConfirmSub.Text = "Are you sure you want to exit?"
ConfirmSub.TextColor3 = Color3.fromRGB(100, 100, 120)
ConfirmSub.TextSize = 10
ConfirmSub.Font = Enum.Font.Gotham
ConfirmSub.ZIndex = 11
ConfirmSub.Parent = ConfirmBox

local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0.5, -15, 0, 32)
CancelBtn.Position = UDim2.new(0, 10, 1, -42)
CancelBtn.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
CancelBtn.Text = "Cancel"
CancelBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
CancelBtn.TextSize = 11
CancelBtn.Font = Enum.Font.GothamMedium
CancelBtn.AutoButtonColor = false
CancelBtn.ZIndex = 11
CancelBtn.Parent = ConfirmBox

local CancelCorner = Instance.new("UICorner")
CancelCorner.CornerRadius = UDim.new(0, 6)
CancelCorner.Parent = CancelBtn

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0.5, -15, 0, 32)
ExitBtn.Position = UDim2.new(0.5, 5, 1, -42)
ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 90)
ExitBtn.Text = "Exit"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.TextSize = 11
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.AutoButtonColor = false
ExitBtn.ZIndex = 11
ExitBtn.Parent = ConfirmBox

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(0, 6)
ExitCorner.Parent = ExitBtn

-- Sidebar
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 145, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 48)
LogoText.BackgroundTransparency = 1
LogoText.Text = "<b><font color=\"#FFFFFF\">angel</font><font color=\"#B4D2FF\">.cc</font></b>"
LogoText.RichText = true
LogoText.TextSize = 17
LogoText.Font = Enum.Font.Gotham
LogoText.Parent = SideBar

local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0, 1, 1, -20)
Separator.Position = UDim2.new(1, -1, 0, 10)
Separator.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Separator.BorderSizePixel = 0
Separator.Parent = SideBar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -16, 1, -60)
TabContainer.Position = UDim2.new(0, 8, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = SideBar

local TabList = Instance.new("UIListLayout")
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabContainer

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, -145, 0, 40)
TopBar.Position = UDim2.new(0, 145, 0, 0)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(130, 130, 145)
CloseBtn.TextSize = 11
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -62, 0.5, -12)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(130, 130, 145)
MinimizeBtn.TextSize = 11
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.AutoButtonColor = false
MinimizeBtn.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeBtn

-- Логика подтверждения закрытия
CloseBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = true
end)

CancelBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = false
end)

ExitBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Плавное сворачивание и разворачивание
local isAnimating = false

MinimizeBtn.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    
    -- Вычисляем позицию чутка выше текущего положения меню
    local mainPos = MainShadow.Position
    ToggleWidget.Position = UDim2.new(mainPos.X.Scale, mainPos.X.Offset - 55, mainPos.Y.Scale, mainPos.Y.Offset - 210)
    
    ToggleWidget.Size = UDim2.new(0, 0, 0, 34)
    ToggleWidget.Visible = true
    
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 0)}):Play()
    TweenService:Create(MainShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 0)}):Play()
    TweenService:Create(ToggleWidget, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 110, 0, 34)}):Play()
    
    task.wait(0.3)
    MainShadow.Visible = false
    MainFrame.Size = UDim2.new(0, 520, 0, 330)
    MainShadow.Size = UDim2.new(0, 560, 0, 370)
    isAnimating = false
end)

ToggleWidget.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    
    MainShadow.Visible = true
    MainFrame.Size = UDim2.new(0, 520, 0, 0)
    MainShadow.Size = UDim2.new(0, 560, 0, 0)
    
    TweenService:Create(ToggleWidget, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 34)}):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 330)}):Play()
    TweenService:Create(MainShadow, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 370)}):Play()
    
    task.wait(0.25)
    ToggleWidget.Visible = false
    ToggleWidget.Size = UDim2.new(0, 110, 0, 34)
    isAnimating = false
end)

EnableDrag(TopBar, MainShadow)

local ContentFolder = Instance.new("Frame")
ContentFolder.Name = "ContentFolder"
ContentFolder.Size = UDim2.new(1, -160, 1, -50)
ContentFolder.Position = UDim2.new(0, 155, 0, 45)
ContentFolder.BackgroundTransparency = 1
ContentFolder.Parent = MainFrame

local Tabs = {}
local ActiveTab = nil

local function CreateTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    TabBtn.ClipsDescendants = true
    TabBtn.Parent = TabContainer

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn

    local TabStroke = Instance.new("UIStroke")
    TabStroke.Thickness = 1
    TabStroke.Color = Color3.fromRGB(15, 15, 22)
    TabStroke.Parent = TabBtn

    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(1, -20, 1, 0)
    TabLabel.Position = UDim2.new(0, 12, 0, 0)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Text = name
    TabLabel.TextColor3 = Color3.fromRGB(110, 110, 130)
    TabLabel.TextSize = 12
    TabLabel.Font = Enum.Font.GothamMedium
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.Parent = TabBtn

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 4, 0, 4)
    Dot.Position = UDim2.new(1, -12, 0.5, -2)
    Dot.BackgroundColor3 = Color3.fromRGB(180, 210, 255)
    Dot.BackgroundTransparency = 1
    Dot.Parent = TabBtn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(30, 30, 45)
    Page.Visible = false
    Page.Parent = ContentFolder

    local PageList = Instance.new("UIListLayout")
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 7)
    PageList.Parent = Page

    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(6, 6, 10)}):Play()
            TweenService:Create(t.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(15, 15, 22)}):Play()
            TweenService:Create(t.Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(110, 110, 130)}):Play()
            TweenService:Create(t.Dot, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(12, 12, 18)}):Play()
        TweenService:Create(TabStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(35, 45, 65)}):Play()
        TweenService:Create(TabLabel, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 240, 255)}):Play()
        TweenService:Create(Dot, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)

    Tabs[name] = {Btn = TabBtn, Page = Page, Stroke = TabStroke, Label = TabLabel, Dot = Dot}
    
    if not ActiveTab then
        ActiveTab = name
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        TabStroke.Color = Color3.fromRGB(35, 45, 65)
        TabLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
        Dot.BackgroundTransparency = 0
    end

    local PageElements = {}

    -- TOGGLE
    function PageElements:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, -10, 0, 38)
        Toggle.BackgroundColor3 = Color3.fromRGB(9, 9, 14)
        Toggle.Text = ""
        Toggle.AutoButtonColor = false
        Toggle.Parent = Page

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCorner.Parent = Toggle

        local ToggleStroke = Instance.new("UIStroke")
        ToggleStroke.Thickness = 1
        ToggleStroke.Color = Color3.fromRGB(18, 18, 26)
        ToggleStroke.Parent = Toggle

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -50, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(190, 190, 205)
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Toggle

        local SwitchBg = Instance.new("Frame")
        SwitchBg.Size = UDim2.new(0, 30, 0, 16)
        SwitchBg.Position = UDim2.new(1, -38, 0.5, -8)
        SwitchBg.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
        SwitchBg.Parent = Toggle

        local SwitchCorner = Instance.new("UICorner")
        SwitchCorner.CornerRadius = UDim.new(1, 0)
        SwitchCorner.Parent = SwitchBg

        local SwitchDot = Instance.new("Frame")
        SwitchDot.Size = UDim2.new(0, 12, 0, 12)
        SwitchDot.Position = UDim2.new(0, 2, 0.5, -6)
        SwitchDot.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        SwitchDot.Parent = SwitchBg

        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = SwitchDot

        local state = false
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            if state then
                TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 210, 255)}):Play()
                TweenService:Create(SwitchDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(10, 10, 15)}):Play()
                TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(40, 50, 70)}):Play()
            else
                TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 26)}):Play()
                TweenService:Create(SwitchDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(80, 80, 100)}):Play()
                TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(18, 18, 26)}):Play()
            end
            if callback then callback(state) end
        end)
    end

    -- DROPDOWN
    function PageElements:AddDropdown(text, options, callback)
        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
        DropdownFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 14)
        DropdownFrame.ClipsDescendants = true
        DropdownFrame.Parent = Page

        local DropCorner = Instance.new("UICorner")
        DropCorner.CornerRadius = UDim.new(0, 8)
        DropCorner.Parent = DropdownFrame

        local DropStroke = Instance.new("UIStroke")
        DropStroke.Thickness = 1
        DropStroke.Color = Color3.fromRGB(18, 18, 26)
        DropStroke.Parent = DropdownFrame

        local DropBtn = Instance.new("TextButton")
        DropBtn.Size = UDim2.new(1, 0, 0, 38)
        DropBtn.BackgroundTransparency = 1
        DropBtn.Text = ""
        DropBtn.AutoButtonColor = false
        DropBtn.Parent = DropdownFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.5, 0, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(190, 190, 205)
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = DropBtn

        local SelectedLabel = Instance.new("TextLabel")
        SelectedLabel.Size = UDim2.new(0.5, -30, 1, 0)
        SelectedLabel.Position = UDim2.new(0.5, -10, 0, 0)
        SelectedLabel.BackgroundTransparency = 1
        SelectedLabel.Text = options[1] or "None"
        SelectedLabel.TextColor3 = Color3.fromRGB(180, 210, 255)
        SelectedLabel.TextSize = 11
        SelectedLabel.Font = Enum.Font.Gotham
        SelectedLabel.TextXAlignment = Enum.TextXAlignment.Right
        SelectedLabel.Parent = DropBtn

        local Arrow = Instance.new("TextLabel")
        Arrow.Size = UDim2.new(0, 20, 1, 0)
        Arrow.Position = UDim2.new(1, -25, 0, 0)
        Arrow.BackgroundTransparency = 1
        Arrow.Text = "▼"
        Arrow.TextColor3 = Color3.fromRGB(100, 100, 120)
        Arrow.TextSize = 9
        Arrow.Font = Enum.Font.GothamBold
        Arrow.Parent = DropBtn

        local OptionContainer = Instance.new("ScrollingFrame")
        OptionContainer.Size = UDim2.new(1, -16, 0, 0)
        OptionContainer.Position = UDim2.new(0, 8, 0, 38)
        OptionContainer.BackgroundTransparency = 1
        OptionContainer.BorderSizePixel = 0
        OptionContainer.ScrollBarThickness = 0
        OptionContainer.Parent = DropdownFrame

        local OptionList = Instance.new("UIListLayout")
        OptionList.SortOrder = Enum.SortOrder.LayoutOrder
        OptionList.Padding = UDim.new(0, 4)
        OptionList.Parent = OptionContainer

        local opened = false
        local function ToggleDropdown()
            opened = not opened
            local targetSize = opened and UDim2.new(1, -10, 0, math.min(#options * 28 + 44, 150)) or UDim2.new(1, -10, 0, 38)
            local containerHeight = opened and math.min(#options * 28 + 2, 104) or 0
            
            TweenService:Create(DropdownFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize}):Play()
            TweenService:Create(OptionContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, containerHeight)}):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = opened and 180 or 0}):Play()
            TweenService:Create(DropStroke, TweenInfo.new(0.2), {Color = opened and Color3.fromRGB(35, 45, 65) or Color3.fromRGB(18, 18, 26)}):Play()
        end

        DropBtn.MouseButton1Click:Connect(ToggleDropdown)

        for _, opt in ipairs(options) do
            local OptBtn = Instance.new("TextButton")
            OptBtn.Size = UDim2.new(1, 0, 0, 24)
            OptBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
            OptBtn.Text = "  " .. opt
            OptBtn.TextColor3 = Color3.fromRGB(130, 130, 150)
            OptBtn.TextSize = 11
            OptBtn.Font = Enum.Font.Gotham
            OptBtn.TextXAlignment = Enum.TextXAlignment.Left
            OptBtn.AutoButtonColor = false
            OptBtn.Parent = OptionContainer

            local OptCorner = Instance.new("UICorner")
            OptCorner.CornerRadius = UDim.new(0, 6)
            OptCorner.Parent = OptBtn

            OptBtn.MouseButton1Click:Connect(function()
                SelectedLabel.Text = opt
                ToggleDropdown()
                if callback then callback(opt) end
            end)
        end
    end

    return PageElements
end

local MainTab = CreateTab("Main")
local VisualsTab = CreateTab("Visuals")
local WorldTab = CreateTab("World")
CreateTab("Settings")

MainTab:AddToggle("Auto Farm Kills", function(state) end)
MainTab:AddDropdown("Farm Method", {"Teleport", "Tween", "Behind Player"}, function(selected) end)

VisualsTab:AddToggle("Player ESP", function(state) end)
VisualsTab:AddDropdown("ESP Style", {"Boxes", "Tracers", "Skeleton", "3D Box"}, function(selected) end)

WorldTab:AddToggle("Remove Atmosphere", function(state) end)

RunService.RenderStepped:Connect(function(dt)
    if not ScreenGui.Parent then return end
    KeyGradient.Rotation = (KeyGradient.Rotation + dt * 40) % 360
    MainGradient.Rotation = (MainGradient.Rotation + dt * 40) % 360
    WidgetGradient.Rotation = (WidgetGradient.Rotation + dt * 40) % 360
end)

-- =================================================================
-- 3. AUTH LOGIC
-- =================================================================
SubmitBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Checking..."
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 100)
    
    task.spawn(function()
        local success, response = pcall(function()
            return game:HttpGet(GITHUB_KEYS_URL)
        end)

        if success then
            local jsonSuccess, keysTable = pcall(function()
                return HttpService:JSONDecode(response)
            end)

            if jsonSuccess and keysTable[KeyInput.Text] then
                local registeredHWID = keysTable[KeyInput.Text]
                
                if registeredHWID == "FREE" or registeredHWID == ClientHWID then
                    StatusLabel.Text = "Success! Loading..."
                    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 160)
                    
                    task.wait(0.3)
                    KeyShadow.Visible = false
                    MainShadow.Visible = true
                else
                    StatusLabel.Text = "HWID Mismatch!"
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
                end
            else
                StatusLabel.Text = "Invalid Key!"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            end
        else
            StatusLabel.Text = "GitHub connection failed!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        end
    end)
end)

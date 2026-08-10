-- [[ SERVICES ]] --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local TargetParent = gethui and gethui() or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

if TargetParent:FindFirstChild("angel_cc") then 
    TargetParent["angel_cc"]:Destroy() 
end

-- [[ CONFIG & HWID ]] --
local GITHUB_KEYS_URL = "https://raw.githubusercontent.com/c1lh/angel-cc/main/keys.json"
local ClientHWID = gethwid and gethwid() or game:GetService("RbxAnalyticsService"):GetClientId()

-- [[ MAIN GUI SETUP ]] --
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

-- KEY SYSTEM
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

-- MAIN MENU
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

-- TOGGLE WIDGET
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

-- CONFIRM OVERLAY
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

-- SIDEBAR & TOPBAR
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

CloseBtn.MouseButton1Click:Connect(function() ConfirmOverlay.Visible = true end)
CancelBtn.MouseButton1Click:Connect(function() ConfirmOverlay.Visible = false end)
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local isAnimating = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
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

-- API ДЛЯ СОЗДАНИЯ ВКЛАДОК И КНОПОК
local Library = {}

function Library:CreateTab(name)
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

    function PageElements:AddButton(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 34)
        Btn.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(200, 210, 230)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.GothamMedium
        Btn.AutoButtonColor = false
        Btn.Parent = Page

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = Btn

        local BtnStroke = Instance.new("UIStroke")
        BtnStroke.Thickness = 1
        BtnStroke.Color = Color3.fromRGB(25, 25, 35)
        BtnStroke.Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
            task.wait(0.1)
            TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(12, 12, 18)}):Play()
            if callback then callback() end
        end)
    end

    return PageElements
end

RunService.RenderStepped:Connect(function(dt)
    if not ScreenGui.Parent then return end
    KeyGradient.Rotation = (KeyGradient.Rotation + dt * 40) % 360
    MainGradient.Rotation = (MainGradient.Rotation + dt * 40) % 360
    WidgetGradient.Rotation = (WidgetGradient.Rotation + dt * 40) % 360
end)

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

-- =================================================================
-- 4. ТВОИ ВКЛАДКИ И ФУНКЦИИ
-- =================================================================

-- Создаём вкладки
local MainTab = Library:CreateTab("Main")
local VisualsTab = Library:CreateTab("Visuals")
local ItemsTab = Library:CreateTab("Items")
local SettingsTab = Library:CreateTab("Settings")

--------------------------------------------------------------------
-- MAIN TAB
--------------------------------------------------------------------
MainTab:AddButton("Rejoin Game", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

MainTab:AddToggle("Auto Farm Kills", function(state)
    if state then
        print("Автофарм включен!")
    else
        print("Автофарм выключен!")
    end
end)

MainTab:AddDropdown("Farm Method", {"Teleport", "Tween", "Behind Player"}, function(selected)
    print("Выбран метод:", selected)
end)

--------------------------------------------------------------------
-- VISUALS TAB (CLEANED FOV-ONLY ENGINE)
--------------------------------------------------------------------
local Camera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = Workspace.CurrentCamera
end)

local VisualState = {
    ChamsEnabled = false,
    ChamsFillAlpha = 0.5,
    ChamsMode = Enum.HighlightDepthMode.AlwaysOnTop,
    ChamsConnections = {},
    Highlights = {},

    AtmosphereEnabled = false,
    CurrentPreset = "Clean",

    CamEffectsEnabled = false,
    TargetFOV = 70,

    OriginalCamera = {
        FieldOfView = Camera and Camera.FieldOfView or 70
    }
}

-- 1. HIGHLIGHTS / CHAMS
local function ApplyHighlightToPlayer(player)
    if player == LocalPlayer then return end
    
    local function SetupHighlight(char)
        if not char then return end
        if VisualState.Highlights[player] then
            VisualState.Highlights[player]:Destroy()
            VisualState.Highlights[player] = nil
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "Angel_Chams_" .. player.Name
        highlight.FillColor = Color3.fromRGB(160, 200, 255)
        highlight.OutlineColor = Color3.fromRGB(255, 160, 220)
        highlight.FillTransparency = VisualState.ChamsFillAlpha
        highlight.OutlineTransparency = 0
        highlight.DepthMode = VisualState.ChamsMode
        highlight.Adornee = char
        highlight.Parent = char

        VisualState.Highlights[player] = highlight
    end

    if player.Character then
        SetupHighlight(player.Character)
    end

    local conn = player.CharacterAdded:Connect(function(char)
        if VisualState.ChamsEnabled then
            task.wait(0.2)
            SetupHighlight(char)
        end
    end)
    table.insert(VisualState.ChamsConnections, conn)
end

local function EnableChams()
    VisualState.ChamsEnabled = true
    for _, player in ipairs(Players:GetPlayers()) do
        ApplyHighlightToPlayer(player)
    end

    local playerAddedConn = Players.PlayerAdded:Connect(function(player)
        if VisualState.ChamsEnabled then
            ApplyHighlightToPlayer(player)
        end
    end)
    table.insert(VisualState.ChamsConnections, playerAddedConn)

    local playerRemovingConn = Players.PlayerRemoving:Connect(function(player)
        if VisualState.Highlights[player] then
            VisualState.Highlights[player]:Destroy()
            VisualState.Highlights[player] = nil
        end
    end)
    table.insert(VisualState.ChamsConnections, playerRemovingConn)
end

local function DisableChams()
    VisualState.ChamsEnabled = false
    for _, conn in ipairs(VisualState.ChamsConnections) do
        conn:Disconnect()
    end
    table.clear(VisualState.ChamsConnections)

    for player, hl in pairs(VisualState.Highlights) do
        if hl and hl.Parent then
            hl:Destroy()
        end
    end
    table.clear(VisualState.Highlights)
end

local function UpdateChamsProperties()
    for _, hl in pairs(VisualState.Highlights) do
        if hl and hl.Parent then
            hl.FillTransparency = VisualState.ChamsFillAlpha
            hl.DepthMode = VisualState.ChamsMode
        end
    end
end

-- 2. ATMOSPHERE PRESETS (СОХРАНЕНЫ БЕЗ ИЗМЕНЕНИЙ)
local BalancedPresets = {
    Clean = {
        ClockTime = 14,
        Brightness = 1.5,
        ExposureCompensation = 0,
        OutdoorAmbient = Color3.fromRGB(110, 115, 125),
        Ambient = Color3.fromRGB(80, 80, 85),
        ColorCorrection = { TintColor = Color3.fromRGB(255, 255, 255), Saturation = 0.05, Contrast = 0.02 },
        Bloom = { Intensity = 0.15, Size = 12, Threshold = 0.95 }
    },
    Cyber = {
        ClockTime = 1,
        Brightness = 1.0,
        ExposureCompensation = -0.1,
        OutdoorAmbient = Color3.fromRGB(30, 45, 60),
        Ambient = Color3.fromRGB(20, 35, 50),
        ColorCorrection = { TintColor = Color3.fromRGB(190, 235, 255), Saturation = 0.2, Contrast = 0.1 },
        Bloom = { Intensity = 0.35, Size = 20, Threshold = 0.85 }
    },
    Dream = {
        ClockTime = 17,
        Brightness = 1.6,
        ExposureCompensation = 0.05,
        OutdoorAmbient = Color3.fromRGB(110, 90, 105),
        Ambient = Color3.fromRGB(90, 75, 90),
        ColorCorrection = { TintColor = Color3.fromRGB(255, 225, 235), Saturation = 0.12, Contrast = 0.04 },
        Bloom = { Intensity = 0.25, Size = 24, Threshold = 0.9 }
    },
    Dark = {
        ClockTime = 0,
        Brightness = 0.6,
        ExposureCompensation = -0.25,
        OutdoorAmbient = Color3.fromRGB(18, 20, 28),
        Ambient = Color3.fromRGB(15, 16, 22),
        ColorCorrection = { TintColor = Color3.fromRGB(210, 215, 230), Saturation = -0.15, Contrast = 0.12 },
        Bloom = { Intensity = 0.1, Size = 10, Threshold = 0.95 }
    },
    Aurora = {
        ClockTime = 20,
        Brightness = 1.2,
        ExposureCompensation = -0.05,
        OutdoorAmbient = Color3.fromRGB(40, 70, 75),
        Ambient = Color3.fromRGB(30, 50, 55),
        ColorCorrection = { TintColor = Color3.fromRGB(190, 245, 230), Saturation = 0.18, Contrast = 0.06 },
        Bloom = { Intensity = 0.25, Size = 18, Threshold = 0.88 }
    }
}

local WorldInstances = {}
local function GetManagedInstance(className, name)
    local inst = WorldInstances[name]
    if not inst or not inst.Parent then
        inst = Instance.new(className)
        inst.Name = "Angel_" .. name
        WorldInstances[name] = inst
    end
    return inst
end

local function RemoveManagedInstance(name)
    local inst = WorldInstances[name]
    if inst then
        if typeof(inst) == "Instance" and inst.Parent then
            inst:Destroy()
        end
        WorldInstances[name] = nil
    end
end

local function ApplyAtmospherePreset(name)
    local preset = BalancedPresets[name]
    if not preset then return end

    TweenService:Create(Lighting, TweenInfo.new(0.5), {
        ClockTime = preset.ClockTime,
        Brightness = preset.Brightness,
        ExposureCompensation = preset.ExposureCompensation,
        OutdoorAmbient = preset.OutdoorAmbient,
        Ambient = preset.Ambient
    }):Play()

    local cc = GetManagedInstance("ColorCorrectionEffect", "CC")
    cc.Parent = Lighting
    TweenService:Create(cc, TweenInfo.new(0.5), {
        TintColor = preset.ColorCorrection.TintColor,
        Saturation = preset.ColorCorrection.Saturation,
        Contrast = preset.ColorCorrection.Contrast
    }):Play()

    local bloom = GetManagedInstance("BloomEffect", "Bloom")
    bloom.Parent = Lighting
    TweenService:Create(bloom, TweenInfo.new(0.5), {
        Intensity = preset.Bloom.Intensity,
        Size = preset.Bloom.Size,
        Threshold = preset.Bloom.Threshold
    }):Play()
end

local function RestoreLighting()
    TweenService:Create(Lighting, TweenInfo.new(0.5), {
        ClockTime = Lighting.ClockTime,
        Brightness = 2,
        ExposureCompensation = 0,
        OutdoorAmbient = Color3.fromRGB(128, 128, 128),
        Ambient = Color3.fromRGB(128, 128, 128)
    }):Play()

    RemoveManagedInstance("CC")
    RemoveManagedInstance("Bloom")
end

-- 3. ROBUST WORKING FOV CONTROLLER
local function UpdateCameraFOV(fov)
    VisualState.TargetFOV = fov
    if VisualState.CamEffectsEnabled and Camera then
        TweenService:Create(Camera, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            FieldOfView = fov
        }):Play()
    end
end

local function RestoreCamera()
    if Camera then
        TweenService:Create(Camera, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            FieldOfView = VisualState.OriginalCamera.FieldOfView
        }):Play()
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    Camera = Workspace.CurrentCamera
    if VisualState.CamEffectsEnabled then
        UpdateCameraFOV(VisualState.TargetFOV)
    end
end)

-- REGISTERING CONTROLS IN VISUALSTAB
VisualsTab:AddDropdown("Preset Theme", {"Clean", "Cyber", "Dream", "Dark", "Aurora"}, function(selected)
    VisualState.CurrentPreset = selected
    if VisualState.AtmosphereEnabled then
        ApplyAtmospherePreset(selected)
    end
end)

VisualsTab:AddToggle("Custom Atmosphere", function(state)
    VisualState.AtmosphereEnabled = state
    if state then
        ApplyAtmospherePreset(VisualState.CurrentPreset)
    else
        RestoreLighting()
    end
end)

VisualsTab:AddToggle("Player Highlights", function(state)
    if state then
        EnableChams()
    else
        DisableChams()
    end
end)

VisualsTab:AddDropdown("Chams Mode", {"AlwaysOnTop", "Occluded"}, function(selected)
    VisualState.ChamsMode = (selected == "AlwaysOnTop") and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    UpdateChamsProperties()
end)

VisualsTab:AddDropdown("Chams Opacity", {"Subtle (0.8)", "Balanced (0.5)", "Solid (0.2)"}, function(selected)
    if selected:find("Subtle") then
        VisualState.ChamsFillAlpha = 0.8
    elseif selected:find("Solid") then
        VisualState.ChamsFillAlpha = 0.2
    else
        VisualState.ChamsFillAlpha = 0.5
    end
    UpdateChamsProperties()
end)

VisualsTab:AddToggle("Camera FX (FOV)", function(state)
    VisualState.CamEffectsEnabled = state
    if state then
        UpdateCameraFOV(VisualState.TargetFOV)
    else
        RestoreCamera()
    end
end)

VisualsTab:AddDropdown("FOV Mode", {"Default (70)", "Wide (90)", "UltraWide (110)", "Cinematic (50)"}, function(selected)
    local fovMap = {
        ["Default (70)"] = 70,
        ["Wide (90)"] = 90,
        ["UltraWide (110)"] = 110,
        ["Cinematic (50)"] = 50
    }
    UpdateCameraFOV(fovMap[selected] or 70)
end)

VisualsTab:AddButton("Reset All Visuals", function()
    DisableChams()
    RestoreLighting()
    RestoreCamera()

    VisualState.AtmosphereEnabled = false
    VisualState.CamEffectsEnabled = false
end)

--------------------------------------------------------------------
-- ITEMS TAB (MM2 DECORATIVE & FUN ITEMS WITH PERSISTENCE)
--------------------------------------------------------------------
local ItemStates = {
    ["Cola / Drink"] = false,
    ["Mm2 Knife"] = false,
    ["Mm2 Gun"] = false,
    ["Granade"] = false,
    ["Mm2 Bomb"] = false,
    ["Plushie"] = false,
    ["Magic Wand"] = false,
    ["Flashlight"] = false,
    ["Funny Hat"] = false,
    ["Mystery Coin"] = false
}

local ActiveItemInstances = {}

local function RemoveItemInstance(itemName)
    if ActiveItemInstances[itemName] then
        if typeof(ActiveItemInstances[itemName]) == "Instance" and ActiveItemInstances[itemName].Parent then
            ActiveItemInstances[itemName]:Destroy()
        end
        ActiveItemInstances[itemName] = nil
    end
end

local function CreateItemProp(itemName, character)
    RemoveItemInstance(itemName)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")

    if not rootPart then return end

    local model = Instance.new("Model")
    model.Name = "Angel_Item_" .. itemName

    if itemName == "Cola / Drink" then
        local part = Instance.new("Part")
        part.Size = Vector3.new(0.6, 1.2, 0.6)
        part.Color = Color3.fromRGB(220, 20, 60)
        part.Material = Enum.Material.SmoothPlastic
        part.Position = rootPart.Position + Vector3.new(1, 0, 0)
        part.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = part
        weld.Part1 = rightHand or rootPart
        weld.Parent = part
    elseif itemName == "Mm2 Knife" then
        local blade = Instance.new("Part")
        blade.Size = Vector3.new(0.2, 0.2, 1.2)
        blade.Color = Color3.fromRGB(200, 200, 220)
        blade.Material = Enum.Material.Metal
        blade.Parent = model
        local handle = Instance.new("Part")
        handle.Size = Vector3.new(0.3, 0.3, 0.6)
        handle.Color = Color3.fromRGB(30, 30, 30)
        handle.Position = blade.Position - Vector3.new(0, 0, 0.8)
        handle.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = blade
        weld.Part1 = rightHand or rootPart
        weld.Parent = blade
    elseif itemName == "Mm2 Gun" then
        local gun = Instance.new("Part")
        gun.Size = Vector3.new(0.4, 0.8, 1.0)
        gun.Color = Color3.fromRGB(40, 40, 45)
        gun.Material = Enum.Material.Metal
        gun.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = gun
        weld.Part1 = rightHand or rootPart
        weld.Parent = gun
    elseif itemName == "Granade" or itemName == "Mm2 Bomb" then
        local bomb = Instance.new("Part")
        bomb.Shape = Enum.PartType.Ball
        bomb.Size = Vector3.new(1, 1, 1)
        bomb.Color = itemName == "Mm2 Bomb" and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(50, 80, 50)
        bomb.Material = Enum.Material.Slate
        bomb.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = bomb
        weld.Part1 = rightHand or rootPart
        weld.Parent = bomb
    elseif itemName == "Plushie" then
        local plush = Instance.new("Part")
        plush.Size = Vector3.new(1.2, 1.2, 1.2)
        plush.Color = Color3.fromRGB(255, 180, 200)
        plush.Shape = Enum.PartType.Ball
        plush.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = plush
        weld.Part1 = rightHand or rootPart
        weld.Parent = plush
    elseif itemName == "Magic Wand" then
        local wand = Instance.new("Part")
        wand.Size = Vector3.new(0.15, 0.15, 1.5)
        wand.Color = Color3.fromRGB(80, 40, 20)
        wand.Parent = model
        local tip = Instance.new("Part")
        tip.Size = Vector3.new(0.3, 0.3, 0.3)
        tip.Shape = Enum.PartType.Ball
        tip.Color = Color3.fromRGB(255, 255, 0)
        tip.Position = wand.Position + Vector3.new(0, 0, 0.8)
        tip.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = wand
        weld.Part1 = rightHand or rootPart
        weld.Parent = wand
    elseif itemName == "Flashlight" then
        local flash = Instance.new("Part")
        flash.Size = Vector3.new(0.3, 0.3, 1.0)
        flash.Color = Color3.fromRGB(200, 200, 200)
        flash.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = flash
        weld.Part1 = rightHand or rootPart
        weld.Parent = flash
    elseif itemName == "Funny Hat" then
        local hat = Instance.new("Part")
        hat.Size = Vector3.new(1.5, 0.4, 1.5)
        hat.Color = Color3.fromRGB(255, 100, 255)
        hat.Parent = model
        if head then
            hat.Position = head.Position + Vector3.new(0, 1, 0)
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hat
            weld.Part1 = head
            weld.Parent = hat
        end
    elseif itemName == "Mystery Coin" then
        local coin = Instance.new("Part")
        coin.Size = Vector3.new(0.6, 0.6, 0.1)
        coin.Shape = Enum.PartType.Cylinder
        coin.Color = Color3.fromRGB(255, 215, 0)
        coin.Material = Enum.Material.Neon
        coin.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = coin
        weld.Part1 = rightHand or rootPart
        weld.Parent = coin
    end

    model.Parent = character
    ActiveItemInstances[itemName] = model
end

local function RefreshAllActiveItems()
    local char = LocalPlayer.Character
    if not char then return end
    for itemName, isActive in pairs(ItemStates) do
        if isActive then
            CreateItemProp(itemName, char)
        else
            RemoveItemInstance(itemName)
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.6) -- Wait for character parts to fully load
    RefreshAllActiveItems()
end)

local itemNamesList = {
    "Cola / Drink",
    "Mm2 Knife",
    "Mm2 Gun",
    "Granade",
    "Mm2 Bomb",
    "Plushie",
    "Magic Wand",
    "Flashlight",
    "Funny Hat",
    "Mystery Coin"
}

for _, itemName in ipairs(itemNamesList) do
    ItemsTab:AddToggle(itemName, function(state)
        ItemStates[itemName] = state
        if state and LocalPlayer.Character then
            CreateItemProp(itemName, LocalPlayer.Character)
        else
            RemoveItemInstance(itemName)
        end
    end)
end

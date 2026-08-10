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

-- [[ CONFIGURATION ]] --
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
KeyShadow.Size = UDim2.new(0, 370, 0, 250)
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
KeyHolder.Size = UDim2.new(0, 330, 0, 210)
KeyHolder.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
KeyHolder.BorderSizePixel = 0
KeyHolder.ClipsDescendants = true
KeyHolder.Parent = KeyShadow

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyHolder

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 1.5
KeyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
KeyStroke.Parent = KeyHolder

local KeyStrokeGradient = Instance.new("UIGradient")
KeyStrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 230))
})
KeyStrokeGradient.Parent = KeyStroke

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "<b><font color=\"#FFFFFF\">angel</font><font color=\"#B4D2FF\">.cc</font></b> <font color=\"#555566\">// Security</font>"
KeyTitle.RichText = true
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.Gotham
KeyTitle.Parent = KeyHolder

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 38)
KeyInput.Position = UDim2.new(0, 20, 0, 60)
KeyInput.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
KeyInput.PlaceholderText = "Paste License Key..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 100)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(240, 240, 250)
KeyInput.TextSize = 12
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Parent = KeyHolder

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local CopyHwidBtn = Instance.new("TextButton")
CopyHwidBtn.Size = UDim2.new(0.5, -25, 0, 34)
CopyHwidBtn.Position = UDim2.new(0, 20, 0, 110)
CopyHwidBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
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
SubmitBtn.Text = "Authenticate"
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
StatusLabel.Text = "Connecting to GitHub..."
StatusLabel.TextColor3 = Color3.fromRGB(90, 90, 110)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyHolder

EnableDrag(KeyTitle, KeyShadow)

CopyHwidBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(ClientHWID)
        StatusLabel.Text = "HWID Copied!"
        StatusLabel.TextColor3 = Color3.fromRGB(180, 210, 255)
    end
end)

-- =================================================================
-- 2. MAIN MENU (PREMIUM LOOK)
-- =================================================================
local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "MainShadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.Size = UDim2.new(0, 560, 0, 370)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://1316045217"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.5
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
MainShadow.Visible = false
MainShadow.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 330)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainShadow

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Вращающаяся неон обводка
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local MainStrokeGradient = Instance.new("UIGradient")
MainStrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(180, 210, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 230)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(200, 255, 240)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
MainStrokeGradient.Parent = MainStroke

local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(4, 4, 6)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 14)
SideBarCorner.Parent = SideBar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 50)
LogoText.BackgroundTransparency = 1
LogoText.Text = "<b><font color=\"#FFFFFF\">angel</font><font color=\"#B4D2FF\">.cc</font></b>"
LogoText.RichText = true
LogoText.TextSize = 18
LogoText.Font = Enum.Font.Gotham
LogoText.Parent = SideBar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -16, 1, -60)
TabContainer.Position = UDim2.new(0, 8, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = SideBar

local TabList = Instance.new("UIListLayout")
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 6)
TabList.Parent = TabContainer

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, -150, 0, 40)
TopBar.Position = UDim2.new(0, 150, 0, 0)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(140, 140, 150)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
EnableDrag(TopBar, MainShadow)

local ContentFolder = Instance.new("Frame")
ContentFolder.Name = "ContentFolder"
ContentFolder.Size = UDim2.new(1, -160, 1, -50)
ContentFolder.Position = UDim2.new(0, 155, 0, 45)
ContentFolder.BackgroundTransparency = 1
ContentFolder.Parent = MainFrame

local Tabs = {}
local ActiveTab = nil

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 36)
    TabBtn.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    TabBtn.Text = "    " .. (icon or "•") .. "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(120, 120, 135)
    TabBtn.TextSize = 12
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.AutoButtonColor = false
    TabBtn.ClipsDescendants = true
    TabBtn.Parent = TabContainer

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0.6, 0)
    Indicator.Position = UDim2.new(0, 0, 0.2, 0)
    Indicator.BackgroundColor3 = Color3.fromRGB(180, 210, 255)
    Indicator.BackgroundTransparency = 1
    Indicator.BorderSizePixel = 0
    Indicator.Parent = TabBtn

    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(0, 2)
    IndCorner.Parent = Indicator

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 55)
    Page.Visible = false
    Page.Parent = ContentFolder

    local PageList = Instance.new("UIListLayout")
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 6)
    PageList.Parent = Page

    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            TweenService:Create(t.Btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(8, 8, 12), TextColor3 = Color3.fromRGB(120, 120, 135)}):Play()
            TweenService:Create(t.Indicator, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(16, 16, 24), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(Indicator, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
    end)

    Tabs[name] = {Btn = TabBtn, Page = Page, Indicator = Indicator}

    if not ActiveTab then
        ActiveTab = name
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Indicator.BackgroundTransparency = 0
    end

    local PageElements = {}

    function PageElements:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, -10, 0, 38)
        Toggle.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        Toggle.Text = ""
        Toggle.AutoButtonColor = false
        Toggle.Parent = Page

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCorner.Parent = Toggle

        local ToggleStroke = Instance.new("UIStroke")
        ToggleStroke.Thickness = 1
        ToggleStroke.Color = Color3.fromRGB(22, 22, 32)
        ToggleStroke.Parent = Toggle

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -50, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(200, 200, 215)
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Toggle

        local Switch = Instance.new("Frame")
        Switch.Size = UDim2.new(0, 32, 0, 18)
        Switch.Position = UDim2.new(1, -40, 0.5, -9)
        Switch.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Switch.Parent = Toggle

        local SwitchCorner = Instance.new("UICorner")
        SwitchCorner.CornerRadius = UDim.new(1, 0)
        SwitchCorner.Parent = Switch

        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.new(0, 14, 0, 14)
        Dot.Position = UDim2.new(0, 2, 0.5, -7)
        Dot.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
        Dot.Parent = Switch

        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = Dot

        local state = false
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            if state then
                TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 210, 255)}):Play()
                TweenService:Create(Dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = Color3.fromRGB(10, 10, 15)}):Play()
            else
                TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 32)}):Play()
                TweenService:Create(Dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(100, 100, 120)}):Play()
            end
            if callback then callback(state) end
        end)
    end

    return PageElements
end

local MainTab = CreateTab("Main", "⚡")
local VisualsTab = CreateTab("Visuals", "👁")
local WorldTab = CreateTab("World", "🌐")
local SettingsTab = CreateTab("Settings", "⚙")

MainTab:AddToggle("Auto Farm Kills", function(s) end)
VisualsTab:AddToggle("ESP Player Boxes", function(s) end)

-- Анимация перелива Градиентов
RunService.RenderStepped:Connect(function(dt)
    if not ScreenGui.Parent then return end
    KeyStrokeGradient.Rotation = (KeyStrokeGradient.Rotation + dt * 40) % 360
    MainStrokeGradient.Rotation = (MainStrokeGradient.Rotation + dt * 40) % 360
end)

-- =================================================================
-- 3. AUTH CHECK
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
                    StatusLabel.Text = "Access Granted!"
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
            StatusLabel.Text = "GitHub Connection Failed!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        end
    end)
end)

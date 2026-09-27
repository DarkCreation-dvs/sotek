local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")

local ICON_ID = "rbxassetid://85711970085659"

local function ResolveIcon(item)
    local ic = item.icon
    if type(ic) == "number" then
        return "rbxassetid://" .. ic
    elseif type(ic) == "string" and ic ~= "" then
        if ic:match("^%d+$") then
            return "rbxassetid://" .. ic
        end
        return ic
    end
    return ICON_ID
end

local CATEGORIES = {
    {
        name = "D'SOURCE",
        sections = {
            {
                header = "GUNS",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = ".50", label = ".50", amount = -0},
                    {name = "G19", label = "G19", amount = -0},
                },
            },
            {
                header = "ARMOR",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = "Heavy Helmet", label = "Helmet", amount = -0},
                    {name = "Heavy Vest",   label = "Vest",   amount = -0},
                },
            },
            {
                header = "MISC",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = "Heavy Helmet", label = "Money", amount = -1321},
                },
            },
        },
    },
        {
        name = "BLOODRAGE",
        sections = {
            {
                header = "GUNS",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = ".50", label = ".50", amount = -0},
                    {name = "G19", label = "G19", amount = -0},
                    {name = "G20", label = "G19", amount = -0},
                    {name = "Deagle", label = "G19", amount = -0},
                },
            },
            {
                header = "ARMOR",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = "Capsul", label = "Capsul", amount = -0},
                },
            },
            {
                header = "MISC",
                remote = {ReplicatedStorage, "GunStoreFolder", "BuyTool"},
                items  = {
                    {name = "Capsul", label = "Money", amount = -1321},
                },
            },
        },
    },
}

local C = {
    bg     = Color3.fromRGB(10, 10, 10),
    header = Color3.fromRGB(15, 15, 15),
    card   = Color3.fromRGB(14, 14, 14),
    border = Color3.fromRGB(30, 30, 30),
    tabOff = Color3.fromRGB(20, 20, 20),
    tabOn  = Color3.fromRGB(28, 28, 28),
    accent = Color3.fromRGB(255, 255, 255),
    text   = Color3.fromRGB(220, 220, 220),
    dim    = Color3.fromRGB(90, 90, 90),
    sub    = Color3.fromRGB(120, 120, 120),
    red    = Color3.fromRGB(220, 60, 60),
    green  = Color3.fromRGB(80, 200, 120),
    btnbg  = Color3.fromRGB(20, 20, 20),
}

local W        = 280
local FULL_H   = 420
local HEADER_H = 42
local TABBAR_H = 30

if CoreGui:FindFirstChild("SotekUI") then
    CoreGui.SotekUI:Destroy()
end

local SG = Instance.new("ScreenGui")
SG.Name           = "SotekUI"
SG.ResetOnSpawn   = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true
SG.Parent         = CoreGui

local Main = Instance.new("Frame")
Main.Name             = "Main"
Main.AnchorPoint      = Vector2.new(0.5, 0.5)
Main.Size             = UDim2.new(0, W, 0, FULL_H)
Main.Position         = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = C.bg
Main.BorderSizePixel  = 0
Main.ClipsDescendants = true
Main.Parent           = SG

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color     = C.border
MainStroke.Thickness = 1
MainStroke.Parent    = Main

local Header = Instance.new("Frame")
Header.Name             = "Header"
Header.Size             = UDim2.new(1, 0, 0, HEADER_H)
Header.BackgroundColor3 = C.header
Header.BorderSizePixel  = 0
Header.Parent           = Main

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local HeaderFill = Instance.new("Frame")
HeaderFill.Size             = UDim2.new(1, 0, 0.5, 0)
HeaderFill.Position         = UDim2.new(0, 0, 0.5, 0)
HeaderFill.BackgroundColor3 = C.header
HeaderFill.BorderSizePixel  = 0
HeaderFill.Parent           = Header

local Title = Instance.new("TextLabel")
Title.Size                   = UDim2.new(0, 160, 0, 16)
Title.Position               = UDim2.new(0, 14, 0, 6)
Title.BackgroundTransparency = 1
Title.Font                   = Enum.Font.GothamBold
Title.Text                   = "SOTEK"
Title.TextColor3             = C.accent
Title.TextSize               = 15
Title.TextXAlignment         = Enum.TextXAlignment.Left
Title.Parent                 = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size                   = UDim2.new(0, 160, 0, 12)
Subtitle.Position               = UDim2.new(0, 14, 0, 23)
Subtitle.BackgroundTransparency = 1
Subtitle.Font                   = Enum.Font.Gotham
Subtitle.Text                   = "dxrkqpalskie"
Subtitle.TextColor3             = C.sub
Subtitle.TextSize               = 10
Subtitle.TextXAlignment         = Enum.TextXAlignment.Left
Subtitle.Parent                 = Header

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Name                   = "Minimize"
MinBtn.Size                   = UDim2.new(0, 24, 0, 24)
MinBtn.Position               = UDim2.new(1, -56, 0, 9)
MinBtn.BackgroundTransparency = 1
MinBtn.Font                   = Enum.Font.GothamBold
MinBtn.Text                   = "—"
MinBtn.TextColor3             = C.dim
MinBtn.TextSize               = 14
MinBtn.AutoButtonColor        = false
MinBtn.Parent                 = Header

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size                   = UDim2.new(0, 24, 0, 24)
CloseBtn.Position               = UDim2.new(1, -30, 0, 9)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font                   = Enum.Font.GothamBold
CloseBtn.Text                   = "×"
CloseBtn.TextColor3             = C.dim
CloseBtn.TextSize               = 16
CloseBtn.AutoButtonColor        = false
CloseBtn.Parent                 = Header

MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.15), { TextColor3 = C.accent }):Play()
end)
MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.15), { TextColor3 = C.dim }):Play()
end)
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { TextColor3 = C.red }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { TextColor3 = C.dim }):Play()
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size                   = UDim2.new(1, -20, 0, TABBAR_H)
TabContainer.Position               = UDim2.new(0, 10, 0, HEADER_H + 6)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent                 = Main

local TabButtons = {}
local TabStrokes = {}
local TabNames   = {}

for i, cat in ipairs(CATEGORIES) do
    TabNames[i] = cat.name
end

local tabCount = #TabNames

for i, tabName in ipairs(TabNames) do
    local tab = Instance.new("TextButton")
    tab.Name             = "Tab_" .. tabName
    tab.Size             = UDim2.new(1 / tabCount, -4, 1, 0)
    tab.Position         = UDim2.new((i - 1) / tabCount, 0, 0, 0)
    tab.BackgroundColor3 = C.tabOff
    tab.BorderSizePixel  = 0
    tab.Font             = Enum.Font.GothamSemibold
    tab.Text             = tabName
    tab.TextColor3       = C.dim
    tab.TextSize         = 10
    tab.AutoButtonColor  = false
    tab.Parent           = TabContainer

    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)

    local st = Instance.new("UIStroke")
    st.Color        = C.border
    st.Thickness    = 1
    st.Transparency = 0.4
    st.Parent       = tab

    TabButtons[i] = tab
    TabStrokes[i] = st
end

local Content = Instance.new("ScrollingFrame")
Content.Name                   = "Content"
Content.Size                   = UDim2.new(1, -20, 1, -(HEADER_H + TABBAR_H + 22))
Content.Position               = UDim2.new(0, 10, 0, HEADER_H + TABBAR_H + 12)
Content.BackgroundTransparency = 1
Content.BorderSizePixel        = 0
Content.ScrollBarThickness     = 2
Content.ScrollBarImageColor3   = Color3.fromRGB(40, 40, 40)
Content.CanvasSize             = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize    = Enum.AutomaticSize.Y
Content.Parent                 = Main

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding   = UDim.new(0, 6)
ListLayout.Parent    = Content

local Padding = Instance.new("UIPadding")
Padding.PaddingBottom = UDim.new(0, 10)
Padding.Parent        = Content

local NotifContainer = Instance.new("Frame")
NotifContainer.Name                   = "Notifs"
NotifContainer.AnchorPoint            = Vector2.new(1, 0)
NotifContainer.Size                   = UDim2.new(0, 220, 1, 0)
NotifContainer.Position               = UDim2.new(1, -10, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent                 = SG

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.SortOrder         = Enum.SortOrder.LayoutOrder
NotifLayout.Padding           = UDim.new(0, 5)
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
NotifLayout.Parent            = NotifContainer

local function Notify(title, text, color)
    color = color or C.accent

    local nf = Instance.new("Frame")
    nf.Size                   = UDim2.new(1, 0, 0, 40)
    nf.BackgroundColor3       = Color3.fromRGB(10, 10, 10)
    nf.BackgroundTransparency = 1
    nf.BorderSizePixel        = 0
    nf.Parent                 = NotifContainer

    Instance.new("UICorner", nf).CornerRadius = UDim.new(0, 6)

    local ns = Instance.new("UIStroke")
    ns.Color        = color
    ns.Thickness    = 1
    ns.Transparency = 1
    ns.Parent       = nf

    local nt = Instance.new("TextLabel")
    nt.Size                   = UDim2.new(1, -14, 0, 16)
    nt.Position               = UDim2.new(0, 7, 0, 4)
    nt.BackgroundTransparency = 1
    nt.Text                   = title
    nt.TextColor3             = color
    nt.TextTransparency       = 1
    nt.TextXAlignment         = Enum.TextXAlignment.Left
    nt.Font                   = Enum.Font.GothamBold
    nt.TextSize               = 11
    nt.Parent                 = nf

    local nd = Instance.new("TextLabel")
    nd.Size                   = UDim2.new(1, -14, 0, 14)
    nd.Position               = UDim2.new(0, 7, 0, 21)
    nd.BackgroundTransparency = 1
    nd.Text                   = text
    nd.TextColor3             = C.dim
    nd.TextTransparency       = 1
    nd.TextXAlignment         = Enum.TextXAlignment.Left
    nd.Font                   = Enum.Font.Gotham
    nd.TextSize               = 10
    nd.TextTruncate           = Enum.TextTruncate.AtEnd
    nd.Parent                 = nf

    TweenService:Create(nf, TweenInfo.new(0.25), { BackgroundTransparency = 0.05 }):Play()
    TweenService:Create(ns, TweenInfo.new(0.25), { Transparency = 0.4 }):Play()
    TweenService:Create(nt, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
    TweenService:Create(nd, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()

    task.delay(3, function()
        if nf and nf.Parent then
            TweenService:Create(nf, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
            TweenService:Create(ns, TweenInfo.new(0.35), { Transparency = 1 }):Play()
            TweenService:Create(nt, TweenInfo.new(0.35), { TextTransparency = 1 }):Play()
            TweenService:Create(nd, TweenInfo.new(0.35), { TextTransparency = 1 }):Play()
            task.wait(0.35)
            if nf then nf:Destroy() end
        end
    end)
end

local REMOTE_CLASSES = {
    RemoteEvent      = true,
    RemoteFunction   = true,
    BindableEvent    = true,
    BindableFunction = true,
}

local function IsRemote(obj)
    return obj ~= nil and REMOTE_CLASSES[obj.ClassName] == true
end

local function DeepFindRemote(root, name)
    if not root then return nil end
    for _, d in ipairs(root:GetDescendants()) do
        if d.Name == name and IsRemote(d) then
            return d
        end
    end
    return nil
end

local function GetRemote(pathTable)
    if type(pathTable) ~= "table" or #pathTable == 0 then return nil end

    local current = pathTable[1]
    for i = 2, #pathTable do
        if not current then break end
        current = current:FindFirstChild(pathTable[i])
    end

    if IsRemote(current) then
        return current
    end

    local lastName = pathTable[#pathTable]
    local found = DeepFindRemote(pathTable[1], lastName)
    if found then return found end

    return DeepFindRemote(ReplicatedStorage, lastName)
end

local function PathToString(pathTable)
    local parts = {}
    for i = 2, #pathTable do
        parts[#parts + 1] = tostring(pathTable[i])
    end
    return table.concat(parts, "/")
end

local function InvokeRemote(remote, args)
    if remote:IsA("RemoteEvent") then
        remote:FireServer(table.unpack(args))
    elseif remote:IsA("RemoteFunction") then
        remote:InvokeServer(table.unpack(args))
    elseif remote:IsA("BindableEvent") then
        remote:Fire(table.unpack(args))
    elseif remote:IsA("BindableFunction") then
        remote:Invoke(table.unpack(args))
    else
        remote:FireServer(table.unpack(args))
    end
end

local function FireItem(item, section)
    local remote = GetRemote(section.remote)

    if not remote then
        Notify("ERROR", "Remote not found: " .. PathToString(section.remote), C.red)
        warn("[SOTEK] Remote not found:", PathToString(section.remote))
        return
    end

    local args = {item.name}
    if item.amount ~= nil then
        args[#args + 1] = item.amount
    end

    local ok, err = pcall(InvokeRemote, remote, args)

    if ok then
        local txt = item.label .. " → " .. item.name
        Notify("FIRED", txt .. " [" .. remote.ClassName .. "]", C.accent)
        print("[SOTEK] Fired", remote:GetFullName())
        for i, a in ipairs(args) do
            print("   arg[" .. i .. "] =", a)
        end
    else
        Notify("FAILED", tostring(err), C.red)
        warn("[SOTEK] Fire failed:", err)
    end
end

_G.SotekScan = function()
    print("SOTEK REMOTE SCAN")
    for _, d in ipairs(ReplicatedStorage:GetDescendants()) do
        if IsRemote(d) then
            print(d.ClassName, d:GetFullName())
        end
    end
    print("END SCAN")
end

local function BuildSectionHeader(text, order)
    local head = Instance.new("Frame")
    head.Name                   = "Section_" .. text
    head.Size                   = UDim2.new(1, 0, 0, 18)
    head.BackgroundTransparency = 1
    head.BorderSizePixel        = 0
    head.LayoutOrder            = order
    head.Parent                 = Content

    local lbl = Instance.new("TextLabel")
    lbl.Size                   = UDim2.new(1, -4, 1, 0)
    lbl.Position               = UDim2.new(0, 4, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = text
    lbl.TextColor3             = C.sub
    lbl.TextTransparency       = 1
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.Font                   = Enum.Font.GothamBold
    lbl.TextSize               = 10
    lbl.Parent                 = head

    TweenService:Create(lbl, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
end

local function BuildCard(item, order, animIdx, section)
    local Card = Instance.new("Frame")
    Card.Name                   = "Card_" .. tostring(item.name)
    Card.Size                   = UDim2.new(1, 0, 0, 44)
    Card.BackgroundColor3       = C.card
    Card.BackgroundTransparency = 1
    Card.BorderSizePixel        = 0
    Card.LayoutOrder            = order
    Card.Parent                 = Content

    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color        = C.border
    CardStroke.Thickness    = 1
    CardStroke.Transparency = 1
    CardStroke.Parent       = Card

    local IconFrame = Instance.new("Frame")
    IconFrame.Size                   = UDim2.new(0, 28, 0, 28)
    IconFrame.Position               = UDim2.new(0, 8, 0.5, -14)
    IconFrame.BackgroundColor3       = C.btnbg
    IconFrame.BackgroundTransparency = 1
    IconFrame.BorderSizePixel        = 0
    IconFrame.Parent                 = Card

    Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(0, 6)

    local IconStroke = Instance.new("UIStroke")
    IconStroke.Color        = C.border
    IconStroke.Thickness    = 1
    IconStroke.Transparency = 1
    IconStroke.Parent       = IconFrame

    local IconImg = Instance.new("ImageLabel")
    IconImg.Size                   = UDim2.new(1, -6, 1, -6)
    IconImg.Position               = UDim2.new(0, 3, 0, 3)
    IconImg.BackgroundTransparency = 1
    IconImg.Image                  = ResolveIcon(item)
    IconImg.ImageTransparency      = 1
    IconImg.ScaleType              = Enum.ScaleType.Fit
    IconImg.Parent                 = IconFrame

    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size                   = UDim2.new(0, 130, 0, 16)
    NameLbl.Position               = UDim2.new(0, 42, 0.5, -8)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text                   = item.label or item.name
    NameLbl.TextColor3             = C.text
    NameLbl.TextTransparency       = 1
    NameLbl.TextXAlignment         = Enum.TextXAlignment.Left
    NameLbl.Font                   = Enum.Font.GothamSemibold
    NameLbl.TextSize               = 12
    NameLbl.TextTruncate           = Enum.TextTruncate.AtEnd
    NameLbl.Parent                 = Card

    local BuyBtn = Instance.new("TextButton")
    BuyBtn.Size                   = UDim2.new(0, 64, 0, 24)
    BuyBtn.Position               = UDim2.new(1, -72, 0.5, -12)
    BuyBtn.BackgroundColor3       = C.btnbg
    BuyBtn.BackgroundTransparency = 1
    BuyBtn.BorderSizePixel        = 0
    BuyBtn.Text                   = "SPAWN"
    BuyBtn.TextColor3             = C.accent
    BuyBtn.TextTransparency       = 1
    BuyBtn.Font                   = Enum.Font.GothamBold
    BuyBtn.TextSize               = 10
    BuyBtn.AutoButtonColor        = false
    BuyBtn.Parent                 = Card

    Instance.new("UICorner", BuyBtn).CornerRadius = UDim.new(0, 5)

    local BuyStroke = Instance.new("UIStroke")
    BuyStroke.Color        = Color3.fromRGB(70, 70, 70)
    BuyStroke.Thickness    = 1
    BuyStroke.Transparency = 1
    BuyStroke.Parent       = BuyBtn

    task.spawn(function()
        task.wait(0.025 * animIdx)
        TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        }):Play()
        TweenService:Create(CardStroke, TweenInfo.new(0.3), { Transparency = 0.4 }):Play()
        TweenService:Create(IconFrame, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
        TweenService:Create(IconStroke, TweenInfo.new(0.3), { Transparency = 0.2 }):Play()
        TweenService:Create(IconImg, TweenInfo.new(0.3), { ImageTransparency = 0 }):Play()
        TweenService:Create(NameLbl, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
        TweenService:Create(BuyBtn, TweenInfo.new(0.3), { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
        TweenService:Create(BuyStroke, TweenInfo.new(0.3), { Transparency = 0.2 }):Play()
    end)

    BuyBtn.MouseEnter:Connect(function()
        TweenService:Create(BuyBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.accent }):Play()
        TweenService:Create(BuyBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(0, 0, 0) }):Play()
        TweenService:Create(BuyStroke, TweenInfo.new(0.15), { Color = C.accent, Transparency = 0 }):Play()
    end)

    BuyBtn.MouseLeave:Connect(function()
        TweenService:Create(BuyBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.btnbg }):Play()
        TweenService:Create(BuyBtn, TweenInfo.new(0.15), { TextColor3 = C.accent }):Play()
        TweenService:Create(BuyStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(70, 70, 70), Transparency = 0.2 }):Play()
    end)

    BuyBtn.MouseButton1Click:Connect(function()
        TweenService:Create(BuyBtn, TweenInfo.new(0.07), {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            TextColor3 = Color3.fromRGB(0, 0, 0)
        }):Play()
        task.delay(0.08, function()
            TweenService:Create(BuyBtn, TweenInfo.new(0.18), {
                BackgroundColor3 = C.btnbg,
                TextColor3 = C.accent
            }):Play()
        end)
        FireItem(item, section)
    end)

    Card.MouseEnter:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.15), {
            Color = Color3.fromRGB(70, 70, 70), Transparency = 0.1
        }):Play()
    end)
    Card.MouseLeave:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.25), {
            Color = C.border, Transparency = 0.4
        }):Play()
    end)
end

local activeTab = 0

local function SetTabVisual(i)
    for idx = 1, #TabButtons do
        local isActive = (idx == i)
        TweenService:Create(TabButtons[idx], TweenInfo.new(0.18), {
            TextColor3 = isActive and C.accent or C.dim,
            BackgroundColor3 = isActive and C.tabOn or C.tabOff,
        }):Play()
        TweenService:Create(TabStrokes[idx], TweenInfo.new(0.18), {
            Transparency = isActive and 0.15 or 0.4,
        }):Play()
    end
end

local function RenderCategory(i)
    activeTab = i
    SetTabVisual(i)

    for _, child in ipairs(Content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local cat = CATEGORIES[i]
    local order = 0
    local animIdx = 0
    for _, section in ipairs(cat.sections) do
        order = order + 1
        BuildSectionHeader(section.header, order)
        for _, item in ipairs(section.items) do
            order = order + 1
            animIdx = animIdx + 1
            BuildCard(item, order, animIdx, section)
        end
    end

    Content.CanvasPosition = Vector2.new(0, 0)
end

for i = 1, #TabButtons do
    TabButtons[i].MouseButton1Click:Connect(function()
        if activeTab ~= i then
            RenderCategory(i)
        end
    end)
end

local dragging   = false
local dragInput
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

local minimized = false
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function SetMinimized(state)
    minimized = state

    if minimized then
        MinBtn.Text = "+"
        TweenService:Create(Main, tweenInfo, { Size = UDim2.new(0, W, 0, HEADER_H) }):Play()
    else
        MinBtn.Text = "—"
        TweenService:Create(Main, tweenInfo, { Size = UDim2.new(0, W, 0, FULL_H) }):Play()
    end
end

MinBtn.MouseButton1Click:Connect(function()
    SetMinimized(not minimized)
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    NotifContainer.Visible = Main.Visible
end)

RenderCategory(1)

local totalItems = 0
for _, cat in ipairs(CATEGORIES) do
    for _, sec in ipairs(cat.sections) do
        totalItems = totalItems + #sec.items
    end
end

task.delay(0.2, function()
    Notify("SOTEK", "loaded — " .. #CATEGORIES .. " categories / " .. totalItems .. " items", C.accent)

    local testRemote = GetRemote(CATEGORIES[1].sections[1].remote)
    if testRemote then
        Notify("REMOTE OK", testRemote:GetFullName() .. " (" .. testRemote.ClassName .. ")", C.green)
    else
        Notify("REMOTE MISSING", "run _G.SotekScan() in console", C.red)
    end
end)

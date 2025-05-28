local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Variables
local mouse = Players.LocalPlayer:GetMouse()
local dragging = false
local dragInput
local dragStart
local startPos

-- Constants
local COLORS = {
    Background = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(35, 35, 35),
    Accent = Color3.fromRGB(255, 85, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 200),
    Border = Color3.fromRGB(60, 60, 60)
}

local CORNERS = {
    Small = UDim.new(0, 4),
    Medium = UDim.new(0, 6),
    Large = UDim.new(0, 8)
}

local FONTS = {
    Regular = Enum.Font.Gotham,
    Medium = Enum.Font.GothamMedium,
    Bold = Enum.Font.GothamBold
}

-- Utility Functions
local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

local function CreateCorner(parent, radius)
    local corner = CreateInstance("UICorner", {
        CornerRadius = radius,
        Parent = parent
    })
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = CreateInstance("UIStroke", {
        Color = color,
        Thickness = thickness,
        Parent = parent
    })
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = CreateInstance("UIGradient", {
        Color = ColorSequence.new(colors),
        Rotation = rotation or 0,
        Parent = parent
    })
    return gradient
end

local function Tween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Color Picker Component
if not LPH_OBFUSCATED then
    LPH_JIT_MAX = function(...) return(...) end;
    LPH_NO_VIRTUALIZE = function(...) return(...) end;
end

local utility = {}
local UIS = game:GetService("UserInputService");
local RS = game:GetService("RunService");
local TS = game:GetService("TweenService");
local mouse = game:GetService('Players').LocalPlayer:GetMouse()

local components = {}
local componentIntegrity = {}
local canDrag = true
local mainKeybind = "LeftAlt"
local function CreateDrag(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos
    local function update(input)
        local delta = input.Position - dragStart
        TS:Create(gui, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play();
    end
    local lastEnd = 0
    local lastMoved = 0
    local con
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if not canDrag then return end
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
        end
    end)
    UIS.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)


    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            lastMoved = os.clock()
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
local tweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo2 = TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo3 = TweenInfo.new(.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)

function Library:tween(object, goal, callback)
    local tween = TS:Create(object, tweenInfo, goal)
    tween.Completed:Connect(callback or function() end)
    tween:Play()
function Library:tween2(object, goal, callback)
    local tween = TS:Create(object, tweenInfo2, goal)
    tween.Completed:Connect(callback or function() end)
    tween:Play()
function Library:tween3(object, goal, callback)
    local tween = TS:Create(object, tweenInfo3, goal)
    tween.Completed:Connect(callback or function() end)
    tween:Play()
function Library:CreateWindow(options)
    
    local gui = {
        CurrentTab = nil
    }
    
    local ScreenGui = Instance.new('ScreenGui', gethui())
    local Main = Instance.new('Frame', ScreenGui)
    local TabBar = Instance.new('Frame', Main)
    local TabBarCorner = Instance.new('UICorner', TabBar)
    local SelectedTab = Instance.new('Frame', TabBar)
    local SelectedGradient = Instance.new('UIGradient', SelectedTab)
    local SelectedTabCorner = Instance.new('UICorner', SelectedTab)
    local TabBarStroke = Instance.new('UIStroke', TabBar)
    local Title = Instance.new('TextLabel', TabBar)
    local Divider = Instance.new('Frame', TabBar)
    local MainCorner = Instance.new('UICorner', Main)
    local Search = Instance.new('ImageButton', Main)
    
    local tabOffset = 0
    
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Main.Name = "Main"
    Main.Position = UDim2.new(0.228,0,0.2243,0)
    Main.Size = UDim2.new(0,716,0,439)
    Main.BackgroundColor3 = Color3.new(0.102,0.102,0.102)
    Main.BorderSizePixel = 0
    Main.BorderColor3 = Color3.new(0,0,0)
    Main.ZIndex = 100
    TabBar.Name = "TabBar"
    TabBar.Position = UDim2.new(0.0193,0,0.0274,0)
    TabBar.Size = UDim2.new(0,180,0,414)
    TabBar.BackgroundColor3 = Color3.new(0.1529,0.1529,0.1529)
    TabBar.BorderSizePixel = 0
    TabBar.BorderColor3 = Color3.new(0,0,0)
    TabBar.ZIndex = 101
    SelectedTab.Name = "SelectedTab"
    SelectedTab.Position = UDim2.new(0.0389,0,0.1836,0)
    SelectedTab.Size = UDim2.new(0,165,0,24)
    SelectedTab.BackgroundColor3 = Color3.new(1,1,1)
    SelectedTab.BorderSizePixel = 0
    SelectedTab.BorderColor3 = Color3.new(0,0,0)
    SelectedTab.ZIndex = 105
    Title.Name = "Title"
    Title.Size = UDim2.new(0,180,0,58)
    Title.BackgroundColor3 = Color3.new(1,1,1)
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.BorderColor3 = Color3.new(0,0,0)
    Title.Text = options.Title
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.Gotham
    Title.TextSize = 29
    Title.ZIndex = 120
    Divider.Name = "Divider"
    Divider.Position = UDim2.new(0.0667,0,0.1415,0)
    Divider.Size = UDim2.new(0,156,0,1)
    Divider.BackgroundColor3 = Color3.new(0.3255,0.3529,0.4235)
    Divider.BorderSizePixel = 0
    Divider.BorderColor3 = Color3.new(0,0,0)
    Divider.ZIndex = 121
    TabBarStroke.Color = Color3.new(0.251,0.251,0.251)
    SelectedGradient.Name = "SelectedGradient"
    SelectedGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.9607843160629272, 0.4117647111415863, 0.9764705896377563)), ColorSequenceKeypoint.new(1, Color3.new(0.5254902243614197, 0.43529412150382996, 1))})
    SelectedGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.2749999761581421,0), NumberSequenceKeypoint.new(1,0.32499998807907104,0)})
    Search.Name = "Search"
    Search.Position = UDim2.new(0.933,0,0.0274,0)
    Search.Size = UDim2.new(0,24,0,24)
    Search.BackgroundColor3 = Color3.new(1,1,1)
    Search.BackgroundTransparency = 1
    Search.BorderSizePixel = 0
    Search.BorderColor3 = Color3.new(0,0,0)
    Search.Image = "rbxassetid://15197354452"
    Search.ImageColor3 = Color3.new(0.5765,0.5765,0.5765)
    Search.ZIndex = 130
    
    local searchOpen = false
    
    local InputBox = Instance.new('Frame', Main)
    local SearchInput = Instance.new('TextBox', InputBox)
    local InputCorner = Instance.new('UICorner', InputBox)

    InputBox.Name = "InputBox"
    InputBox.Position = UDim2.new(0.933, 0,0.027, 0)
    InputBox.Size = UDim2.new(0,30,0,30)
    InputBox.BackgroundColor3 = Color3.new(0.102,0.102,0.102)
    InputBox.BorderSizePixel = 0
    InputBox.BorderColor3 = Color3.new(0,0,0)
    InputBox.ZIndex = 128
    SearchInput.Name = "SearchInput"
    SearchInput.Position = UDim2.new(0.0192,0,0,0)
    SearchInput.Size = UDim2.new(0,702,0,30)
    SearchInput.BackgroundColor3 = Color3.new(1,1,1)
    SearchInput.BackgroundTransparency = 1
    SearchInput.BorderSizePixel = 0
    SearchInput.BorderColor3 = Color3.new(0,0,0)
    SearchInput.Text = ""
    SearchInput.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
    SearchInput.Font = Enum.Font.Gotham
    SearchInput.Interactable = false
    SearchInput.TextSize = 14
    SearchInput.TextTransparency = 1
    SearchInput.ZIndex = 129
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.PlaceholderText = "Search..."
    SearchInput.PlaceholderColor3 = Color3.new(0.5765,0.5765,0.5765)
    InputCorner.CornerRadius = UDim.new(0,6)

    
    CreateDrag(Main)
    
    function Library:Toggle()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    UIS.InputBegan:Connect(function(key, gp)
        if gp then return end;

        if key.KeyCode == Enum.KeyCode[mainKeybind] then
            Library:Toggle()
        end
    end)
    
    Search.MouseButton1Click:Connect(function()
        if not searchOpen then
            Library:tween(InputBox, {Position = UDim2.new(0.933, 0,-0.082, 0)})
            task.spawn(function()
                wait(.3)
                Library:tween(InputBox, {Position = UDim2.new(0, 0,-0.082, 0)})
                Library:tween(InputBox, {Size = UDim2.new(0, 716,0, 30)})
                Library:tween(SearchInput, {TextTransparency = 0})
                SearchInput.Interactable = true
                searchOpen = true
            end)
        else
            if searchOpen then
                Library:tween(InputBox, {Position = UDim2.new(0.933, 0,-0.082, 0)})
                Library:tween(InputBox, {Size = UDim2.new(0,30,0,30)})
                Library:tween(SearchInput, {TextTransparency = 1})
                task.spawn(function()
                    wait(.3)
                    Library:tween(InputBox, {Position = UDim2.new(0.933, 0,0.027, 0)})
                    SearchInput.Interactable = false
                    SearchInput.Text = ""
                    searchOpen = false
                end)
            end
        end
    end)
    
    SearchInput:GetPropertyChangedSignal('Text'):Connect(function()
        local InputText = string.upper(SearchInput.Text)
        for i, v in pairs(Main:GetDescendants()) do
            if v.Name == "ComponentTitle" then
                if InputText=="" or string.find(string.upper(v.Text), InputText) ~= nil then 
                    v.Parent.Visible = true
                else
                    v.Parent.Visible = false
                end
            end
        end
    end)
    
    function gui:NewTab(options)
        
        local tab = {
            Active = false
        }

        local Tab = Instance.new('TextButton', TabBar)
        local Canvas = Instance.new('ScrollingFrame', Main)
        local CanvasLayout = Instance.new('UIListLayout', Canvas)
        local CanvasPad = Instance.new('UIPadding', Canvas)
        
        Tab.Name = "Tab"
        Tab.Position = UDim2.new(0,0,0.1884,0) + UDim2.new(0,0,tabOffset, 0)
        Tab.Size = UDim2.new(0,180,0,24)
        Tab.BackgroundColor3 = Color3.new(1,1,1)
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.BorderColor3 = Color3.new(0,0,0)
        Tab.Text = options.Name
        Tab.TextColor3 = Color3.new(1,1,1)
        Tab.Font = Enum.Font.Gotham
        Tab.TextSize = 17
        Tab.ZIndex = 106
        Canvas.Name = "Canvas"
        Canvas.Position = UDim2.new(0.2706,0,0.098,0)
        Canvas.Size = UDim2.new(0,522,0,383)
        Canvas.BackgroundColor3 = Color3.new(1,1,1)
        Canvas.BackgroundTransparency = 1
        Canvas.BorderSizePixel = 0
        Canvas.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Canvas.BorderColor3 = Color3.new(0,0,0)
        Canvas.ZIndex = 110
        Canvas.ScrollBarThickness = 0
        Canvas.ScrollBarImageColor3 = Color3.new(0,0,0)
        Canvas.Visible = false
        CanvasLayout.Name = "CanvasLayout"
        CanvasLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        CanvasLayout.SortOrder = Enum.SortOrder.LayoutOrder
        CanvasLayout.Padding = UDim.new(0,7)
        CanvasPad.Name = "CanvasPad"
        CanvasPad.PaddingTop = UDim.new(0,1)

        
        
        tabOffset = tabOffset + .07

        function tab:Activate()
            if not tab.Active then
                if gui.CurrentTab ~= nil then
                    gui.CurrentTab:Deactivate()
                end
                Tab.TextColor3 = Color3.fromRGB(255,255,255)
                Library:tween(SelectedTab, {Position = Tab.Position + UDim2.new(0.0389,0,0,0)})
                tab.Active = true
                Canvas.Visible = true
                gui.CurrentTab = tab
            end
        end

        function tab:Deactivate()
            if tab.Active then
                tab.Active = false
                Canvas.Visible = false
                --TextBox.Text = ""
            end
        end

        Tab.MouseButton1Down:Connect(function()
            tab:Activate()
        end)

        if gui.CurrentTab == nil then
            tab:Activate()  
        end

        function tab:NewToggle(options)
            
            local toggle = {
                Active = false
            }
            
            local Toggle = Instance.new('Frame', options.Parent or Canvas)
            local ToggleStroke = Instance.new('UIStroke', Toggle)
            local ToggleCorner = Instance.new('UICorner', Toggle)
            local ToggleTitle = Instance.new('TextButton', Toggle)
            local togglegradient1 = Instance.new('UIGradient', ToggleStroke)
            local ToggleBack = Instance.new('Frame', Toggle)
            local ToggleBackCorner = Instance.new('UICorner', ToggleBack)
            local Circle = Instance.new('Frame', ToggleBack)
            local CircleCorner = Instance.new('UICorner', Circle)
            
            Toggle.Name = "Toggle"
            Toggle.Position = UDim2.new(0.3031,0,0.5718,0)
            Toggle.Size = UDim2.new(0,475,0,33)
            Toggle.BackgroundColor3 = Color3.new(0.1529,0.1529,0.1529)
            Toggle.BorderSizePixel = 0
            Toggle.BorderColor3 = Color3.new(0,0,0)
            Toggle.ZIndex = 115
            ToggleStroke.Color = Color3.new(0.251,0.251,0.251)
            ToggleCorner.CornerRadius = UDim.new(0,6)
            ToggleTitle.Name = "ComponentTitle"
            ToggleTitle.Position = UDim2.new(0.0232,0,0,0)
            ToggleTitle.Size = UDim2.new(0,463,0,33)
            ToggleTitle.BackgroundColor3 = Color3.new(1,1,1)
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.BorderColor3 = Color3.new(0,0,0)
            ToggleTitle.Text = options.Name
            ToggleTitle.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.TextSize = 14
            ToggleTitle.AutoButtonColor = false
            ToggleTitle.ZIndex = 130
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleBack.Name = "ToggleBack"
            ToggleBack.Position = UDim2.new(0.8926,0,0.1818,0)
            ToggleBack.Size = UDim2.new(0,44,0,21)
            ToggleBack.BackgroundColor3 = Color3.new(0.102,0.102,0.102)
            ToggleBack.BorderSizePixel = 0
            ToggleBack.BorderColor3 = Color3.new(0,0,0)
            ToggleBack.ZIndex = 117
            ToggleBackCorner.CornerRadius = UDim.new(0,100)
            Circle.Name = "Circle"
            Circle.Position = UDim2.new(0.104,0,0.123,0)
            Circle.Size = UDim2.new(0,15,0,15)
            Circle.BackgroundColor3 = Color3.new(0.5765,0.5765,0.5765)
            Circle.BorderSizePixel = 0
            Circle.BorderColor3 = Color3.new(0,0,0)
            Circle.ZIndex = 117
            CircleCorner.CornerRadius = UDim.new(0,100)
            
            togglegradient1.Name = "SelectedGradient"
            togglegradient1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.9607843160629272, 0.4117647111415863, 0.9764705896377563)),ColorSequenceKeypoint.new(1,Color3.new(0.5254902243614197, 0.43529412150382996, 1))})
            togglegradient1.Rotation = 180
            
            toggle.State = options.default

            options.callback(toggle.State)

            if toggle.State then
                Library:tween(ToggleBack, {BackgroundColor3 = Color3.new(0.415686, 0.443137, 0.854902)})
                Library:tween(Circle, {Position = UDim2.new(0.595,0,0.123,0)})
                Library:tween(Circle, {BackgroundColor3 = Color3.new(1, 1, 1)})
                Library:tween(ToggleTitle, {TextColor3 = Color3.new(1, 1, 1)})
                togglegradient1.Enabled = true
                ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
            else
                Library:tween(ToggleBack, {BackgroundColor3 = Color3.new(0.102,0.102,0.102)})
                Library:tween(Circle, {Position = UDim2.new(0.104,0,0.123,0)})
                Library:tween(Circle, {BackgroundColor3 = Color3.new(0.5765,0.5765,0.5765)})
                Library:tween(ToggleTitle, {TextColor3 = Color3.new(0.5765,0.5765,0.5765)})
                togglegradient1.Enabled = false
                ToggleStroke.Color = Color3.new(0.251,0.251,0.251)
            end

            function toggle:Toggle(boolean)
                if boolean == nil then
                    toggle.State = not toggle.State
                else
                    toggle.State = boolean
                end

                if toggle.State then
                    Library:tween(ToggleBack, {BackgroundColor3 = Color3.new(0.415686, 0.443137, 0.854902)})
                    Library:tween(Circle, {Position = UDim2.new(0.595,0,0.123,0)})
                    Library:tween(Circle, {BackgroundColor3 = Color3.new(1, 1, 1)})
                    Library:tween(ToggleTitle, {TextColor3 = Color3.new(1, 1, 1)})
                    togglegradient1.Enabled = true
                    ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
                else
                    Library:tween(ToggleBack, {BackgroundColor3 = Color3.new(0.102,0.102,0.102)})
                    Library:tween(Circle, {Position = UDim2.new(0.104,0,0.123,0)})
                    Library:tween(Circle, {BackgroundColor3 = Color3.new(0.5765,0.5765,0.5765)})
                    togglegradient1.Enabled = false
                    ToggleStroke.Color = Color3.new(0.251,0.251,0.251)
                    Library:tween(ToggleTitle, {TextColor3 = Color3.new(0.5765,0.5765,0.5765)})
                end

                options.callback(toggle.State)
            end

            ToggleTitle.MouseButton1Down:Connect(function()
                toggle:Toggle()
            end)
        end
        
        function tab:NewSlider(options)
            
            local slider = {
                connections = {}
            }
            

            local Slider = Instance.new('ImageButton', options.Parent or Canvas)
            local SliderStroke = Instance.new('UIStroke', Slider)
            local SliderCorner = Instance.new('UICorner', Slider)
            local SliderTitle = Instance.new('TextLabel', Slider)
            local SliderAmt = Instance.new('TextBox', Slider)
            local SliderBack = Instance.new('Frame', Slider)
            local SliderBackCorner = Instance.new('UICorner', SliderBack)
            local SliderMain = Instance.new('Frame', SliderBack)
            local SliderMainCorner = Instance.new('UICorner', SliderMain)
            local SliderMainGradient = Instance.new('UIGradient', SliderMain)
            
            Slider.Name = "Slider"
            Slider.Position = UDim2.new(0.3031,0,0.5718,0)
            Slider.Size = UDim2.new(0,475,0,46)
            Slider.BackgroundColor3 = Color3.new(0.1529,0.1529,0.1529)
            Slider.BorderSizePixel = 0
            Slider.BorderColor3 = Color3.new(0,0,0)
            Slider.ZIndex = 115
            Slider.AutoButtonColor = false
            SliderStroke.Color = Color3.new(0.251,0.251,0.251)
            SliderCorner.CornerRadius = UDim.new(0,6)
            SliderTitle.Name = "ComponentTitle"
            SliderTitle.Position = UDim2.new(0.0232,0,0,0)
            SliderTitle.Size = UDim2.new(0,345,0,32)
            SliderTitle.BackgroundColor3 = Color3.new(1,1,1)
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.BorderSizePixel = 0
            SliderTitle.BorderColor3 = Color3.new(0,0,0)
            SliderTitle.Text = options.Name
            SliderTitle.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.TextSize = 14
            SliderTitle.ZIndex = 116
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderAmt.Name = "SliderAmt"
            SliderAmt.Position = UDim2.new(0.8932,0,0,0)
            SliderAmt.Size = UDim2.new(0,44,0,32)
            SliderAmt.BackgroundColor3 = Color3.new(1,1,1)
            SliderAmt.BackgroundTransparency = 1
            SliderAmt.BorderSizePixel = 0
            SliderAmt.BorderColor3 = Color3.new(0,0,0)
            SliderAmt.Text = tostring(options.default) or "0"
            SliderAmt.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
            SliderAmt.Font = Enum.Font.Gotham
            SliderAmt.TextSize = 14
            SliderAmt.ZIndex = 116
            SliderAmt.TextXAlignment = Enum.TextXAlignment.Right
            SliderBack.Name = "SliderBack"
            SliderBack.Position = UDim2.new(0.0238,0,0.6957,0)
            SliderBack.Size = UDim2.new(0,457,0,4)
            SliderBack.BackgroundColor3 = Color3.new(0.102,0.102,0.102)
            SliderBack.BorderSizePixel = 0
            SliderBack.BorderColor3 = Color3.new(0,0,0)
            SliderBack.ZIndex = 130
            SliderMain.Name = "SliderMain"
            SliderMain.Position = UDim2.new(-0.0006,0,0,0)
            SliderMain.Size = UDim2.new(0,120,0,4)
            SliderMain.BackgroundColor3 = Color3.new(0.5843,0.5843,0.5843)
            SliderMain.BorderSizePixel = 0
            SliderMain.BorderColor3 = Color3.new(0,0,0)
            SliderMain.ZIndex = 131
            SliderMainGradient.Name = "SliderMainGradient"
            SliderMainGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.9607843160629272, 0.4117647111415863, 0.9764705896377563)    ),ColorSequenceKeypoint.new(1,Color3.new(0.5254902243614197, 0.43529412150382996, 1))})
            

            function slider:SetValue(v)
                if v == nil then
                    local percentage = math.clamp((mouse.X - SliderBack.AbsolutePosition.X) / (SliderBack.AbsoluteSize.X), 0, 1)
                    local value = ((options.max - options.min) * percentage) + options.min
                    if value % 1 == 0 then
                        SliderAmt.Text = string.format("%.0f", value)
                    else
                        SliderAmt.Text = string.format("%.1f", value)
                    end
                    --Library:tween(SliderMain, {Size = UDim2.fromScale(percentage, 1)})
                    SliderMain.Size = UDim2.fromScale(percentage, 1)
                else
                    if v % 1 == 0 then
                        SliderAmt.Text = string.format("%.0f", v)
                    else
                        SliderAmt.Text = tostring(v)
                    end
                    --SliderMain.Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
                    Library:tween(SliderMain, {Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)})
                end
                options.callback(slider:GetValue())
            end

            function slider:GetValue()
                return tonumber(SliderAmt.Text)
            end

            slider:SetValue(options.default)

            SliderAmt.FocusLost:Connect(function()
                local toNum
                pcall(function()
                    toNum = tonumber(SliderAmt.Text)
                end)
                if toNum then
                    toNum = math.clamp(toNum, options.min, options.max)
                    slider:SetValue(toNum)
                else
                    SliderAmt.Text = "no :<"
                end
            end)

            local Connection;
            table.insert(slider.connections, UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    pcall(function()
                        Connection:Disconnect();
                        Connection = nil;
                        SliderTitle.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
                        SliderAmt.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
                        SliderMain.BackgroundColor3 = Color3.new(0.5843,0.5843,0.5843)
                    end)
                end
            end))

            table.insert(slider.connections, Slider.MouseButton1Down:Connect(function()
                if(Connection) then
                    Connection:Disconnect();
                end;

                Connection = RS.Heartbeat:Connect(function()
                    --options.callback()
                    --if slider.Hover then
                    SliderMain.BackgroundColor3 = Color3.new(1, 1, 1)
                    SliderAmt.TextColor3 = Color3.new(1, 1, 1)
                    SliderTitle.TextColor3 = Color3.new(1, 1, 1)
                    slider:SetValue()
                    slider.val = slider:GetValue()
                    --end
                end)
            end))

            return slider
        end
        
        function tab:NewDropdown(options)
            local dropdown = {}
            

            local Dropdown = Instance.new('Frame', options.Parent or Canvas)
            local DropdownStroke = Instance.new('UIStroke', Dropdown)
            local DropdownCorner = Instance.new('UICorner', Dropdown)
            local DropDownTitle = Instance.new('TextButton', Dropdown)
            local SelectedOption = Instance.new('Frame', Dropdown)
            local SelectedCorner = Instance.new('UICorner', SelectedOption)
            local TextLabel = Instance.new('TextLabel', SelectedOption)
            local UIPadding = Instance.new('UIPadding', SelectedOption)
            local OptionsHolder = Instance.new('Frame', options.Parent or Canvas)
            local OptionLayout = Instance.new('UIListLayout', OptionsHolder)
            local OptionPad = Instance.new('UIPadding', OptionsHolder)
            
            --Properties

            Dropdown.Name = "Dropdown"
            Dropdown.Position = UDim2.new(0.3031,0,0.5718,0)
            Dropdown.Size = UDim2.new(0,475,0,33)
            Dropdown.BackgroundColor3 = Color3.new(0.1529,0.1529,0.1529)
            Dropdown.BorderSizePixel = 0
            Dropdown.BorderColor3 = Color3.new(0,0,0)
            Dropdown.ZIndex = 115
            DropdownStroke.Color = Color3.new(0.251,0.251,0.251)
            DropdownCorner.CornerRadius = UDim.new(0,6)
            DropDownTitle.Name = "ComponentTitle"
            DropDownTitle.Position = UDim2.new(0.0232,0,0,0)
            DropDownTitle.Size = UDim2.new(0,463,0,33)
            DropDownTitle.BackgroundColor3 = Color3.new(1,1,1)
            DropDownTitle.BackgroundTransparency = 1
            DropDownTitle.BorderSizePixel = 0
            DropDownTitle.BorderColor3 = Color3.new(0,0,0)
            DropDownTitle.Text = options.Name
            DropDownTitle.AutoButtonColor = false
            DropDownTitle.TextColor3 = Color3.new(0.5765,0.5765,0.5765)
            DropDownTitle.Font = Enum.Font.Gotham
            DropDownTitle.TextSize = 14
            DropDownTitle.ZIndex = 130
            DropDownTitle.TextXAlignment = Enum.TextXAlignment.Left
            SelectedOption.Name = "SelectedOption"
            SelectedOption.Position = UDim2.new(0.9853,0,0.1818,0)
            SelectedOption.Size = UDim2.new(0,44,0,21)
            SelectedOption.BackgroundColor3 = Color3.new(0.102,0.102,0.102)
            SelectedOption.BorderSizePixel = 0
            SelectedOption.BorderColor3 = Color3.new(0,0,0)
            SelectedOption.AnchorPoint = Vector2.new(1,0)
            SelectedOption.AutomaticSize = Enum.AutomaticSize.X
            SelectedOption.ZIndex = 117
            SelectedCorner.CornerRadius = UDim.new(0,6)
            TextLabel.Size = UDim2.new(0,44,0,21)
            TextLabel.BackgroundColor3 = Color3.new(1,1,1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.BorderColor3 = Color3.new(0,0,0)
            TextLabel.Text = options.default
            TextLabel.TextColor3 = Color3.new(0.7569,0.7569,0.7569)
            TextLabel.Font = Enum.Font.Gotham
            TextLabel.TextSize = 12
            TextLabel.AutomaticSize = Enum.AutomaticSize.X
            TextLabel.ZIndex = 120
            UIPadding.PaddingLeft = UDim.new(0,10)
            UIPadding.PaddingRight = UDim.new(0,10)
            OptionsHolder.Name = "OptionsHolder"
            OptionsHolder.Size = UDim2.new(0,475,0,0)
            OptionsHolder.BackgroundColor3 = Color3.new(1,1,1)
            OptionsHolder.BackgroundTransparency = 1
            OptionsHolder.ClipsDescendants = true
            OptionsHolder.BorderSizePixel = 0
            OptionsHolder.BorderColor3 = Color3.new(0,0,0)
            OptionsHolder.Visible = false
            OptionsHolder.ZIndex = 120
            OptionLayout.Name = "OptionLayout"
            OptionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            OptionLayout.Padding = UDim.new(0,5)
            OptionPad.Name = "OptionPad"
            OptionPad.PaddingTop = UDim.new(0,1)
            
            options.callback(options.default)
            
            local spacing = UDim2.new(0,0,0,0)
            
            for i, v in pairs(options.options) do
                
                spacing = spacing + UDim2.new(0,0,0,31)
                
                local Option = Instance.new('Frame', OptionsHolder)
                local OptionCorner = Instance.new('UICorner', Option)
                local OptionStroke = Instance.new('UIStroke', Option)
                local OptionTitle = Instance.new('TextButton', Option)
                local TitleGradient = Instance.new('UIGradient', OptionTitle)

                Option.Name = "Option"
local function CreateColorPicker(parent, defaultColor, callback)
    local colorPicker = CreateInstance("Frame", {
        Name = "ColorPicker",
        Size = UDim2.new(0, 200, 0, 150),
        BackgroundColor3 = COLORS.Secondary,
        Parent = parent
    })
    
    CreateCorner(colorPicker, CORNERS.Medium)
    CreateStroke(colorPicker, COLORS.Border, 1)
    
    local colorWheel = CreateInstance("ImageButton", {
        Name = "ColorWheel",
        Size = UDim2.new(0, 150, 0, 150),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Parent = colorPicker
    })
    
    local brightnessSlider = CreateInstance("Frame", {
        Name = "BrightnessSlider",
        Size = UDim2.new(0, 20, 0, 150),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = colorPicker
    })
    
    CreateCorner(brightnessSlider, CORNERS.Small)
    
    local brightnessGradient = CreateGradient(brightnessSlider, {
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
    }, 90)
    
    local brightnessHandle = CreateInstance("Frame", {
        Name = "BrightnessHandle",
        Size = UDim2.new(1, 0, 0, 4),
        BackgroundColor3 = COLORS.Text,
        Parent = brightnessSlider
    })
    
    CreateCorner(brightnessHandle, CORNERS.Small)
    
    local selectedColor = CreateInstance("Frame", {
        Name = "SelectedColor",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 1, -40),
        BackgroundColor3 = defaultColor or Color3.new(1, 1, 1),
        Parent = colorPicker
    })
    
    CreateCorner(selectedColor, CORNERS.Small)
    CreateStroke(selectedColor, COLORS.Border, 1)
    
    -- Color picker logic here
    -- (Implementation details for color selection)
    
    return colorPicker
end

-- Window Creation
function Library:CreateWindow(options)
    local window = {}
    
    local screenGui = CreateInstance("ScreenGui", {
        Name = "LibraryUI",
        Parent = game:GetService("CoreGui")
    })
    
    local mainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = COLORS.Background,
        Parent = screenGui
    })
    
    CreateCorner(mainFrame, CORNERS.Large)
    CreateStroke(mainFrame, COLORS.Border, 1)
    
    local titleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = COLORS.Secondary,
        Parent = mainFrame
    })
    
    CreateCorner(titleBar, UDim.new(0, 8))
    
    local title = CreateInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = options.Title or "Library",
        TextColor3 = COLORS.Text,
        Font = FONTS.Bold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    
    local tabContainer = CreateInstance("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 150, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = COLORS.Secondary,
        Parent = mainFrame
    })
    
    local contentContainer = CreateInstance("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -150, 1, -40),
        Position = UDim2.new(0, 150, 0, 40),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })
    
    -- Window dragging
    local function updateDrag(input)
        local delta = input.Position - dragStart
        Tween(mainFrame, {
            Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
        }, 0.1)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Tab creation
    function window:NewTab(options)
        local tab = {}
        local tabButton = CreateInstance("TextButton", {
            Name = "TabButton",
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = COLORS.Secondary,
            Text = options.Name or "Tab",
            TextColor3 = COLORS.TextSecondary,
            Font = FONTS.Medium,
            TextSize = 14,
            Parent = tabContainer
        })
        
        local tabContent = CreateInstance("ScrollingFrame", {
            Name = "TabContent",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            Parent = contentContainer
        })
        
        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 5),
            Parent = tabContent
        })
        
        tabContent.Visible = false
        
        -- Section creation
        function tab:NewSection(options)
            local section = {}
            local sectionFrame = CreateInstance("Frame", {
                Name = "Section",
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundColor3 = COLORS.Secondary,
                Parent = tabContent
            })
            
            CreateCorner(sectionFrame, CORNERS.Medium)
            CreateStroke(sectionFrame, COLORS.Border, 1)
            
            local sectionTitle = CreateInstance("TextLabel", {
                Name = "SectionTitle",
                Size = UDim2.new(1, -20, 0, 30),
                Position = UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 1,
                Text = options.Name or "Section",
                TextColor3 = COLORS.Text,
                Font = FONTS.Medium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = sectionFrame
            })
            
            local contentLayout = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
                Parent = sectionFrame
            })
            
            -- Toggle creation
            function section:NewToggle(options)
                local toggle = {}
                local toggleFrame = CreateInstance("Frame", {
                    Name = "Toggle",
                    Size = UDim2.new(1, -20, 0, 30),
                    BackgroundColor3 = COLORS.Background,
                    Parent = sectionFrame
                })
                
                CreateCorner(toggleFrame, CORNERS.Small)
                
                local toggleButton = CreateInstance("TextButton", {
                    Name = "ToggleButton",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Toggle",
                    TextColor3 = COLORS.TextSecondary,
                    Font = FONTS.Regular,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = toggleFrame
                })
                
                local toggleIndicator = CreateInstance("Frame", {
                    Name = "ToggleIndicator",
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -25, 0.5, -10),
                    BackgroundColor3 = COLORS.Secondary,
                    Parent = toggleFrame
                })
                
                CreateCorner(toggleIndicator, UDim.new(0, 10))
                
                local state = options.default or false
                
                function toggle:SetState(newState)
                    state = newState
                    Tween(toggleIndicator, {
                        BackgroundColor3 = state and COLORS.Accent or COLORS.Secondary
                    })
                    if options.callback then
                        options.callback(state)
                    end
                end
                
                toggleButton.MouseButton1Click:Connect(function()
                    toggle:SetState(not state)
                end)
                
                toggle:SetState(state)
                return toggle
            end
            
            -- Slider creation
            function section:NewSlider(options)
                local slider = {}
                local sliderFrame = CreateInstance("Frame", {
                    Name = "Slider",
                    Size = UDim2.new(1, -20, 0, 40),
                    BackgroundColor3 = COLORS.Background,
                    Parent = sectionFrame
                })
                
                CreateCorner(sliderFrame, CORNERS.Small)
                
                local sliderTitle = CreateInstance("TextLabel", {
                    Name = "SliderTitle",
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 5),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Slider",
                    TextColor3 = COLORS.TextSecondary,
                    Font = FONTS.Regular,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = sliderFrame
                })
                
                local sliderBar = CreateInstance("Frame", {
                    Name = "SliderBar",
                    Size = UDim2.new(1, -20, 0, 4),
                    Position = UDim2.new(0, 10, 1, -10),
                    BackgroundColor3 = COLORS.Secondary,
                    Parent = sliderFrame
                })
                
                CreateCorner(sliderBar, UDim.new(0, 2))
                
                local sliderFill = CreateInstance("Frame", {
                    Name = "SliderFill",
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = COLORS.Accent,
                    Parent = sliderBar
                })
                
                CreateCorner(sliderFill, UDim.new(0, 2))
                
                local sliderHandle = CreateInstance("Frame", {
                    Name = "SliderHandle",
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(0, 0, 0.5, -6),
                    BackgroundColor3 = COLORS.Text,
                    Parent = sliderBar
                })
                
                CreateCorner(sliderHandle, UDim.new(0, 6))
                
                local value = options.default or options.min or 0
                
                function slider:SetValue(newValue)
                    value = math.clamp(newValue, options.min or 0, options.max or 100)
                    local percentage = (value - (options.min or 0)) / ((options.max or 100) - (options.min or 0))
                    Tween(sliderFill, {
                        Size = UDim2.new(percentage, 0, 1, 0)
                    })
                    Tween(sliderHandle, {
                        Position = UDim2.new(percentage, -6, 0.5, -6)
                    })
                    if options.callback then
                        options.callback(value)
                    end
                end
                
                sliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local percentage = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                        local newValue = (options.min or 0) + percentage * ((options.max or 100) - (options.min or 0))
                        slider:SetValue(newValue)
                    end
                end)
                
                slider:SetValue(value)
                return slider
            end
            
            -- Button creation
            function section:NewButton(options)
                local buttonFrame = CreateInstance("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, -20, 0, 30),
                    BackgroundColor3 = COLORS.Background,
                    Text = options.Name or "Button",
                    TextColor3 = COLORS.TextSecondary,
                    Font = FONTS.Regular,
                    TextSize = 14,
                    Parent = sectionFrame
                })
                
                CreateCorner(buttonFrame, CORNERS.Small)
                
                buttonFrame.MouseButton1Click:Connect(function()
                    if options.callback then
                        options.callback()
                    end
                end)
            end
            
            -- Dropdown creation
            function section:NewDropdown(options)
                local dropdown = {}
                local dropdownFrame = CreateInstance("Frame", {
                    Name = "Dropdown",
                    Size = UDim2.new(1, -20, 0, 30),
                    BackgroundColor3 = COLORS.Background,
                    Parent = sectionFrame
                })
                
                CreateCorner(dropdownFrame, CORNERS.Small)
                
                local dropdownButton = CreateInstance("TextButton", {
                    Name = "DropdownButton",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Dropdown",
                    TextColor3 = COLORS.TextSecondary,
                    Font = FONTS.Regular,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = dropdownFrame
                })
                
                local dropdownList = CreateInstance("Frame", {
                    Name = "DropdownList",
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 1, 5),
                    BackgroundColor3 = COLORS.Secondary,
                    Parent = dropdownFrame,
                    Visible = false
                })
                
                CreateCorner(dropdownList, CORNERS.Small)
                
                local listLayout = CreateInstance("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = dropdownList
                })
                
                local selectedOption = options.default
                
                function dropdown:SetOption(option)
                    selectedOption = option
                    dropdownButton.Text = option
                    if options.callback then
                        options.callback(option)
                    end
                end
                
                for _, option in ipairs(options.options) do
                    local optionButton = CreateInstance("TextButton", {
                        Name = "Option",
                        Size = UDim2.new(1, 0, 0, 30),
                        BackgroundColor3 = COLORS.Background,
                        Text = option,
                        TextColor3 = COLORS.TextSecondary,
                        Font = FONTS.Regular,
                        TextSize = 14,
                        Parent = dropdownList
                    })
                    
                    optionButton.MouseButton1Click:Connect(function()
                        dropdown:SetOption(option)
                        dropdownList.Visible = false
                    end)
                end
                
                dropdownButton.MouseButton1Click:Connect(function()
                    dropdownList.Visible = not dropdownList.Visible
                    if dropdownList.Visible then
                        Tween(dropdownList, {
                            Size = UDim2.new(1, 0, 0, #options.options * 30)
                        })
                    else
                        Tween(dropdownList, {
                            Size = UDim2.new(1, 0, 0, 0)
                        })
                    end
                end)
                
                dropdown:SetOption(selectedOption)
                return dropdown
            end
            
            -- Color Picker creation
            function section:NewColorPicker(options)
                local colorPicker = CreateColorPicker(sectionFrame, options.default, options.callback)
                return colorPicker
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return Library

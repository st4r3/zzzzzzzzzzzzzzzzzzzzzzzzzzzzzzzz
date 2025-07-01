--[[
    Futuristic UI Library for Roblox
    Features:
    - Glassmorphism (frosted glass panels)
    - Neon/glow accent colors
    - Rounded corners, drop shadows
    - Smooth animations and hover effects
    - Modern fonts and sizing
    - Enhanced visual feedback
    - Dark color palette with neon accents
]]

local library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Variables
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Utility Functions
function library:create(Object, Properties, Parent)
    local Obj = Instance.new(Object)
    for i, v in pairs(Properties) do
        Obj[i] = v
    end
    if Parent then
        Obj.Parent = Parent
    end
    return Obj
end

function library:tween(...)
    TweenService:Create(...):Play()
end

function library:getTextSize(...)
    return TextService:GetTextSize(...)
end

-- Signal System
library.Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()

-- Draggable Function
function library:setDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Main Library Function
function library.new(title, configLocation)
    local menu = {}
    menu.values = {}
    menu.onLoadConfig = library.Signal.new("onLoadConfig")
    menu.onSaveConfig = library.Signal.new("onSaveConfig")

    -- Create config folder
    if not isfolder(configLocation) then
        makefolder(configLocation)
    end

    -- Utility Functions
    function menu:copy(original)
        local copy = {}
        for k, v in pairs(original) do
            if type(v) == "table" then
                v = menu:copy(v)
            end
            copy[k] = v
        end
        return copy
    end

    function menu:saveConfig(configName)
        local valuesCopy = menu:copy(menu.values)
        
        -- Convert Color3 objects to serializable format
        for _, tab in next, valuesCopy do
            for _, section in next, tab do
                for _, sector in next, section do
                    for _, element in next, sector do
                        if element.Color then
                            element.Color = {R = element.Color.R, G = element.Color.G, B = element.Color.B}
                        end
                    end
                end
            end
        end

        writefile(configLocation .. configName .. ".json", HttpService:JSONEncode(valuesCopy))
        menu.onSaveConfig:Fire(configName)
    end

    function menu:loadConfig(configName)
        local success, newValues = pcall(function()
            return HttpService:JSONDecode(readfile(configLocation .. configName .. ".json"))
        end)
        
        if success then
            -- Convert back to Color3 objects
            for _, tab in next, newValues do
                for _, section in next, tab do
                    for _, sector in next, section do
                        for _, element in next, sector do
                            if element.Color then
                                element.Color = Color3.new(element.Color.R, element.Color.G, element.Color.B)
                            end
                            pcall(function()
                                menu.values[_][_][_][_] = element
                            end)
                        end
                    end
                end
            end
            menu.onLoadConfig:Fire(configName)
        end
    end

    -- Create Main GUI
    menu.open = true
    local screenGui = library:create("ScreenGui", {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Name = "FuturisticUILibrary",
        IgnoreGuiInset = true,
    })

    -- Protect GUI if using Synapse
    if syn then
        syn.protect_gui(screenGui)
    end

    -- Custom Cursor (neon effect)
    local cursor = library:create("ImageLabel", {
        Name = "Cursor",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 24, 0, 24),
        Image = "rbxassetid://7205257578",
        ZIndex = 9999,
        ImageColor3 = Color3.fromRGB(0, 255, 255),
        ImageTransparency = 0.1,
    }, screenGui)

    RunService.RenderStepped:Connect(function()
        cursor.Position = UDim2.new(0, mouse.X, 0, mouse.Y + 36)
    end)

    screenGui.Parent = CoreGui

    -- Menu Functions
    function menu:isOpen()
        return menu.open
    end

    function menu:setOpen(state)
        screenGui.Enabled = state
        menu.open = state
    end

    -- Toggle Menu with Insert Key
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            menu:setOpen(not menu:isOpen())
        end
    end)

    -- Main Container (glassmorphism)
    local mainContainer = library:create("ImageButton", {
        Name = "MainContainer",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(15, 20, 30),
        BorderColor3 = Color3.fromRGB(0, 255, 255),
        BorderSizePixel = 2,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 820, 0, 620),
        Image = "rbxassetid://7300333488",
        ImageTransparency = 0.7,
        AutoButtonColor = false,
        Modal = true,
        ClipsDescendants = true,
    }, screenGui)
    mainContainer.BackgroundTransparency = 0.2
    mainContainer.ImageColor3 = Color3.fromRGB(0, 255, 255)
    mainContainer.ImageTransparency = 0.9
    mainContainer.BorderMode = Enum.BorderMode.Outline
    mainContainer.BorderSizePixel = 2
    mainContainer.ZIndex = 2
    -- Drop shadow
    local shadow = library:create("ImageLabel", {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        Size = UDim2.new(1, 40, 1, 40),
        Position = UDim2.new(0, -20, 0, -20),
        ZIndex = 1,
        ImageTransparency = 0.7,
        Parent = mainContainer
    })

    library:setDraggable(mainContainer)

    -- Title Bar (glass, neon border)
    local titleBar = library:create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = Color3.fromRGB(20, 30, 40),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 48),
        ClipsDescendants = true,
    }, mainContainer)
    local titleBarGlow = library:create("Frame", {
        Name = "TitleBarGlow",
        BackgroundColor3 = Color3.fromRGB(0, 255, 255),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 1, -4),
        ZIndex = 3,
    }, titleBar)

    local titleLabel = library:create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 24, 0, 0),
        Size = UDim2.new(1, -48, 1, 0),
        Font = Enum.Font.GothamBlack,
        Text = "[ ",
        TextColor3 = Color3.fromRGB(0, 255, 255),
        TextStrokeTransparency = 0.7,
        TextStrokeColor3 = Color3.fromRGB(0, 255, 255),
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, titleBar)
    titleLabel.Text = "[ " .. title .. " ]"

    -- Close Button (neon, round)
    local closeButton = library:create("TextButton", {
        Name = "CloseButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 255, 255),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -18, 0.5, 0),
        Size = UDim2.new(0, 32, 0, 32),
        Font = Enum.Font.GothamBlack,
        Text = "✕",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 20,
        AutoButtonColor = false,
        ZIndex = 4,
    }, titleBar)
    closeButton.ClipsDescendants = true
    closeButton.TextStrokeTransparency = 0.7
    closeButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
    closeButton.BackgroundTransparency = 0.1
    closeButton.BorderMode = Enum.BorderMode.Outline
    closeButton.BorderSizePixel = 2
    closeButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
    closeButton.MouseEnter:Connect(function()
        library:tween(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        })
    end)
    closeButton.MouseLeave:Connect(function()
        library:tween(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        })
    end)
    closeButton.MouseButton1Click:Connect(function()
        menu:setOpen(false)
    end)

    -- Tab Container (glass, neon border)
    local tabContainer = library:create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = Color3.fromRGB(20, 30, 40),
        BackgroundTransparency = 0.3,
        BorderColor3 = Color3.fromRGB(0, 255, 255),
        BorderSizePixel = 2,
        Position = UDim2.new(0, 0, 0, 48),
        Size = UDim2.new(0, 220, 1, -48),
        ClipsDescendants = true,
    }, mainContainer)

    local tabList = library:create("ScrollingFrame", {
        Name = "TabList",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 1, -20),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255),
    }, tabContainer)

    local tabListLayout = library:create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
    }, tabList)

    -- Content Container (glass)
    local contentContainer = library:create("Frame", {
        Name = "ContentContainer",
        BackgroundColor3 = Color3.fromRGB(25, 35, 50),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 220, 0, 48),
        Size = UDim2.new(1, -220, 1, -48),
        ClipsDescendants = true,
    }, mainContainer)

    -- Tab Management
    local tabs = {}
    local currentTab = nil
    local tabCount = 0

    function menu:newTab(tabName, tabIcon)
        tabCount = tabCount + 1
        local tab = {
            name = tabName,
            id = tabCount,
            elements = {},
            sections = {}
        }
        tabs[tabCount] = tab
        menu.values[tabCount] = {}

        -- Create Tab Button (neon, round, hover glow)
        local tabButton = library:create("TextButton", {
            Name = "Tab_" .. tabCount,
            BackgroundColor3 = Color3.fromRGB(30, 40, 60),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 56),
            Font = Enum.Font.GothamBold,
            Text = tabName,
            TextColor3 = Color3.fromRGB(0, 255, 255),
            TextSize = 18,
            LayoutOrder = tabCount,
            AutoButtonColor = false,
        }, tabList)
        tabButton.ClipsDescendants = true
        tabButton.TextStrokeTransparency = 0.7
        tabButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
        tabButton.BackgroundTransparency = 0.1
        tabButton.BorderMode = Enum.BorderMode.Outline
        tabButton.BorderSizePixel = 2
        tabButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
        tabButton.MouseEnter:Connect(function()
            if currentTab ~= tab then
                library:tween(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                    TextColor3 = Color3.fromRGB(0, 0, 0)
                })
            end
        end)
        tabButton.MouseLeave:Connect(function()
            if currentTab ~= tab then
                library:tween(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                    TextColor3 = Color3.fromRGB(0, 255, 255)
                })
            end
        end)

        -- Tab Icon (if provided)
        if tabIcon then
            local icon = library:create("ImageLabel", {
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0.5, 0),
                Size = UDim2.new(0, 24, 0, 24),
                Image = tabIcon,
                ImageColor3 = Color3.fromRGB(0, 255, 255),
            }, tabButton)
            titleLabel.Position = UDim2.new(0, 48, 0, 0)
            titleLabel.Size = UDim2.new(1, -56, 1, 0)
        end

        -- Tab Content
        local tabContent = library:create("Frame", {
            Name = "Content_" .. tabCount,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
        }, contentContainer)

        local contentScroll = library:create("ScrollingFrame", {
            Name = "Scroll",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 16, 0, 16),
            Size = UDim2.new(1, -32, 1, -32),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255),
        }, tabContent)

        local contentLayout = library:create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 16),
        }, contentScroll)

        tab.content = contentScroll

        -- Tab Button Events
        tabButton.MouseButton1Click:Connect(function()
            if currentTab == tab then return end
            for _, t in pairs(tabs) do
                if t.content then
                    t.content.Parent.Visible = false
                end
            end
            for _, t in pairs(tabs) do
                if t.button then
                    library:tween(t.button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                        TextColor3 = Color3.fromRGB(0, 255, 255)
                    })
                end
            end
            tabContent.Visible = true
            currentTab = tab
            library:tween(tabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                TextColor3 = Color3.fromRGB(0, 0, 0)
            })
        end)

        tab.button = tabButton

        if not currentTab then
            currentTab = tab
            tabContent.Visible = true
            library:tween(tabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                TextColor3 = Color3.fromRGB(0, 0, 0)
            })
        end

        -- Section Management
        function tab:newSection(sectionName)
            local section = {
                name = sectionName,
                elements = {}
            }
            table.insert(tab.sections, section)
            menu.values[tab.id][sectionName] = {}

            -- Section Container (glass, neon border)
            local sectionContainer = library:create("Frame", {
                Name = "Section_" .. sectionName,
                BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                BackgroundTransparency = 0.3,
                BorderColor3 = Color3.fromRGB(0, 255, 255),
                BorderSizePixel = 2,
                Size = UDim2.new(1, 0, 0, 0),
                LayoutOrder = #tab.sections,
                ClipsDescendants = true,
            }, tab.content)

            -- Section Header (neon)
            local sectionHeader = library:create("TextLabel", {
                Name = "Header",
                BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 36),
                Font = Enum.Font.GothamBlack,
                Text = sectionName,
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 16,
            }, sectionContainer)

            -- Section Content
            local sectionContent = library:create("Frame", {
                Name = "Content",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 36),
                Size = UDim2.new(1, 0, 1, -36),
            }, sectionContainer)

            local contentLayout = library:create("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10),
            }, sectionContent)

            local contentPadding = library:create("UIPadding", {
                PaddingLeft = UDim.new(0, 16),
                PaddingRight = UDim.new(0, 16),
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
            }, sectionContent)

            section.container = sectionContent
            section.header = sectionHeader

            -- Element Management
            function section:newElement(elementType, elementName, elementData, callback)
                local element = {
                    type = elementType,
                    name = elementName,
                    data = elementData or {},
                    callback = callback or function() end,
                    value = {}
                }

                local flag = elementName
                menu.values[tab.id][sectionName][flag] = element.value

                local function doCallback()
                    menu.values[tab.id][sectionName][flag] = element.value
                    element.callback(element.value)
                end

                -- Create Element Container (glass, neon border)
                local elementContainer = library:create("Frame", {
                    Name = "Element_" .. elementName,
                    BackgroundColor3 = Color3.fromRGB(40, 60, 80),
                    BackgroundTransparency = 0.2,
                    BorderColor3 = Color3.fromRGB(0, 255, 255),
                    BorderSizePixel = 2,
                    Size = UDim2.new(1, 0, 0, 48),
                    LayoutOrder = #section.elements,
                    ClipsDescendants = true,
                }, section.container)

                -- Element Label (neon)
                local elementLabel = library:create("TextLabel", {
                    Name = "Label",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.5, -15, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = elementName,
                    TextColor3 = Color3.fromRGB(0, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, elementContainer)

                -- Element Value Container
                local valueContainer = library:create("Frame", {
                    Name = "ValueContainer",
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0.5, -10, 1, 0),
                }, elementContainer)

                -- Element Type Handling
                if elementType == "Toggle" then
                    local toggleButton = library:create("TextButton", {
                        Name = "Toggle",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                        BorderColor3 = Color3.fromRGB(0, 255, 255),
                        BorderSizePixel = 2,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 64, 0, 28),
                        Font = Enum.Font.GothamBlack,
                        Text = "OFF",
                        TextColor3 = Color3.fromRGB(0, 255, 255),
                        TextSize = 13,
                        AutoButtonColor = false,
                    }, valueContainer)
                    toggleButton.BackgroundTransparency = 0.1
                    toggleButton.TextStrokeTransparency = 0.7
                    toggleButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
                    element.value.Toggle = elementData and elementData.default or false
                    local function updateToggle()
                        if element.value.Toggle then
                            library:tween(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                                TextColor3 = Color3.fromRGB(0, 0, 0)
                            })
                            toggleButton.Text = "ON"
                        else
                            library:tween(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                                TextColor3 = Color3.fromRGB(0, 255, 255)
                            })
                            toggleButton.Text = "OFF"
                        end
                    end
                    toggleButton.MouseButton1Click:Connect(function()
                        element.value.Toggle = not element.value.Toggle
                        updateToggle()
                        doCallback()
                    end)
                    updateToggle()
                    element.toggle = toggleButton
                elseif elementType == "Slider" then
                    local sliderContainer = library:create("Frame", {
                        Name = "SliderContainer",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                        BorderColor3 = Color3.fromRGB(0, 255, 255),
                        BorderSizePixel = 2,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 0, 0, 20),
                        ClipsDescendants = true,
                    }, valueContainer)
                    local sliderFill = library:create("Frame", {
                        Name = "Fill",
                        BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                        BorderSizePixel = 0,
                        Size = UDim2.new(0.5, 0, 1, 0),
                    }, sliderContainer)
                    local sliderValue = library:create("TextLabel", {
                        Name = "Value",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = "50",
                        TextColor3 = Color3.fromRGB(0, 255, 255),
                        TextSize = 12,
                    }, sliderContainer)
                    local min = elementData and elementData.min or 0
                    local max = elementData and elementData.max or 100
                    element.value.Slider = elementData and elementData.default or 50
                    local function updateSlider()
                        local percentage = (element.value.Slider - min) / (max - min)
                        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                        sliderValue.Text = tostring(element.value.Slider)
                    end
                    local isDragging = false
                    sliderContainer.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            isDragging = true
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            isDragging = false
                        end
                    end)
                    RunService.RenderStepped:Connect(function()
                        if isDragging then
                            local mousePos = UserInputService:GetMouseLocation()
                            local containerPos = sliderContainer.AbsolutePosition
                            local containerSize = sliderContainer.AbsoluteSize
                            local percentage = math.clamp((mousePos.X - containerPos.X) / containerSize.X, 0, 1)
                            element.value.Slider = math.floor(min + (max - min) * percentage)
                            updateSlider()
                            doCallback()
                        end
                    end)
                    updateSlider()
                    element.slider = sliderContainer
                elseif elementType == "Dropdown" then
                    local dropdownButton = library:create("TextButton", {
                        Name = "Dropdown",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                        BorderColor3 = Color3.fromRGB(0, 255, 255),
                        BorderSizePixel = 2,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 0, 0, 28),
                        Font = Enum.Font.Gotham,
                        Text = elementData and elementData.options[1] or "Select...",
                        TextColor3 = Color3.fromRGB(0, 255, 255),
                        TextSize = 13,
                        AutoButtonColor = false,
                    }, valueContainer)
                    dropdownButton.BackgroundTransparency = 0.1
                    dropdownButton.TextStrokeTransparency = 0.7
                    dropdownButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
                    element.value.Dropdown = elementData and elementData.options[1] or ""
                    local dropdownOpen = false
                    local dropdownFrame = nil
                    local function createDropdown()
                        if dropdownFrame then dropdownFrame:Destroy() end
                        dropdownFrame = library:create("Frame", {
                            Name = "DropdownFrame",
                            AnchorPoint = Vector2.new(0, 1),
                            BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                            BackgroundTransparency = 0.1,
                            BorderColor3 = Color3.fromRGB(0, 255, 255),
                            BorderSizePixel = 2,
                            Position = UDim2.new(0, 0, 1, 5),
                            Size = UDim2.new(1, 0, 0, #elementData.options * 28),
                            ZIndex = 10,
                        }, dropdownButton)
                        for i, option in ipairs(elementData.options) do
                            local optionButton = library:create("TextButton", {
                                Name = "Option_" .. i,
                                BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0, 0, 0, (i-1) * 28),
                                Size = UDim2.new(1, 0, 0, 28),
                                Font = Enum.Font.Gotham,
                                Text = option,
                                TextColor3 = Color3.fromRGB(0, 255, 255),
                                TextSize = 13,
                                ZIndex = 11,
                                AutoButtonColor = false,
                            }, dropdownFrame)
                            optionButton.MouseButton1Click:Connect(function()
                                element.value.Dropdown = option
                                dropdownButton.Text = option
                                dropdownOpen = false
                                dropdownFrame:Destroy()
                                dropdownFrame = nil
                                doCallback()
                            end)
                            optionButton.MouseEnter:Connect(function()
                                library:tween(optionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                                    TextColor3 = Color3.fromRGB(0, 0, 0)
                                })
                            end)
                            optionButton.MouseLeave:Connect(function()
                                library:tween(optionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    BackgroundColor3 = Color3.fromRGB(30, 40, 60),
                                    TextColor3 = Color3.fromRGB(0, 255, 255)
                                })
                            end)
                        end
                    end
                    dropdownButton.MouseButton1Click:Connect(function()
                        if dropdownOpen then
                            dropdownOpen = false
                            if dropdownFrame then
                                dropdownFrame:Destroy()
                                dropdownFrame = nil
                            end
                        else
                            dropdownOpen = true
                            createDropdown()
                        end
                    end)
                    element.dropdown = dropdownButton
                elseif elementType == "Button" then
                    local button = library:create("TextButton", {
                        Name = "Button",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(0, 255, 255),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0.8, 0, 0, 28),
                        Font = Enum.Font.GothamBlack,
                        Text = elementName,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 15,
                        AutoButtonColor = false,
                    }, valueContainer)
                    button.BackgroundTransparency = 0.1
                    button.TextStrokeTransparency = 0.7
                    button.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
                    button.MouseButton1Click:Connect(function()
                        doCallback()
                    end)
                    button.MouseEnter:Connect(function()
                        library:tween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                        })
                    end)
                    button.MouseLeave:Connect(function()
                        library:tween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                        })
                    end)
                    element.button = button
                end
                table.insert(section.elements, element)
                return element
            end
            table.insert(tab.sections, section)
            return section
        end
        tabList.CanvasSize = UDim2.new(0, 0, 0, tabCount * 64 + 20)
        return tab
    end
    return menu
end

return library

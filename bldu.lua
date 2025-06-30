-- CSGO Cheat Style UI Library
local default_options = {
	main_color = Color3.fromRGB(41, 74, 122),
	accent_color = Color3.fromRGB(0, 170, 255),
	background_color = Color3.fromRGB(18, 18, 18),
	border_color = Color3.fromRGB(60, 60, 70),
	font = Enum.Font.Code,
	min_size = Vector2.new(600, 400),
}

local function border(obj)
	local ui = Instance.new("UIStroke")
	ui.Color = default_options.border_color
	ui.Thickness = 1
	ui.Parent = obj
	return ui
end

local function makeGroupBox(title)
	local box = Instance.new("Frame")
	box.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	box.Size = UDim2.new(0, 260, 0, 220)
	box.BorderSizePixel = 0
	border(box)
	local lbl = Instance.new("TextLabel")
	lbl.Text = title
	lbl.Font = default_options.font
	lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
	lbl.TextSize = 14
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(1, -8, 0, 20)
	lbl.Position = UDim2.new(0, 8, 0, -10)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = box
	return box
end

local function makeTabButton(text, selected)
	local btn = Instance.new("TextButton")
	btn.BackgroundColor3 = selected and default_options.background_color or Color3.fromRGB(24,24,24)
	btn.TextColor3 = selected and default_options.accent_color or Color3.fromRGB(180,180,180)
	btn.Font = default_options.font
	btn.Text = text
	btn.TextSize = 15
	btn.AutoButtonColor = true
	btn.BorderSizePixel = 0
	btn.Size = UDim2.new(0, 100, 0, 24)
	return btn
end

local function makeCheckbox(text)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 18, 0, 18)
	frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	frame.BorderSizePixel = 0
	border(frame)
	local check = Instance.new("Frame")
	check.Size = UDim2.new(1, -6, 1, -6)
	check.Position = UDim2.new(0, 3, 0, 3)
	check.BackgroundColor3 = default_options.accent_color
	check.Visible = false
	check.BorderSizePixel = 0
	check.Parent = frame
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Font = default_options.font
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.TextSize = 14
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(0, 120, 1, 0)
	lbl.Position = UDim2.new(1, 8, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame
	return frame, check
end

local function makeSlider(text, min, max, value, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -16, 0, 32)
	frame.BackgroundTransparency = 1
	local lbl = Instance.new("TextLabel")
	lbl.Text = text .. ": " .. tostring(value)
	lbl.Font = default_options.font
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.TextSize = 14
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(0.5, 0, 1, 0)
	lbl.Position = UDim2.new(0, 0, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame
	local bar = Instance.new("Frame")
	bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	bar.Size = UDim2.new(0.5, -10, 0, 8)
	bar.Position = UDim2.new(0.5, 10, 0.5, -4)
	bar.BorderSizePixel = 0
	border(bar)
	bar.Parent = frame
	local fill = Instance.new("Frame")
	fill.BackgroundColor3 = default_options.accent_color
	fill.Size = UDim2.new((value-min)/(max-min),0,1,0)
	fill.BorderSizePixel = 0
	fill.Parent = bar
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local con
			con = game:GetService("UserInputService").InputChanged:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseMovement then
					local rel = (inp.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
					rel = math.clamp(rel, 0, 1)
					local v = math.floor(min + (max-min)*rel)
					fill.Size = UDim2.new(rel,0,1,0)
					lbl.Text = text .. ": " .. tostring(v)
					if callback then callback(v) end
				end
			end)
			game:GetService("UserInputService").InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 then
					if con then con:Disconnect() end
				end
			end)
		end
	end)
	return frame
end

local function makeDropdown(text, items, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -16, 0, 32)
	frame.BackgroundTransparency = 1
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Font = default_options.font
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.TextSize = 14
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(0.5, 0, 1, 0)
	lbl.Position = UDim2.new(0, 0, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame
	local dd = Instance.new("TextButton")
	dd.Text = items[1]
	dd.Font = default_options.font
	dd.TextColor3 = Color3.fromRGB(220,220,220)
	dd.TextSize = 14
	dd.BackgroundColor3 = Color3.fromRGB(30,30,30)
	dd.Size = UDim2.new(0.5, -10, 1, -8)
	dd.Position = UDim2.new(0.5, 10, 0, 4)
	dd.BorderSizePixel = 0
	border(dd)
	dd.Parent = frame
	dd.MouseButton1Click:Connect(function()
		local idx = table.find(items, dd.Text) or 1
		idx = idx % #items + 1
		dd.Text = items[idx]
		if callback then callback(items[idx]) end
	end)
	return frame
end

local function makeColorPicker(text, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -16, 0, 32)
	frame.BackgroundTransparency = 1
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Font = default_options.font
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.TextSize = 14
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(0.5, 0, 1, 0)
	lbl.Position = UDim2.new(0, 0, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame
	local box = Instance.new("TextButton")
	box.BackgroundColor3 = Color3.fromRGB(0,170,255)
	box.Size = UDim2.new(0, 28, 0, 20)
	box.Position = UDim2.new(0.5, 10, 0, 6)
	box.BorderSizePixel = 0
	border(box)
	box.Parent = frame
	box.MouseButton1Click:Connect(function()
		local c = box.BackgroundColor3
		if c == Color3.fromRGB(0,170,255) then box.BackgroundColor3 = Color3.fromRGB(0,255,0)
		elseif c == Color3.fromRGB(0,255,0) then box.BackgroundColor3 = Color3.fromRGB(255,0,0)
		else box.BackgroundColor3 = Color3.fromRGB(0,170,255) end
		if callback then callback(box.BackgroundColor3) end
	end)
	return frame
end

local imgui = Instance.new("ScreenGui")
imgui.Name = "imgui"
imgui.Parent = game:GetService("CoreGui")

local Windows = Instance.new("Frame")
Windows.Name = "Windows"
Windows.Parent = imgui
Windows.BackgroundColor3 = default_options.background_color
Windows.Position = UDim2.new(0, 40, 0, 40)
Windows.Size = UDim2.new(0, default_options.min_size.X, 0, default_options.min_size.Y)
Windows.BorderSizePixel = 0
border(Windows)

local TopBar = Instance.new("Frame")
TopBar.Parent = Windows
TopBar.BackgroundColor3 = Color3.fromRGB(24,24,24)
TopBar.Size = UDim2.new(1, 0, 0, 28)
TopBar.BorderSizePixel = 0
border(TopBar)
local Title = Instance.new("TextLabel")
Title.Text = "dawidsense | universal"
Title.Font = default_options.font
Title.TextColor3 = Color3.fromRGB(220,220,220)
Title.TextSize = 15
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -8, 1, 0)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Tabs = {"Aimbot", "Visuals", "UI Settings"}
local SelectedTab = 1
local TabButtons = {}
for i,tab in ipairs(Tabs) do
	local btn = makeTabButton(tab, i==SelectedTab)
	btn.Parent = TopBar
	btn.Position = UDim2.new(0, 140 + (i-1)*110, 0, 2)
	TabButtons[i] = btn
end

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = Windows
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 32)
ContentFrame.Size = UDim2.new(1, 0, 1, -32)

local function clearContent()
	for _,c in ipairs(ContentFrame:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end
end

local function renderAimbot()
	local box = makeGroupBox("Aimbot Settings")
	box.Position = UDim2.new(0, 16, 0, 16)
	box.Parent = ContentFrame
	local y = 28
	local function add(obj)
		obj.Position = UDim2.new(0, 12, 0, y)
		obj.Parent = box
		y = y + obj.Size.Y.Offset + 6
	end
	local cb1, check1 = makeCheckbox("Aimbot Enabled")
	add(cb1)
	local cb2, check2 = makeCheckbox("Visible Check")
	add(cb2)
	local cb3, check3 = makeCheckbox("Teamcheck")
	add(cb3)
	local slider = makeSlider("FOV", 0, 360, 287)
	add(slider)
	local slider2 = makeSlider("Smoothness", 1, 10, 2)
	add(slider2)
	local dd = makeDropdown("Part To Aim", {"Head","Body","Legs"})
	add(dd)
end

local function renderVisuals()
	local box = makeGroupBox("FOV Circle")
	box.Position = UDim2.new(0, 300, 0, 16)
	box.Parent = ContentFrame
	local y = 28
	local function add(obj)
		obj.Position = UDim2.new(0, 12, 0, y)
		obj.Parent = box
		y = y + obj.Size.Y.Offset + 6
	end
	local cb1, check1 = makeCheckbox("Circle Enabled")
	add(cb1)
	local cb2, check2 = makeCheckbox("Circle Filled")
	add(cb2)
	local slider = makeSlider("Circle Shape", 0, 100, 50)
	add(slider)
	local cp = makeColorPicker("Circle Color")
	add(cp)
end

local function renderUISettings()
	-- Add more settings as needed
end

local function renderTab()
	clearContent()
	if SelectedTab == 1 then renderAimbot() end
	if SelectedTab == 2 then renderVisuals() end
	if SelectedTab == 3 then renderUISettings() end
end

for i,btn in ipairs(TabButtons) do
	btn.MouseButton1Click:Connect(function()
		SelectedTab = i
		for j,b in ipairs(TabButtons) do
			b.BackgroundColor3 = j==i and default_options.background_color or Color3.fromRGB(24,24,24)
			b.TextColor3 = j==i and default_options.accent_color or Color3.fromRGB(180,180,180)
		end
		renderTab()
	end)
end

renderTab()

return {}

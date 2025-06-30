-- ImGui Modern UI Library
local ui_options = {
	main_color = Color3.fromRGB(41, 74, 122),
	accent_color = Color3.fromRGB(0, 170, 255),
	background_color = Color3.fromRGB(24, 26, 32),
	border_color = Color3.fromRGB(50, 50, 60),
	font = Enum.Font.Gotham,
	min_size = Vector2.new(400, 300),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
}

local function roundify(obj, radius)
	local uic = Instance.new("UICorner")
	uic.CornerRadius = UDim.new(0, radius)
	uic.Parent = obj
	return uic
end

local function pad(obj, px)
	local ui = Instance.new("UIPadding")
	ui.PaddingTop = UDim.new(0, px)
	ui.PaddingBottom = UDim.new(0, px)
	ui.PaddingLeft = UDim.new(0, px)
	ui.PaddingRight = UDim.new(0, px)
	ui.Parent = obj
	return ui
end

local function makeButton(text, color, font, size)
	local btn = Instance.new("TextButton")
	btn.BackgroundColor3 = color or ui_options.accent_color
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = font or ui_options.font
	btn.Text = text
	btn.TextSize = size or 15
	btn.AutoButtonColor = true
	btn.BorderSizePixel = 0
	roundify(btn, 8)
	pad(btn, 4)
	return btn
end

local function makeLabel(text, color, font, size)
	local lbl = Instance.new("TextLabel")
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = color or Color3.new(1,1,1)
	lbl.Font = font or ui_options.font
	lbl.Text = text
	lbl.TextSize = size or 15
	lbl.BorderSizePixel = 0
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextYAlignment = Enum.TextYAlignment.Center
	pad(lbl, 2)
	return lbl
end

local function makeInput(placeholder, font, size)
	local tb = Instance.new("TextBox")
	tb.BackgroundColor3 = Color3.fromRGB(34,36,42)
	tb.TextColor3 = Color3.new(1,1,1)
	tb.PlaceholderText = placeholder or "Input"
	tb.PlaceholderColor3 = Color3.fromRGB(120,120,120)
	tb.Font = font or ui_options.font
	tb.TextSize = size or 15
	tb.BorderSizePixel = 0
	roundify(tb, 8)
	pad(tb, 4)
	return tb
end

local function makeCheckbox()
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 20, 0, 20)
	frame.BackgroundColor3 = Color3.fromRGB(34,36,42)
	frame.BorderSizePixel = 0
	roundify(frame, 6)
	local check = Instance.new("Frame")
	check.Size = UDim2.new(1, -8, 1, -8)
	check.Position = UDim2.new(0, 4, 0, 4)
	check.BackgroundColor3 = ui_options.accent_color
	check.Visible = false
	check.BorderSizePixel = 0
	roundify(check, 4)
	check.Parent = frame
	return frame, check
end

local function makeRadio()
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 20, 0, 20)
	frame.BackgroundColor3 = Color3.fromRGB(34,36,42)
	frame.BorderSizePixel = 0
	local uic = Instance.new("UICorner")
	uic.CornerRadius = UDim.new(1,0)
	uic.Parent = frame
	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0.5, 0, 0.5, 0)
	dot.Position = UDim2.new(0.25, 0, 0.25, 0)
	dot.BackgroundColor3 = ui_options.accent_color
	dot.Visible = false
	dot.BorderSizePixel = 0
	local uic2 = Instance.new("UICorner")
	uic2.CornerRadius = UDim.new(1,0)
	uic2.Parent = dot
	dot.Parent = frame
	return frame, dot
end

local function makeProgressBar()
	local bar = Instance.new("Frame")
	bar.BackgroundColor3 = Color3.fromRGB(34,36,42)
	bar.Size = UDim2.new(1,0,0,16)
	bar.BorderSizePixel = 0
	roundify(bar, 8)
	local fill = Instance.new("Frame")
	fill.BackgroundColor3 = ui_options.accent_color
	fill.Size = UDim2.new(0,0,1,0)
	fill.BorderSizePixel = 0
	roundify(fill, 8)
	fill.Parent = bar
	return bar, fill
end

local function makeNotification(text)
	local notif = Instance.new("Frame")
	notif.BackgroundColor3 = Color3.fromRGB(34,36,42)
	notif.Size = UDim2.new(0, 300, 0, 60)
	notif.BorderSizePixel = 0
	roundify(notif, 10)
	pad(notif, 8)
	local lbl = makeLabel(text, Color3.new(1,1,1), ui_options.font, 16)
	lbl.Size = UDim2.new(1, -20, 1, -20)
	lbl.Position = UDim2.new(0, 10, 0, 10)
	lbl.Parent = notif
	return notif
end

local function makeTooltip(text)
	local tip = Instance.new("TextLabel")
	tip.BackgroundColor3 = Color3.fromRGB(34,36,42)
	tip.TextColor3 = Color3.new(1,1,1)
	tip.Font = ui_options.font
	tip.Text = text
	tip.TextSize = 13
	tip.BorderSizePixel = 0
	tip.BackgroundTransparency = 0.1
	tip.Size = UDim2.new(0, 180, 0, 28)
	roundify(tip, 6)
	pad(tip, 4)
	tip.Visible = false
	return tip
end

local function makeModal(title, content)
	local modal = Instance.new("Frame")
	modal.BackgroundColor3 = Color3.fromRGB(24,26,32)
	modal.Size = UDim2.new(0, 400, 0, 200)
	modal.BorderSizePixel = 0
	roundify(modal, 12)
	pad(modal, 12)
	local titleLbl = makeLabel(title, ui_options.accent_color, ui_options.font, 18)
	titleLbl.Size = UDim2.new(1, -24, 0, 32)
	titleLbl.Position = UDim2.new(0, 12, 0, 8)
	titleLbl.Parent = modal
	local contentLbl = makeLabel(content, Color3.new(1,1,1), ui_options.font, 15)
	contentLbl.Size = UDim2.new(1, -24, 1, -56)
	contentLbl.Position = UDim2.new(0, 12, 0, 44)
	contentLbl.Parent = modal
	return modal
end

local imgui = Instance.new("ScreenGui")
imgui.Name = "imgui"
imgui.Parent = game:GetService("CoreGui")

local Windows = Instance.new("Frame")
Windows.Name = "Windows"
Windows.Parent = imgui
Windows.BackgroundColor3 = Color3.new(1,1,1)
Windows.BackgroundTransparency = 1
Windows.Position = UDim2.new(0, 20, 0, 20)
Windows.Size = UDim2.new(1, 20, 1, -20)

local library = {}
local windows = 0

function library:AddWindow(title, options)
	windows = windows + 1
	title = tostring(title or "New Window")
	options = (typeof(options) == "table") and options or ui_options
	options.tween_time = 0.1

	local Window = Instance.new("Frame")
	Window.Parent = Windows
	Window.BackgroundColor3 = options.background_color
	Window.Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)
	Window.Position = UDim2.new(0, 40 * windows, 0, 40 * windows)
	Window.BorderSizePixel = 0
	Window.Active = true
	Window.Draggable = true
	Window.ZIndex = 10 + windows
	roundify(Window, 12)
	pad(Window, 8)

	local Bar = Instance.new("Frame")
	Bar.Parent = Window
	Bar.BackgroundColor3 = options.main_color
	Bar.Size = UDim2.new(1, 0, 0, 36)
	Bar.BorderSizePixel = 0
	roundify(Bar, 12)
	Bar.ZIndex = Window.ZIndex + 1
	pad(Bar, 4)

	local Title = makeLabel(title, Color3.new(1,1,1), options.font, 18)
	Title.Parent = Bar
	Title.Size = UDim2.new(1, -20, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.ZIndex = Bar.ZIndex + 1

	local Content = Instance.new("Frame")
	Content.Parent = Window
	Content.BackgroundTransparency = 1
	Content.Size = UDim2.new(1, 0, 1, -36)
	Content.Position = UDim2.new(0, 0, 0, 36)
	Content.ZIndex = Window.ZIndex + 2

	local layout = Instance.new("UIListLayout")
	layout.Parent = Content
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	local tab_data = {}

	function tab_data:AddLabel(text)
		local lbl = makeLabel(text, Color3.new(1,1,1), options.font, 15)
		lbl.Parent = Content
		lbl.Size = UDim2.new(1, -20, 0, 24)
		return lbl
	end

	function tab_data:AddButton(text, callback)
		local btn = makeButton(text, options.accent_color, options.font, 15)
		btn.Parent = Content
		btn.Size = UDim2.new(0, 120, 0, 32)
		btn.MouseButton1Click:Connect(function()
			if callback then callback() end
		end)
		return btn
	end

	function tab_data:AddInput(placeholder, callback)
		local tb = makeInput(placeholder, options.font, 15)
		tb.Parent = Content
		tb.Size = UDim2.new(0, 180, 0, 32)
		tb.FocusLost:Connect(function(enter)
			if enter and callback then callback(tb.Text) end
		end)
		return tb
	end

	function tab_data:AddCheckbox(text, callback)
		local frame, check = makeCheckbox()
		frame.Parent = Content
		local lbl = makeLabel(text, Color3.new(1,1,1), options.font, 15)
		lbl.Parent = frame
		lbl.Position = UDim2.new(1, 8, 0, 0)
		lbl.Size = UDim2.new(0, 120, 1, 0)
		local state = false
		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				state = not state
				check.Visible = state
				if callback then callback(state) end
			end
		end)
		return frame
	end

	function tab_data:AddRadio(text, group, callback)
		local frame, dot = makeRadio()
		frame.Parent = Content
		local lbl = makeLabel(text, Color3.new(1,1,1), options.font, 15)
		lbl.Parent = frame
		lbl.Position = UDim2.new(1, 8, 0, 0)
		lbl.Size = UDim2.new(0, 120, 1, 0)
		if not library._radioGroups then library._radioGroups = {} end
		if not library._radioGroups[group] then library._radioGroups[group] = {} end
		table.insert(library._radioGroups[group], dot)
		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				for _,d in ipairs(library._radioGroups[group]) do d.Visible = false end
				dot.Visible = true
				if callback then callback() end
			end
		end)
		return frame
	end

	function tab_data:AddProgressBar()
		local bar, fill = makeProgressBar()
		bar.Parent = Content
		function bar:SetProgress(p)
			fill.Size = UDim2.new(math.clamp(p,0,1),0,1,0)
		end
		return bar
	end

	function tab_data:AddNotification(text)
		local notif = makeNotification(text)
		notif.Parent = imgui
		notif.Position = UDim2.new(0.5, -150, 0, 40)
		notif.Visible = true
		delay(2, function() notif:Destroy() end)
		return notif
	end

	function tab_data:AddTooltip(obj, text)
		local tip = makeTooltip(text)
		tip.Parent = imgui
		obj.MouseEnter:Connect(function()
			tip.Position = UDim2.new(0, obj.AbsolutePosition.X, 0, obj.AbsolutePosition.Y + obj.AbsoluteSize.Y + 4)
			tip.Visible = true
		end)
		obj.MouseLeave:Connect(function()
			tip.Visible = false
		end)
		return tip
	end

	function tab_data:AddModal(title, content)
		local modal = makeModal(title, content)
		modal.Parent = imgui
		modal.Position = UDim2.new(0.5, -200, 0.5, -100)
		modal.Visible = true
		return modal
	end

	return tab_data, Window
end

return library

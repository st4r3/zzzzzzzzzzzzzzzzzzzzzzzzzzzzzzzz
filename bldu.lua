-- Flexible CSGO-Style UI Library
local default_options = {
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

local imgui = {}
imgui.__index = imgui

function imgui.new(title)
	local self = setmetatable({}, imgui)
	self._gui = Instance.new("ScreenGui")
	self._gui.Name = "imgui"
	self._gui.Parent = game:GetService("CoreGui")

	self._window = Instance.new("Frame")
	self._window.Name = "Window"
	self._window.Parent = self._gui
	self._window.BackgroundColor3 = default_options.background_color
	self._window.Position = UDim2.new(0, 40, 0, 40)
	self._window.Size = UDim2.new(0, default_options.min_size.X, 0, default_options.min_size.Y)
	self._window.BorderSizePixel = 0
	border(self._window)

	self._topbar = Instance.new("Frame")
	self._topbar.Parent = self._window
	self._topbar.BackgroundColor3 = Color3.fromRGB(24,24,24)
	self._topbar.Size = UDim2.new(1, 0, 0, 28)
	self._topbar.BorderSizePixel = 0
	border(self._topbar)
	local titleLbl = Instance.new("TextLabel")
	titleLbl.Text = title or "Window"
	titleLbl.Font = default_options.font
	titleLbl.TextColor3 = Color3.fromRGB(220,220,220)
	titleLbl.TextSize = 15
	titleLbl.BackgroundTransparency = 1
	titleLbl.Size = UDim2.new(1, -8, 1, 0)
	titleLbl.Position = UDim2.new(0, 8, 0, 0)
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Parent = self._topbar

	self._tabs = {}
	self._tabButtons = {}
	self._selectedTab = nil
	self._tabBar = Instance.new("Frame")
	self._tabBar.Parent = self._window
	self._tabBar.BackgroundTransparency = 1
	self._tabBar.Position = UDim2.new(0, 0, 0, 28)
	self._tabBar.Size = UDim2.new(1, 0, 0, 28)

	self._content = Instance.new("Frame")
	self._content.Parent = self._window
	self._content.BackgroundTransparency = 1
	self._content.Position = UDim2.new(0, 0, 0, 56)
	self._content.Size = UDim2.new(1, 0, 1, -56)

	return self
end

function imgui:AddTab(name)
	local tab = {}
	tab._name = name
	tab._content = Instance.new("Frame")
	tab._content.BackgroundTransparency = 1
	tab._content.Size = UDim2.new(1, 0, 1, 0)
	tab._content.Visible = false
	tab._content.Parent = self._content
	tab._controls = {}

	local btn = Instance.new("TextButton")
	btn.Text = name
	btn.Font = default_options.font
	btn.TextColor3 = Color3.fromRGB(180,180,180)
	btn.TextSize = 15
	btn.BackgroundColor3 = Color3.fromRGB(24,24,24)
	btn.Size = UDim2.new(0, 110, 1, 0)
	btn.Position = UDim2.new(0, #self._tabButtons*112, 0, 0)
	btn.BorderSizePixel = 0
	border(btn)
	btn.Parent = self._tabBar

	table.insert(self._tabs, tab)
	table.insert(self._tabButtons, btn)

	btn.MouseButton1Click:Connect(function()
		for i, t in ipairs(self._tabs) do
			t._content.Visible = false
			self._tabButtons[i].TextColor3 = Color3.fromRGB(180,180,180)
			self._tabButtons[i].BackgroundColor3 = Color3.fromRGB(24,24,24)
		end
		tab._content.Visible = true
		btn.TextColor3 = default_options.accent_color
		btn.BackgroundColor3 = default_options.background_color
		self._selectedTab = tab
	end)

	if #self._tabs == 1 then
		btn.TextColor3 = default_options.accent_color
		btn.BackgroundColor3 = default_options.background_color
		tab._content.Visible = true
		self._selectedTab = tab
	end

	function tab:AddCheckbox(text, callback)
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
		frame.Parent = tab._content
		frame.Position = UDim2.new(0, 16, 0, #tab._controls*32+16)
		frame.MouseButton1Click:Connect(function()
			check.Visible = not check.Visible
			if callback then callback(check.Visible) end
		end)
		table.insert(tab._controls, frame)
		return frame
	end

	function tab:AddSlider(text, min, max, value, callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 220, 0, 32)
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
		frame.Parent = tab._content
		frame.Position = UDim2.new(0, 16, 0, #tab._controls*32+16)
		table.insert(tab._controls, frame)
		return frame
	end

	function tab:AddDropdown(text, items, callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 220, 0, 32)
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
		frame.Parent = tab._content
		frame.Position = UDim2.new(0, 16, 0, #tab._controls*32+16)
		table.insert(tab._controls, frame)
		return frame
	end

	function tab:AddColorPicker(text, startColor, callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 220, 0, 32)
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
		box.BackgroundColor3 = startColor or Color3.fromRGB(0,170,255)
		box.Size = UDim2.new(0, 28, 0, 20)
		box.Position = UDim2.new(0.5, 10, 0, 6)
		box.BorderSizePixel = 0
		border(box)
		box.Parent = frame
		local popup
		box.MouseButton1Click:Connect(function()
			if popup and popup.Parent then popup:Destroy() end
			popup = Instance.new("Frame")
			popup.Size = UDim2.new(0, 180, 0, 120)
			popup.Position = UDim2.new(0, box.AbsolutePosition.X, 0, box.AbsolutePosition.Y + box.AbsoluteSize.Y + 4)
			popup.BackgroundColor3 = Color3.fromRGB(30,30,30)
			popup.BorderSizePixel = 0
			border(popup)
			popup.Parent = self._gui
			local r = Instance.new("TextBox")
			r.Size = UDim2.new(0, 40, 0, 24)
			r.Position = UDim2.new(0, 10, 0, 10)
			r.Text = tostring(math.floor(box.BackgroundColor3.R*255))
			r.Parent = popup
			local g = Instance.new("TextBox")
			g.Size = UDim2.new(0, 40, 0, 24)
			g.Position = UDim2.new(0, 60, 0, 10)
			g.Text = tostring(math.floor(box.BackgroundColor3.G*255))
			g.Parent = popup
			local b = Instance.new("TextBox")
			b.Size = UDim2.new(0, 40, 0, 24)
			b.Position = UDim2.new(0, 110, 0, 10)
			b.Text = tostring(math.floor(box.BackgroundColor3.B*255))
			b.Parent = popup
			local ok = Instance.new("TextButton")
			ok.Text = "OK"
			ok.Size = UDim2.new(0, 50, 0, 24)
			ok.Position = UDim2.new(0, 65, 0, 50)
			ok.Parent = popup
			ok.MouseButton1Click:Connect(function()
				local rc = tonumber(r.Text) or 0
				local gc = tonumber(g.Text) or 0
				local bc = tonumber(b.Text) or 0
				local color = Color3.fromRGB(rc, gc, bc)
				box.BackgroundColor3 = color
				if callback then callback(color) end
				popup:Destroy()
			end)
		end)
		frame.Parent = tab._content
		frame.Position = UDim2.new(0, 16, 0, #tab._controls*32+16)
		table.insert(tab._controls, frame)
		return frame
	end

	return tab
end

return imgui

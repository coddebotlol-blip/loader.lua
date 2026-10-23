--[[
	Key System - terminal style, Work.ink only (BLUE)
	Fill CONFIG.WORKINK_LINK + put real verify in onSubmit(key)
]]

local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Players          = game:GetService("Players")
local player           = Players.LocalPlayer
local playerGui        = player:WaitForChild("PlayerGui")

local CONFIG = {
	WORKINK_LINK = "https://work.ink/YOUR_LINK_HERE",
}

local function onSubmit(key)
	print("[KeySystem] checking key:", key)
	-- replace with real API validate later
	return true
end

local C = {
	Window   = Color3.fromRGB(10, 12, 18),
	TitleBar = Color3.fromRGB(28, 34, 48),
	Border   = Color3.fromRGB(45, 55, 75),
	Title    = Color3.fromRGB(230, 235, 245),
	Accent   = Color3.fromRGB(64, 156, 255),   -- blue
	Line     = Color3.fromRGB(220, 228, 240),
	Footer   = Color3.fromRGB(110, 125, 150),
	ButtonBg = Color3.fromRGB(16, 20, 28),
	Error    = Color3.fromRGB(225, 80, 70),
	Ok       = Color3.fromRGB(100, 220, 160),
}

local old = playerGui:FindFirstChild("KeySystem")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystem"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.53, 0)
main.Size = UDim2.fromOffset(560, 190)
main.BackgroundColor3 = C.Window
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = C.Border
mainStroke.Thickness = 1
mainStroke.Parent = main

TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = C.TitleBar
titleBar.BorderSizePixel = 0
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleFill = Instance.new("Frame")
titleFill.Position = UDim2.new(0, 0, 1, -10)
titleFill.Size = UDim2.new(1, 0, 0, 10)
titleFill.BackgroundColor3 = C.TitleBar
titleFill.BorderSizePixel = 0
titleFill.Parent = titleBar

local icon = Instance.new("TextLabel")
icon.Position = UDim2.fromOffset(10, 8)
icon.Size = UDim2.fromOffset(24, 24)
icon.BackgroundColor3 = Color3.fromRGB(18, 24, 36)
icon.BorderSizePixel = 0
icon.Text = ">_"
icon.TextColor3 = C.Accent
icon.TextSize = 13
icon.Font = Enum.Font.Code
icon.Parent = titleBar
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 5)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(44, 0)
title.Size = UDim2.new(1, -90, 1, 0)
title.Text = "./key-system"
title.TextColor3 = C.Title
title.TextSize = 16
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.AnchorPoint = Vector2.new(1, 0.5)
closeBtn.Position = UDim2.new(1, -10, 0.5, 0)
closeBtn.Size = UDim2.fromOffset(30, 30)
closeBtn.BackgroundColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundTransparency = 1
closeBtn.AutoButtonColor = false
closeBtn.Text = ""
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local closeBars = {}
do
	local function bar(length, rotation)
		local piece = Instance.new("Frame")
		piece.AnchorPoint = Vector2.new(0.5, 0.5)
		piece.Position = UDim2.fromOffset(15, 15)
		piece.Size = UDim2.fromOffset(length, 2)
		piece.BackgroundColor3 = Color3.fromRGB(170, 185, 210)
		piece.BorderSizePixel = 0
		piece.Rotation = rotation
		piece.Parent = closeBtn
		Instance.new("UICorner", piece).CornerRadius = UDim.new(0, 1)
		table.insert(closeBars, piece)
	end
	bar(14, 45)
	bar(14, -45)
end

closeBtn.MouseEnter:Connect(function()
	closeBtn.BackgroundTransparency = 0.9
	for _, b in closeBars do b.BackgroundColor3 = C.Error end
end)
closeBtn.MouseLeave:Connect(function()
	closeBtn.BackgroundTransparency = 1
	for _, b in closeBars do b.BackgroundColor3 = Color3.fromRGB(170, 185, 210) end
end)

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Position = UDim2.fromOffset(26, 54)
status.Size = UDim2.new(1, -52, 0, 26)
status.RichText = true
status.Text = '<font color="#8A9BB5">&lt;</font> <font color="#409CFF">KEY SYSTEM</font>'
status.TextColor3 = C.Line
status.TextSize = 20
status.Font = Enum.Font.Code
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

local row = Instance.new("Frame")
row.BackgroundTransparency = 1
row.Position = UDim2.fromOffset(26, 92)
row.Size = UDim2.new(1, -52, 0, 34)
row.Parent = main

local rowLayout = Instance.new("UIListLayout")
rowLayout.FillDirection = Enum.FillDirection.Horizontal
rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
rowLayout.Padding = UDim.new(0, 10)
rowLayout.Parent = row

local function termButton(text, width, order)
	local btn = Instance.new("TextButton")
	btn.LayoutOrder = order
	btn.Size = UDim2.fromOffset(width, 34)
	btn.BackgroundColor3 = C.ButtonBg
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(190, 205, 225)
	btn.TextSize = 15
	btn.Font = Enum.Font.Code
	btn.Parent = row
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
	local stroke = Instance.new("UIStroke")
	stroke.Color = C.Border
	stroke.Thickness = 1
	stroke.Parent = btn
	btn.MouseEnter:Connect(function()
		stroke.Color = C.Accent
		btn.TextColor3 = C.Accent
	end)
	btn.MouseLeave:Connect(function()
		stroke.Color = C.Border
		btn.TextColor3 = Color3.fromRGB(190, 205, 225)
	end)
	return btn
end

local keyBox = Instance.new("TextBox")
keyBox.LayoutOrder = 1
keyBox.Size = UDim2.fromOffset(230, 34)
keyBox.BackgroundColor3 = C.ButtonBg
keyBox.BorderSizePixel = 0
keyBox.ClearTextOnFocus = false
keyBox.Text = ""
keyBox.PlaceholderText = "paste your key here"
keyBox.PlaceholderColor3 = C.Footer
keyBox.TextColor3 = C.Line
keyBox.TextSize = 15
keyBox.Font = Enum.Font.Code
keyBox.TextXAlignment = Enum.TextXAlignment.Left
keyBox.Parent = row
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 4)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = C.Border
boxStroke.Thickness = 1
boxStroke.Parent = keyBox

local boxPad = Instance.new("UIPadding")
boxPad.PaddingLeft = UDim.new(0, 10)
boxPad.PaddingRight = UDim.new(0, 10)
boxPad.Parent = keyBox

local workinkBtn = termButton("Get Key (Work.ink)", 170, 2)
local pasteBtn   = termButton("Paste", 80, 3)
local submitBtn  = termButton("Submit", 90, 4)

local line = Instance.new("TextLabel")
line.BackgroundTransparency = 1
line.Position = UDim2.fromOffset(26, 134)
line.Size = UDim2.new(1, -52, 0, 20)
line.Text = "No key? Hit Work.ink -> finish the steps -> paste the key -> Submit."
line.TextColor3 = C.Footer
line.TextSize = 14
line.Font = Enum.Font.Code
line.TextXAlignment = Enum.TextXAlignment.Left
line.Parent = main

local footer = Instance.new("TextLabel")
footer.AnchorPoint = Vector2.new(0, 1)
footer.BackgroundTransparency = 1
footer.Position = UDim2.new(0, 26, 1, -10)
footer.Size = UDim2.new(1, -52, 0, 18)
footer.Text = "Press [CTRL+C] to exit"
footer.TextColor3 = C.Footer
footer.TextSize = 13
footer.Font = Enum.Font.Code
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = main

local closed = false
local function destroy()
	if closed then return end
	closed = true
	pcall(function() screenGui:Destroy() end)
end

local function setStatus(word, color)
	status.Text = '<font color="#8A9BB5">&lt;</font> <font color="'..(color or "#409CFF")..'">'..word..'</font>'
end

local function setLine(text, color)
	line.Text = text
	line.TextColor3 = color or C.Footer
end

local function submitKey()
	if closed then return end
	local key = keyBox.Text:gsub("^%s*(.-)%s*$", "%1")
	if key == "" then
		setLine("Enter your key first.", C.Error)
		return
	end
	setLine("Checking key...", C.Line)
	task.spawn(function()
		local ok, result = pcall(onSubmit, key)
		if ok and result == true then
			setStatus("KEY VALID", "#64DCB0")
			setLine("Key valid - loading...", C.Ok)
			task.wait(0.6)
			destroy()
		elseif ok and result == "HWID_LOCKED" then
			setLine("That key is linked to another device.", C.Error)
		elseif ok and result == "EXPIRED" then
			setLine("That key has expired - get a new one via Work.ink.", C.Error)
		else
			setLine("Invalid key!", C.Error)
		end
	end)
end

keyBox.Focused:Connect(function() boxStroke.Color = C.Accent end)
keyBox.FocusLost:Connect(function(enter)
	boxStroke.Color = C.Border
	if enter then submitKey() end
end)

workinkBtn.MouseButton1Click:Connect(function()
	local ok = pcall(function() setclipboard(CONFIG.WORKINK_LINK) end)
	if ok then
		setLine("Work.ink link copied! Finish the steps, then paste your key here.")
	else
		setLine(CONFIG.WORKINK_LINK)
	end
end)

pasteBtn.MouseButton1Click:Connect(function()
	local get = getclipboard or (syn and syn.read_clipboard)
	if not get then
		setLine("Clipboard read not supported - use CTRL+V.", C.Error)
		return
	end
	local ok, text = pcall(get)
	if ok and type(text) == "string" and text:gsub("%s", "") ~= "" then
		keyBox.Text = text:gsub("^%s*(.-)%s*$", "%1")
		setLine("Pasted from clipboard.")
	else
		setLine("Clipboard is empty.", C.Error)
	end
end)

submitBtn.MouseButton1Click:Connect(submitKey)
closeBtn.MouseButton1Click:Connect(destroy)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.C and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		destroy()
	end
end)

local dragging, dragStart, dragOrigin
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging, dragStart, dragOrigin = true, input.Position, main.Position
		local release
		release = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				release:Disconnect()
			end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if not dragging then return end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement
	and input.UserInputType ~= Enum.UserInputType.Touch then return end
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		dragOrigin.X.Scale, dragOrigin.X.Offset + delta.X,
		dragOrigin.Y.Scale, dragOrigin.Y.Offset + delta.Y)
end)

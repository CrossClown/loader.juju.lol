-- LocalScript inside StarterGui

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "skidLoader"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Loader window
local window = Instance.new("Frame")
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.new(0.5, 0, 0.5, 0)
window.Size = UDim2.new(0, 360, 0, 140)
window.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- pitch black
window.BorderSizePixel = 0
window.Parent = screenGui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 8)
windowCorner.Parent = window

-- Title text
local title = Instance.new("TextLabel")
title.Text = "loading skidware..."
title.AnchorPoint = Vector2.new(0.5, 0)
title.Position = UDim2.new(0.5, 0, 0.2, 0)
title.Size = UDim2.new(0.9, 0, 0.25, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 0) -- neon green
title.Font = Enum.Font.Code
title.TextScaled = true
title.Parent = window

-- Progress bar background
local barBg = Instance.new("Frame")
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.Position = UDim2.new(0.5, 0, 0.65, 0)
barBg.Size = UDim2.new(0.85, 0, 0.14, 0)
barBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
barBg.BorderSizePixel = 0
barBg.Parent = window

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(0, 6)
barBgCorner.Parent = barBg

-- Progress bar fill
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- neon green
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(0, 6)
barFillCorner.Parent = barFill

-- Glow effect
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(0, 255, 0)
glow.Thickness = 2
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Parent = barFill

-- Percentage text
local percentText = Instance.new("TextLabel")
percentText.AnchorPoint = Vector2.new(0.5, 0)
percentText.Position = UDim2.new(0.5, 0, 0.82, 0)
percentText.Size = UDim2.new(0.9, 0, 0.15, 0)
percentText.BackgroundTransparency = 1
percentText.TextColor3 = Color3.fromRGB(0, 255, 0)
percentText.Font = Enum.Font.Code
percentText.TextScaled = true
percentText.Text = "0%"
percentText.Parent = window

-- Loader function
local function runLoader()
	for i = 1, 100 do
		local tween = TweenService:Create(
			barFill,
			TweenInfo.new(0.02, Enum.EasingStyle.Linear),
			{Size = UDim2.new(i/100, 0, 1, 0)}
		)
		tween:Play()
		percentText.Text = tostring(i) .. "%"
		task.wait(0.02)
	end

	-- Fade out loader
	local fadeTween = TweenService:Create(window, TweenInfo.new(0.8), {BackgroundTransparency = 1})
	fadeTween:Play()
	TweenService:Create(title, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
	TweenService:Create(percentText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
	TweenService:Create(barBg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
	TweenService:Create(barFill, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()

	task.wait(1)
	screenGui:Destroy()
end

-- Run it
runLoader()

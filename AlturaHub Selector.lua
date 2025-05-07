local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AlturaSelectorGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 260)
frame.Position = UDim2.new(0.5, -170, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Select a Mode"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.Parent = frame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "by pxrson"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.Parent = frame

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 25, 0, 25)
exitBtn.Position = UDim2.new(1, -30, 0, 5)
exitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
exitBtn.Text = "X"
exitBtn.TextColor3 = Color3.new(1, 1, 1)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 14
exitBtn.Parent = frame
Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 6)

exitBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, 0, 1, -60)
buttonFrame.Position = UDim2.new(0, 0, 0, 60)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = buttonFrame

local modes = {
    {
        Name = "MM2",
        Script = "https://raw.githubusercontent.com/DatUnknownGuy/Altura-Hub/refs/heads/main/AlturaHubV1.5.lua"
    },
    {
        Name = "A literal baseplate.",
        Script = "https://raw.githubusercontent.com/DatUnknownGuy/Altura-Hub/refs/heads/main/A%20literal%20baseplate.lua"
    },
    {
        Name = "Position Tracker",
        Script = "https://raw.githubusercontent.com/DatUnknownGuy/Altura-Hub/refs/heads/main/Position%20Tracker.lua"
    }
}

for _, mode in ipairs(modes) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 300, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = mode.Name
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 20
    button.Parent = buttonFrame

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    button.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        local success, err = pcall(function()
            local source = game:HttpGet(mode.Script)
            loadstring(source)()
        end)
        if not success then
            warn("Failed to load:", err)
        end
    end)
end

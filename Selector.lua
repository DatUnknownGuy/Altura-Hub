local player = game.Players.LocalPlayer
local selectionGui = Instance.new("ScreenGui")
selectionGui.Name = "ModeSelector"
selectionGui.ResetOnSpawn = false
selectionGui.IgnoreGuiInset = true
selectionGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 260)
frame.Position = UDim2.new(0.5, -170, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = selectionGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = frame

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

for i, mode in ipairs(modes) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 300, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = mode.Name
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 20
    button.LayoutOrder = i
    button.Parent = buttonFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    button.MouseButton1Click:Connect(function()
        selectionGui:Destroy()
        local success, err = pcall(function()
            local source = game:HttpGet(mode.Script)
            loadstring(source)()
        end)
        if not success then
            warn("[Selector] Failed to load " .. mode.Name .. ":", err)
        end
    end)
end

local player = game.Players.LocalPlayer
local rootPart = nil
local updateConnection = nil
local screenGui = nil

local function startPositionTracker()
    if screenGui then screenGui:Destroy() end

    local character = player.Character or player.CharacterAdded:Wait()
    rootPart = character:WaitForChild("HumanoidRootPart")

    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PositionTracker"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 180)
    frame.Position = UDim2.new(0.5, -170, 0.5, -90)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Position Tracker"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame

    local posLabel = Instance.new("TextLabel")
    posLabel.Size = UDim2.new(1, -20, 0, 30)
    posLabel.Position = UDim2.new(0, 10, 0, 50)
    posLabel.BackgroundTransparency = 1
    posLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    posLabel.Font = Enum.Font.Gotham
    posLabel.TextSize = 20
    posLabel.TextXAlignment = Enum.TextXAlignment.Left
    posLabel.Text = "X: 0, Y: 0, Z: 0"
    posLabel.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 120, 0, 35)
    copyBtn.Position = UDim2.new(0.5, -130, 1, -45)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    copyBtn.Text = "Copy"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextColor3 = Color3.new(1, 1, 1)
    copyBtn.TextSize = 18
    copyBtn.Parent = frame

    local exitBtn = Instance.new("TextButton")
    exitBtn.Size = UDim2.new(0, 120, 0, 35)
    exitBtn.Position = UDim2.new(0.5, 10, 1, -45)
    exitBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
    exitBtn.Text = "Exit"
    exitBtn.Font = Enum.Font.GothamBold
    exitBtn.TextColor3 = Color3.new(1, 1, 1)
    exitBtn.TextSize = 18
    exitBtn.Parent = frame

    local c1 = Instance.new("UICorner")
    c1.CornerRadius = UDim.new(0, 8)
    c1.Parent = copyBtn
    local c2 = Instance.new("UICorner")
    c2.CornerRadius = UDim.new(0, 8)
    c2.Parent = exitBtn

    local currentPosition = "X: 0, Y: 0, Z: 0"
    if updateConnection then updateConnection:Disconnect() end

    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if rootPart then
            local pos = rootPart.Position
            currentPosition = "X: " .. math.floor(pos.X) .. ", Y: " .. math.floor(pos.Y) .. ", Z: " .. math.floor(pos.Z)
            posLabel.Text = currentPosition
        end
    end)

    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(currentPosition)
        copyBtn.Text = "Copied!"
        task.delay(1, function()
            copyBtn.Text = "Copy"
        end)
    end)

    exitBtn.MouseButton1Click:Connect(function()
        if updateConnection then updateConnection:Disconnect() end
        screenGui:Destroy()
    end)
end

startPositionTracker()

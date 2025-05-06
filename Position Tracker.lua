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
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 120)
    frame.Position = UDim2.new(0.5, -150, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundTransparency = 1
    title.Text = "Position Tracker"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = frame
    local positionLabel = Instance.new("TextLabel")
    positionLabel.Position = UDim2.new(0, 10, 0, 35)
    positionLabel.Size = UDim2.new(1, -20, 0, 20)
    positionLabel.BackgroundTransparency = 1
    positionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    positionLabel.Font = Enum.Font.SourceSans
    positionLabel.TextSize = 18
    positionLabel.TextXAlignment = Enum.TextXAlignment.Left
    positionLabel.Text = "X: 0, Y: 0, Z: 0"
    positionLabel.Parent = frame
    local copyButton = Instance.new("TextButton")
    copyButton.Position = UDim2.new(0.5, -100, 1, -35)
    copyButton.Size = UDim2.new(0, 80, 0, 25)
    copyButton.Text = "Copy"
    copyButton.Font = Enum.Font.SourceSansBold
    copyButton.TextSize = 18
    copyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.Parent = frame
    local exitButton = Instance.new("TextButton")
    exitButton.Position = UDim2.new(0.5, 20, 1, -35)
    exitButton.Size = UDim2.new(0, 80, 0, 25)
    exitButton.Text = "Exit"
    exitButton.Font = Enum.Font.SourceSansBold
    exitButton.TextSize = 18
    exitButton.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
    exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    exitButton.Parent = frame
    local currentPosition = "X: 0, Y: 0, Z: 0"
    if updateConnection then updateConnection:Disconnect() end
    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if rootPart then
            local pos = rootPart.Position
            currentPosition = "X: " .. math.floor(pos.X) .. ", Y: " .. math.floor(pos.Y) .. ", Z: " .. math.floor(pos.Z)
            positionLabel.Text = currentPosition
        end
    end)
    copyButton.MouseButton1Click:Connect(function()
        setclipboard(currentPosition)
        copyButton.Text = "Copied!"
        task.wait(1)
        copyButton.Text = "Copy"
    end)
    exitButton.MouseButton1Click:Connect(function()
        if updateConnection then updateConnection:Disconnect() end
        screenGui:Destroy()
    end)
end

startPositionTracker()

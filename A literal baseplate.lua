local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow{
    Title = "A literal baseplate",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(630, 400),
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Vynixu",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "layout-dashboard" },
    Movement = Window:CreateTab{ Title = "Movement", Icon = "hand" },
    Utilities = Window:CreateTab{ Title = "Utilities", Icon = "pen-line" },
    Information = Window:CreateTab{ Title = "Information", Icon = "info" },
    Credits = Window:CreateTab{ Title = "Credits", Icon = "badge-info" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "settings" }
}

local Paragraph = Tabs.Main:CreateParagraph("Paragraph", {
    Title = "Main Tab Information",
    Content = "This is the Main tab, you will find all the main stuff below."
})

Tabs.Main:CreateToggle("Test", {
    Title = "Button Test",
})

local Options = Library.Options
local player = game.Players.LocalPlayer

Tabs.Movement:CreateToggle("WalkSpeedToggle", {Title = "WalkSpeed", Default = false})
Tabs.Movement:CreateSlider("WalkSpeedSlider", {
    Title = "Speed",
    Default = 16,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(val)
        if Options.WalkSpeedToggle.Value then
            player.Character.Humanoid.WalkSpeed = val
        end
    end
})
Options.WalkSpeedToggle:OnChanged(function(val)
    if not val then
        player.Character.Humanoid.WalkSpeed = 16
    else
        player.Character.Humanoid.WalkSpeed = Options.WalkSpeedSlider.Value
    end
end)

Tabs.Movement:CreateToggle("JumpPowerToggle", {Title = "JumpPower", Default = false})
Tabs.Movement:CreateSlider("JumpPowerSlider", {
    Title = "Jump",
    Default = 50,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(val)
        if Options.JumpPowerToggle.Value then
            player.Character.Humanoid.JumpPower = val
        end
    end
})
Options.JumpPowerToggle:OnChanged(function(val)
    if not val then
        player.Character.Humanoid.JumpPower = 50
    else
        player.Character.Humanoid.JumpPower = Options.JumpPowerSlider.Value
    end
end)

Tabs.Utilities:CreateToggle("NoclipToggle", {
    Title = "Noclip",
    Default = false,
    Callback = function(enabled)
        local RunService = game:GetService("RunService")
        if enabled then
            noclipConnection = RunService.Stepped:Connect(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then noclipConnection:Disconnect() end
        end
    end
})

Tabs.Utilities:CreateToggle("InfiniteJumpToggle", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(enabled)
        local UIS = game:GetService("UserInputService")
        if enabled then
            infiniteJumpConn = UIS.JumpRequest:Connect(function()
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        else
            if infiniteJumpConn then infiniteJumpConn:Disconnect() end
        end
    end
})

Tabs.Utilities:CreateToggle("LockPositionToggle", {
    Title = "Lock Position",
    Default = false,
    Callback = function(Value)
        if Value then
            local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
                end
            end)
        else
            if getgenv().posLock then
                getgenv().posLock:Disconnect()
            end
        end
    end
})

local playerDropdown = Tabs.Utilities:CreateDropdown("SelectPlayer", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = 1
})

local followRunner = nil

Tabs.Utilities:CreateToggle("FollowBehindToggle", {
    Title = "Follow Behind Player",
    Default = false,
    Callback = function(enabled)
        if followRunner then followRunner:Disconnect() end
        if enabled then
            local targetName = Options.SelectPlayer.Value
            local targetPlayer = game.Players:FindFirstChild(targetName)
            if targetPlayer then
                followRunner = game:GetService("RunService").Heartbeat:Connect(function()
                    local char = player.Character
                    local targetChar = targetPlayer.Character
                    if char and targetChar and char:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
                        local myHRP = char.HumanoidRootPart
                        local targetHRP = targetChar.HumanoidRootPart
                        local direction = (targetHRP.Position - myHRP.Position).Unit
                        local behindPosition = targetHRP.Position - direction * 3
                        myHRP.CFrame = CFrame.new(behindPosition, targetHRP.Position)
                    end
                end)
            end
        end
    end
})

game.Players.PlayerAdded:Connect(function(p)
    table.insert(playerDropdown.Values, p.Name)
    playerDropdown:SetValues(playerDropdown.Values)
end)

game.Players.PlayerRemoving:Connect(function(p)
    for i, name in ipairs(playerDropdown.Values) do
        if name == p.Name then
            table.remove(playerDropdown.Values, i)
            break
        end
    end
    playerDropdown:SetValues(playerDropdown.Values)
end)

for _, p in ipairs(game.Players:GetPlayers()) do
    table.insert(playerDropdown.Values, p.Name)
end
playerDropdown:SetValues(playerDropdown.Values)

local Paragraph = Tabs.Information:CreateParagraph("Paragraph", {
    Title = "Information",
    Content = "This script was created by "Dat1UnknownGuy" and the helper "pxrson"."
})

Tabs.Information:CreateParagraph("Paragraph", {
    Title = "Information",
    Content = "Don't expect this script to be the best, I made it for fun."
})

Tabs.Credits:CreateParagraph("Paragraph", {
    Title = "Credits",
    Content = "Credits to pxrson and Dat1UnknownGuy"
})

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/Baseplate")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()

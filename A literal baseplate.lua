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
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "layout-dashboard" },
    Movement = Window:CreateTab{ Title = "Movement", Icon = "hand" },
    Utilities = Window:CreateTab{ Title = "Utilities", Icon = "pen-line" },
    Credits = Window:CreateTab{ Title = "Credits", Icon = "badge-info" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "settings" }
}

local player = game.Players.LocalPlayer

Tabs.Movement:CreateToggle("WalkSpeedToggle", {Title = "WalkSpeed", Default = false})

Tabs.Movement:CreateSlider("WalkSpeedSlider", {
    Title = "Speed",
    Default = 16,
    Min = 0,
    Max = 500,
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
    Max = 500,
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

local Paragraph = Tabs.Credits:CreateParagraph("Paragraph", {
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

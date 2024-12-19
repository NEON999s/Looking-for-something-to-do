local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TargetUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Set Target Player"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSans
Title.TextSize = 20
Title.Parent = MainFrame

local PlayerNameBox = Instance.new("TextBox")
PlayerNameBox.Size = UDim2.new(0.8, 0, 0, 30)
PlayerNameBox.Position = UDim2.new(0.1, 0, 0.3, 0)
PlayerNameBox.PlaceholderText = "Enter Player Name"
PlayerNameBox.Text = ""
PlayerNameBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
PlayerNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameBox.Font = Enum.Font.SourceSans
PlayerNameBox.TextSize = 18
PlayerNameBox.Parent = MainFrame

local SetTargetButton = Instance.new("TextButton")
SetTargetButton.Size = UDim2.new(0.8, 0, 0, 30)
SetTargetButton.Position = UDim2.new(0.1, 0, 0.6, 0)
SetTargetButton.Text = "Set Target"
SetTargetButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SetTargetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SetTargetButton.Font = Enum.Font.SourceSans
SetTargetButton.TextSize = 18
SetTargetButton.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 0, 0.5, -25)
ToggleButton.Text = "☰"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.TextSize = 30
ToggleButton.Parent = ScreenGui

local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local targetPlayer = nil

local function SetTarget()
    local playerName = PlayerNameBox.Text
    targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer ~= LocalPlayer then
        PlayerNameBox.Text = "Target: " .. playerName
        PlayerNameBox.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
    else
        PlayerNameBox.Text = "Player not found"
        PlayerNameBox.BackgroundColor3 = Color3.fromRGB(128, 0, 0)
    end
end

SetTargetButton.MouseButton1Click:Connect(SetTarget)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
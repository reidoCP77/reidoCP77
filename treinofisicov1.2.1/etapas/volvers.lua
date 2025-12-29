--print("Hello, World!")
-- LocalScript - StarterPlayerScripts

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheckboxCameraGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 90)
Frame.Position = UDim2.new(0, 20, 0.5, -45)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1

Title.Text = "VOLVER'S"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = Frame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

local CheckBox = Instance.new("TextButton")
CheckBox.Size = UDim2.new(0, 160, 0, 30)
CheckBox.Position = UDim2.new(0, 30, 0, 45)
CheckBox.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
CheckBox.Text = "OFF"
CheckBox.TextColor3 = Color3.new(1, 1, 1)
CheckBox.Font = Enum.Font.GothamBold
CheckBox.TextSize = 14
CheckBox.Parent = Frame

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckBox

local Enabled = false
local Cooldown = false

local function updateButton()
    if Enabled then
        CheckBox.Text = "ON"
        CheckBox.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        CheckBox.Text = "OFF"
        CheckBox.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    end
end

CheckBox.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    updateButton()
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

updateButton()

local dragging = false
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
        )
    end
end)

local function applyWithDelay(func)
    if Cooldown then return end
    Cooldown = true
    task.delay(0.2, function()
        func()
        Cooldown = false
    end)
end

local function rotateCameraRight()
    local cf = Camera.CFrame
    Camera.CFrame = cf * CFrame.Angles(0, math.rad(-90), 0)
end

local function rotateCameraLeft()
    local cf = Camera.CFrame
    Camera.CFrame = cf * CFrame.Angles(0, math.rad(90), 0)
end

local function rotateCameraDown()
    local cf = Camera.CFrame
    Camera.CFrame = cf * CFrame.Angles(0, math.rad(180), 0)
end

TextChatService.OnIncomingMessage = function(message)
    if not Enabled then return end
    if not message.Text then return end
    
    local text = message.Text:upper()
    
    if text == "DIREI TA VOLVER!" or text == "DIREI TA VOLVER !" or text == "DIREITA VOLVER!" or text == "DIREITA VOLVER !" then
        rotateCameraRight()
    end
    
    if text == "ESQUERDA VOLVER!" or text == "ES QUERDA VOLVER!" or text == "ES QUER DA VOLVER!" or text == "ESQUERDA VOLVER !" or text == "ES QUER DA VOLVER !" or text == "ES QUERDA VOLVER !" then
       rotateCameraLeft()
    end
    
    if text == "RETA GUARDA VOLVER!" or text == "RETA GUARDA VOLVER !" or text == "RETAGUARDA VOLVER!" or text == "RETAGUARDA VOLVER !" then
       rotateCameraDown()    
    end
end
Frame.Draggable = true



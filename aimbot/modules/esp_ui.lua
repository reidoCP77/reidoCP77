_G.CONFIG = _G.CONFIG or {
    Enabled = true,
    NameESP = true,
    BoxESP = true,
    Color = Color3.fromRGB(255, 0, 0)
}

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 260)
frame.Position = UDim2.new(0, 20, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.Text = "ESP MENU"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- FECHAR
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,3)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(170,50,50)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- MINIMIZAR
local mini = Instance.new("TextButton", frame)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-70,0,3)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(50,50,50)

local minimized = false
mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    frame.Size = minimized and UDim2.new(0,220,0,40) or UDim2.new(0,220,0,260)
end)

-- BOTÕES
local function toggle(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1,-20,0,30)
    b.Position = UDim2.new(0,10,0,y)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 12

    b.MouseButton1Click:Connect(callback)
end

toggle("ESP ON / OFF", 50, function()
    _G.CONFIG.Enabled = not _G.CONFIG.Enabled
end)

toggle("Nome ESP", 90, function()
    _G.CONFIG.NameESP = not _G.CONFIG.NameESP
end)

toggle("Box ESP", 130, function()
    _G.CONFIG.BoxESP = not _G.CONFIG.BoxESP
end)

-- CORES
local colors = {
    Red = Color3.fromRGB(255,0,0),
    Green = Color3.fromRGB(0,255,0),
    Blue = Color3.fromRGB(0,170,255),
    White = Color3.fromRGB(255,255,255)
}

local y = 170
for name, color in pairs(colors) do
    toggle("Cor: "..name, y, function()
        _G.CONFIG.Color = color
    end)
    y += 35
end
local UIS = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
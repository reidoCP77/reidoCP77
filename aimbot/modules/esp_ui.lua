-- esp_ui.lua
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- CONFIGURAÇÕES
local options = {
    Enabled = true,
    NameESP = true,
    Color = Color3.fromRGB(255,0,0)
}

-- CARREGA ESP
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/reidoCP77/reidoCP77/refs/heads/main/aimbot/modules/esp_pro.lua"
))(options)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 340)
frame.Position = UDim2.new(0.5, -140, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(90,90,90)

-- TÍTULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -60, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ESP PRO"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Left

-- BOTÕES TOPO
local function TopButton(txt, pos)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0, 25, 0, 25)
    b.Position = pos
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    return b
end

local close = TopButton("X", UDim2.new(1,-30,0,8))
local minimize = TopButton("-", UDim2.new(1,-60,0,8))

-- SCROLLING
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0,10,0,50)
scroll.Size = UDim2.new(1,-20,1,-60)
scroll.CanvasSize = UDim2.new(0,0,0,200)
scroll.ScrollBarImageTransparency = 0.5
scroll.BorderSizePixel = 0
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,8)

-- BOTÃO PADRÃO
local function CreateToggle(text, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1,0,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = text
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(callback)
end

-- BOTÕES
CreateToggle("ESP ON / OFF", function()
    options.Enabled = not options.Enabled
end)

CreateToggle("NAME ESP", function()
    options.NameESP = not options.NameESP
end)

CreateToggle("COR: VERMELHO", function()
    options.Color = Color3.fromRGB(255,0,0)
end)

CreateToggle("COR: AZUL", function()
    options.Color = Color3.fromRGB(0,150,255)
end)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

-- MINIMIZAR
local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    scroll.Visible = not minimized
    frame.Size = minimized and UDim2.new(0,280,0,50) or UDim2.new(0,280,0,340)
end)

-- FECHAR
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- DRAG
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
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

UIS.InputEnded:Connect(function()
    dragging = false
end)
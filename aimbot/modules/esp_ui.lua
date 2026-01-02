-- CONFIG COMPARTILHADA COM O ESP
_G.CONFIG = _G.CONFIG or {
    Enabled = true,
    NameESP = true,
    BoxESP = true,
    Color = Color3.fromRGB(255, 0, 0)
}

-- SERVICES
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- FUNÇÕES DE ESTILO
local function round(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = obj
end

local function stroke(obj, t, col, tr)
    local s = Instance.new("UIStroke")
    s.Thickness = t
    s.Color = col
    s.Transparency = tr or 0
    s.Parent = obj
end

local function gradient(obj, colors)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(colors)
    g.Parent = obj
end

local function hover(btn)
    local enter = TweenService:Create(btn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(65,65,65)
    })
    local leave = TweenService:Create(btn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(45,45,45)
    })

    btn.MouseEnter:Connect(function() enter:Play() end)
    btn.MouseLeave:Connect(function() leave:Play() end)
end

-- GUI BASE
local gui = Instance.new("ScreenGui")
gui.Name = "ESP_PREMIUM_UI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- FRAME PRINCIPAL
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 0)
frame.Position = UDim2.new(0, 20, 0, 140)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true

round(frame, 14)
stroke(frame, 1.2, Color3.fromRGB(90,90,90), 0.2)
gradient(frame, {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(28,28,28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,15))
})

-- ANIMAÇÃO DE ABRIR
TweenService:Create(
    frame,
    TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { Size = UDim2.new(0,240,0,300) }
):Play()

-- TÍTULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "ESP PREMIUM"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(235,235,235)

-- BOTÃO FECHAR
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(180,60,60)

round(close, 8)
stroke(close, 1, Color3.fromRGB(255,120,120), 0.2)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- BOTÃO MINIMIZAR
local mini = Instance.new("TextButton", frame)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-70,0,5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 18
mini.TextColor3 = Color3.new(1,1,1)
mini.BackgroundColor3 = Color3.fromRGB(60,60,60)

round(mini, 8)
stroke(mini, 1, Color3.fromRGB(120,120,120), 0.3)

-- FUNÇÃO DE BOTÃO TOGGLE
local function createToggle(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,-20,0,34)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.fromRGB(235,235,235)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = frame

    round(btn, 10)
    stroke(btn, 1, Color3.fromRGB(100,100,100), 0.4)
    hover(btn)

    btn.MouseButton1Click:Connect(callback)
end

-- TOGGLES
createToggle("ESP ON / OFF", 55, function()
    _G.CONFIG.Enabled = not _G.CONFIG.Enabled
end)

createToggle("Nome ESP", 95, function()
    _G.CONFIG.NameESP = not _G.CONFIG.NameESP
end)

createToggle("Box ESP", 135, function()
    _G.CONFIG.BoxESP = not _G.CONFIG.BoxESP
end)

-- CORES
local colors = {
    {Name="Vermelho", Color=Color3.fromRGB(255,0,0)},
    {Name="Verde", Color=Color3.fromRGB(0,255,0)},
    {Name="Azul", Color=Color3.fromRGB(0,170,255)},
    {Name="Branco", Color=Color3.fromRGB(255,255,255)}
}

local y = 185
for _, v in ipairs(colors) do
    createToggle("Cor: "..v.Name, y, function()
        _G.CONFIG.Color = v.Color
    end)
    y += 40
end

-- MINIMIZAR
local minimized = false
mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(
        frame,
        TweenInfo.new(0.2),
        { Size = minimized and UDim2.new(0,240,0,45) or UDim2.new(0,240,0,300) }
    ):Play()
end)

-- ARRASTAR (PC + MOBILE)
local dragging = false
local dragStart, startPos

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
local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local Languages = {
      Language = 'pt-br', -- Pode mudar (en)
      Words = 'pt-br'
};

local Gui = Instance.new("ScreenGui", plrGui)

local Frame = Instance.new("Frame", Gui)
Frame.Position = UDim2.new(0.25,0,-0.1,0)
Frame.Size = UDim2.new(0.5, 0, 0.9,0)
Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)
Frame.Draggable = true

local uiCorner = Instance.new("UICorner", Frame)
uiCorner.CornerRadius = UDim.new(0,12)

local uiStroke = Instance.new("UIStroke", Frame)

local frameName = Instance.new("TextLabel", Frame)

frameName.TextScaled = true
frameName.Position = UDim2.new(.041,0,-.15,0)
frameName.Font = Enum.Font.GothamBold
frameName.BackgroundTransparency = 1
frameName.TextColor3 = Color3.fromRGB(230,230,230)
frameName.Text = "Treinamento"
frameName.Size = UDim2.new(0.5,0,0.5,0)

local UIC = Instance.new("UICorner")
UIC.CornerRadius = UDim.new(0,6)
local menu = Instance.new("ScrollingFrame", Frame)

menu.Position = UDim2.new(0.045,0,0.2,0)
menu.Size = UDim2.new(0.9,0,.78,0)
menu.BackgroundColor3 = Color3.fromRGB(80,80,80)
UIC.Parent = menu

local min = Instance.new("TextButton", Gui)

min.Visible = false
local UIC3 = Instance.new("UICorner", min)
min.Text = "Abrir"
min.TextScaled = true
min.BackgroundTransparency = .8
min.TextColor3 = Color3.fromRGB(240,240,240)

min.MouseButton1Click:Connect(function()
   Frame.Visible = true
end)

local fechar = Instance.new("TextButton", Frame)

fechar.Text = "X"
fechar.Position = UDim2.new(.85,0,0.03,0)
local UIC2 = Instance.new("UICorner", fechar)
UIC2.CornerRadius = UDim.new(0,99)
fechar.BackgroundColor3 = Color3.fromRGB(255,130,130)
fechar.TextColor3 = Color3.fromRGB(230,230,230)
fechar.Size = UDim2.new(0.1,0,0.13,0)

fechar.MouseButton1Click:Connect(function()
    Frame.Visible = false
end

local UISt2 = Instance.new("UIStroke", menu)
local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local Languages = {
      Language = 'pt-br', -- Pode mudar (en)
      Words = 'pt-br'
};

local Gui = Instance.new("ScreenGui", plrGui)

local Frame = Instance.new("Frame", Gui)
Frame.Position = UDim2.new(0.4,0,-0.1,0)
Frame.Size = UDim2.new(0.5, 0, 0.7,0)
Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)
Frame.Draggable = true

local uiCorner = Instance.new("UICorner", Frame)
uiCorner.CornerRadius = UDim.new(0,12)

local uiStroke = Instance.new("UIStroke", Frame)

local frameName = Instance.new("TextLabel", Frame)

frameName.Position = UDim2.new(0.1,0,-.05,0)
frameName.Font = Enum.Font.GothamBold
frameName.TextScaled = true
frameName.BackgroundTransparency = 1
frameName.TextColor3 = Color3.fromRGB(230,230,230)
frameName.Text = "Core-Gui"

local UIC = Instance.new("UICorner")
UIC.CornerRadius = UDim.new(0,6)
local menu = Instance.new("Frame", Frame)
menu.Position = UDim2.new(0.03,0,0.2,0)
menu.Size = UDim2.new(0.85,0,.6,0)
menu.BackgroundColor3 = Color3.fromRGB(80,80,80)

local min = Instance.new("TextButton", Gui)
min.Visible = false
local UIC3 = Instance.new("UICorner", min)
min.Text = "Abrir"
min.TextScaled = true
min.BackgroundTransparency = .8
min.TextColor3 = Color3.fromRGB(240,240,240)

min.MouseButton1Click:Connect(function(
   Frame.Visible = true
))

local UIS = game.UserInputService
local fechar = Instance.new("TextButton", Frame)
fechar.Text = "X"
fechar.TextScaled = true
local UIC2 = Instance.new("UICorner", fechar)
UIC2.CornerRadius = UDim.new(0,99)
fechar.BackgroundColor3 = Color3.fromRGB(130,130,130)
fechar.TextColor3 = Color3.fromRGB(230,230,230)

fechar.MouseButton1Click:Connect(function(
    Frame.Visible = false
))



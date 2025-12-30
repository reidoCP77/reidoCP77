--====================================
-- Auto JJ's - v1.2.1
-- UI + RemoteChat
--====================================

-- SERVIÇOS
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

-- REMOTE CHAT
local RemoteChat = require("modules/textchat")

-- CONTROLE
local Running = false

-- NUMEROS POR EXTENSO (0 a 100)
local Numbers = {
    [0]="ZERO",[1]="UM",[2]="DOIS",[3]="TRÊS",[4]="QUATRO",[5]="CINCO",
    [6]="SEIS",[7]="SETE",[8]="OITO",[9]="NOVE",[10]="DEZ",
    [11]="ONZE",[12]="DOZE",[13]="TREZE",[14]="QUATORZE",[15]="QUINZE",
    [16]="DEZESSEIS",[17]="DEZESSETE",[18]="DEZOITO",[19]="DEZENOVE",
    [20]="VINTE",[30]="TRINTA",[40]="QUARENTA",[50]="CINQUENTA",
    [60]="SESSENTA",[70]="SETENTA",[80]="OITENTA",[90]="NOVENTA",[100]="CEM"
}

local function NumeroExtenso(n)
    if Numbers[n] then return Numbers[n] end
    local d = math.floor(n / 10) * 10
    local u = n % 10
    return Numbers[d].." E "..Numbers[u]
end

--========================
-- UI
--========================
local Gui = Instance.new("ScreenGui", Player.PlayerGui)
Gui.Name = "AutoJJ"

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(420, 430)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- TÍTULO
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -90, 0, 50)
Title.Position = UDim2.fromOffset(20,0)
Title.BackgroundTransparency = 1
Title.Text = "Auto JJ's - v1.2.1"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Left

-- BOTÕES TOP
local function TopButton(txt, pos)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.fromOffset(40,40)
    b.Position = pos
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 18
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    return b
end

local MinBtn = TopButton("—", UDim2.new(1,-90,0,5))
local CloseBtn = TopButton("X", UDim2.new(1,-45,0,5))

-- INPUTS
local function Input(label, y)
    local t = Instance.new("TextLabel", Main)
    t.Text = label
    t.Font = Enum.Font.Gotham
    t.TextSize = 14
    t.TextColor3 = Color3.fromRGB(200,200,200)
    t.BackgroundTransparency = 1
    t.Position = UDim2.fromOffset(20,y)
    t.Size = UDim2.fromOffset(120,30)
    t.TextXAlignment = Left

    local box = Instance.new("TextBox", Main)
    box.Position = UDim2.fromOffset(150,y)
    box.Size = UDim2.fromOffset(240,30)
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

    return box
end

local FromBox = Input("De:", 70)
local ToBox = Input("Até:", 115)
local IntervalBox = Input("Intervalo:", 160)
local PrefixBox = Input("Prefixo:", 205)

-- CHECKBOX
local function Checkbox(text, y)
    local on = false
    local b = Instance.new("TextButton", Main)
    b.Position = UDim2.fromOffset(20,y)
    b.Size = UDim2.fromOffset(25,25)
    b.Text = ""
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b)

    local l = Instance.new("TextLabel", Main)
    l.Position = UDim2.fromOffset(55,y-3)
    l.Text = text
    l.Font = Enum.Font.Gotham
    l.TextSize = 14
    l.TextColor3 = Color3.new(1,1,1)
    l.BackgroundTransparency = 1

    b.MouseButton1Click:Connect(function()
        on = not on
        b.BackgroundColor3 = on and Color3.fromRGB(0,170,255) or Color3.fromRGB(40,40,40)
    end)

    return function() return on end
end

local IsPular = Checkbox("Pular", 255)
local IsCanguru = Checkbox("Canguru", 290)

-- BOTÕES
local function ActionButton(txt, y, color)
    local b = Instance.new("TextButton", Main)
    b.Position = UDim2.fromOffset(20,y)
    b.Size = UDim2.fromOffset(380,40)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    Instance.new("UICorner", b)
    return b
end

local StartBtn = ActionButton("COMEÇAR", 330, Color3.fromRGB(0,170,0))
local StopBtn  = ActionButton("PARAR", 380, Color3.fromRGB(170,0,0))

--========================
-- FUNCIONALIDADE
--========================
StartBtn.MouseButton1Click:Connect(function()
    if Running then return end
    Running = true

    local from = tonumber(FromBox.Text) or 0
    local to = tonumber(ToBox.Text) or 0
    local interval = tonumber(IntervalBox.Text) or 1
    local prefix = PrefixBox.Text or ""

    task.spawn(function()
        for i = from, to do
            if not Running then break end

            local text = NumeroExtenso(i).." "..prefix
            RemoteChat:Send(text)

            if IsPular() then
                Humanoid.Jump = true
            end

            if IsCanguru() then
                Humanoid.Jump = true
                Root.CFrame *= CFrame.Angles(0, math.rad(360), 0)
            end

            task.wait(interval)
        end
        Running = false
    end)
end)

StopBtn.MouseButton1Click:Connect(function()
    Running = false
end)

--========================
-- BOTÕES TOP
--========================
local Minimized = false

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    MinBtn.Text = Minimized and "T" or "—"

    TweenService:Create(
        Main,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = Minimized and UDim2.fromOffset(420,50) or UDim2.fromOffset(420,430)}
    ):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)
--print("Hello, World!")
--print("Hello, World!")
--====================================
--  Treinamento Físico UI - v1.2.1
--  Script ÚNICO (Auto ScreenGui)
--====================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--========================
-- ScreenGui
--========================
local GUI = Instance.new("ScreenGui")
GUI.Name = "TreinamentoFisicoUI"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.Parent = Player:WaitForChild("PlayerGui")

--========================
-- Utils
--========================
local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = obj
end

local function tween(obj, t, p)
    TweenService:Create(
    obj,
    TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    p
    ):Play()
end

--========================
-- Frame Principal
--========================
local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.45, 0.55)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.Parent = GUI
corner(main, 18)

--========================
-- Drag MAIN (PC + MOBILE)
--========================
do
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(
    startPos.X.Scale,
    startPos.X.Offset + delta.X,
    startPos.Y.Scale,
    startPos.Y.Offset + delta.Y
    )
end

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)
end

--========================
-- Top Bar
--========================
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,48)
top.BackgroundColor3 = Color3.fromRGB(38,38,38)
top.Parent = main
corner(top,18)

local title = Instance.new("TextLabel")
title.Text = "Treinamento Físico - v1.2.1"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.new(0,14,0,0)
title.Parent = top

--========================
-- Botões Topo
--========================
local function topBtn(txt, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(30,30)
    b.Position = UDim2.new(1,x,0,9)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.Parent = top
    corner(b,15)
    return b
end

local close = topBtn("X",-34)
local minimize = topBtn("—",-68)

--========================
-- Conteúdo
--========================
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-20,1,-70)
content.Position = UDim2.new(0,10,0,58)
content.BackgroundTransparency = 1
content.Parent = main

--========================
-- Abas
--========================
local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1,0,0,32)
tabs.BackgroundTransparency = 1
tabs.Parent = content

local function tabButton(text, pos)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Size = UDim2.fromOffset(100,28)
    b.Position = pos
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.Parent = tabs
    corner(b,10)
    return b
end

local tabEtapas = tabButton("Etapas", UDim2.new(0,0,0,0))
local tabCreditos = tabButton("Créditos", UDim2.new(0,110,0,0))

--========================
-- Frames Abas
--========================
local etapasFrame = Instance.new("Frame")
etapasFrame.Size = UDim2.new(1,0,1,-36)
etapasFrame.Position = UDim2.new(0,0,0,36)
etapasFrame.BackgroundTransparency = 1
etapasFrame.Parent = content

local creditosFrame = etapasFrame:Clone()
creditosFrame.Visible = false
creditosFrame.Parent = content

--========================
-- Scroll Etapas
--========================
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarImageTransparency = 0.2
scroll.BackgroundTransparency = 1
scroll.Parent = etapasFrame

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)

--========================
-- FUNÇÃO AUTO JJ's
--========================
local function executarJJs()
    local Options = {
    Keybind = 'Home',
    Tempo = 0.7,
    Rainbow = false,
    Language = {
    UI = 'pt-br',
    Words = 'pt-br'
    },
    }
    
    loadstring(game:HttpGet(
    'https://raw.githubusercontent.com/Zv-yz/AutoJJs/main/Main.lua'
    ))(Options)
end
local function ExecutarVolvers()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/reidoCP77/reidoCP77/refs/heads/main/treinofisicov1.2.1/etapas/volvers.lua"))()
end
--========================
-- Etapas
--========================
local function etapa(txt, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-8,0,44)
    b.Text = txt
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(70,130,255)
    b.Parent = scroll
    corner(b,12)
    
    b.MouseButton1Click:Connect(function()
        if callback then
            callback()
        else
            print(txt)
        end
    end)
end

etapa("Etapa JJ's", executarJJs)
etapa("Etapa Volver's", executarVolvers)
etapa("Etapa Parkour's")
etapa("Etapa Gramatical")


layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

--========================
-- Créditos
--========================
local function credit(txt, y)
    local t = Instance.new("TextLabel")
    t.Text = txt
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextColor3 = Color3.new(1,1,1)
    t.BackgroundTransparency = 1
    t.Position = UDim2.new(0,0,0,y)
    t.Size = UDim2.new(1,0,0,30)
    t.Parent = creditosFrame
end

credit("UI-Designer: GabrielBStar2", 0)
credit("Manager-Developer: yurizando139", 20)
credit("Manager: DoandiepRVaEy", 40)
--========================
-- Sistema Abas
--========================
local function showTab(tab)
    etapasFrame.Visible = (tab == "etapas")
    creditosFrame.Visible = (tab == "creditos")
end

tabEtapas.MouseButton1Click:Connect(function()
    showTab("etapas")
end)

tabCreditos.MouseButton1Click:Connect(function()
    showTab("creditos")
end)

--========================
-- BOTÃO MINI
--========================
local mini = Instance.new("TextButton")
mini.Size = UDim2.fromOffset(44,44)
mini.Text = "T"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 18
mini.TextColor3 = Color3.new(1,1,1)
mini.BackgroundColor3 = Color3.fromRGB(70,130,255)
mini.Visible = false
mini.Parent = GUI
corner(mini,22)

--========================
-- Minimizar / Reabrir
--========================
minimize.MouseButton1Click:Connect(function()
    mini.Position = main.Position
    mini.Visible = true
    tween(main, 0.25, {Size = UDim2.fromOffset(0,0)})
    task.delay(0.25, function()
        main.Visible = false
    end)
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    main.Position = mini.Position
    tween(main, 0.25, {Size = UDim2.fromScale(0.45,0.55)})
    mini.Visible = false
end)

--========================
-- Fechar
--========================
close.MouseButton1Click:Connect(function()
    GUI:Destroy()
end)




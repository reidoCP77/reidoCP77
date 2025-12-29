-- Script em Lua para Roblox Studio
-- Coloque este script em StarterPlayerScripts
-- Ele cria uma GUI interativa com os elementos solicitados, agora mais bonita com UICorner, cores vibrantes e geração de textos gramaticais

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TextosGramaticaisGui"
screenGui.Parent = playerGui

-- Frame principal com UICorner para cantos arredondados
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 430)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(70, 130, 180)  -- Azul militar
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Adicionar UICorner ao mainFrame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Tornar o Frame arrastável
local dragging = false
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    end
end)

-- Título com gradiente
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Textos Gramaticais"
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Parent = mainFrame

-- Adicionar UIGradient ao título para efeito
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),  -- Ouro
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
titleGradient.Parent = titleLabel

-- Texto "Selecione o tema:" com cor
local selectLabel = Instance.new("TextLabel")
selectLabel.Name = "SelectLabel"
selectLabel.Size = UDim2.new(1, 0, 0, 30)
selectLabel.Position = UDim2.new(0, 0, 0, 50)
selectLabel.Text = "Selecione o tema:"
selectLabel.TextSize = 18
selectLabel.Font = Enum.Font.SourceSans
selectLabel.BackgroundTransparency = 1
selectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
selectLabel.Parent = mainFrame

-- ScrollingFrame com UICorner
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 0, 300)
scrollFrame.Position = UDim2.new(0, 10, 0, 90)
scrollFrame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)  -- Azul claro
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 10
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 550)  -- Ajuste conforme necessário
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = scrollFrame

-- Lista de opções
local options = {
    "A importância da CDP",
    "A importância dos Generais",
    "A importância dos Graduados",
    "A importância dos Praças",
    "A importância dos Oficiais",
    "A importância dos recrutamentos",
    "A importância dos treinamentos",
    "Batalhão de Ações de Comandos",
    "Batalhão de Forças Especiais",
    "Batalhão da Polícia do Exército",
    "Centro de Inteligência do Exército",
    "Fauna Brasileira",
    "O que você achou do treino",
    "Por que você deseja adentrar ao EB",
    "Por que você deseja subir de patente"
}

local selectedOption = nil

for i, option in ipairs(options) do
    local optionButton = Instance.new("TextButton")
    optionButton.Name = "OptionButton" .. i
    optionButton.Size = UDim2.new(1, -10, 0, 30)
    optionButton.Position = UDim2.new(0, 5, 0, (i-1)*35)
    optionButton.Text = option
    optionButton.TextSize = 16
    optionButton.Font = Enum.Font.SourceSans
    optionButton.BackgroundColor3 = Color3.fromRGB(173, 216, 230)  -- Azul claro
    optionButton.BorderSizePixel = 0
    optionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    optionButton.Parent = scrollFrame
    
    -- UICorner para botões
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = optionButton
    
    optionButton.MouseButton1Click:Connect(function()
        selectedOption = option
        -- Destacar seleção
        for _, btn in ipairs(scrollFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
            end
        end
        optionButton.BackgroundColor3 = Color3.fromRGB(100, 149, 237)  -- Azul mais escuro
    end)
end

-- Função para gerar texto baseado na opção selecionada
local function generateText(option)
    local texts = {
        ["A importância da CDP"] = "A capacitação de patente é essencial para que Militares sejam promovidos indevidamente, por exemplo, fui promovido á recruta, após 5 minutos me torno Soldado, e assim em diante, a CDP serve para impedir isso.",
        ["A importância dos Generais"] = "Os Generais do Exército Brasileiro desempenham um papel fundamental nas questões administrativas, eles têm como principal objetivo representar o Exército por meio de suas condutas, além de realizar treinamentos e exames.",
        ["A importância dos Graduados"] = "Os Graduados são importantes para garantir que a quantidade de Militares do Exército, cresça cada vez mais, além de serem os denominados heróis para os Praças.",
        ["A importância dos Praças"] = "Os Praças, mais conhecidos como iniciantes do Exército, são responsáveis por monitorar o quartel, treinar, e realizar atividades extras.",
        ["A importância dos Oficiais"] = "Os Oficiais garantem a segurança dentro do quartel, eles mantém a total ordem por meio de suas algemas, e podem realizar treinamentos físicos.",
        ["A importância dos recrutamentos"] = "Os recrutamentos são extremamente importantes no Exército Brasileiro, eles auxiliam a crescer cada vez mais, e mais a quantidade de Militares presentes no Exército.",
        ["A importância dos treinamentos"] = "Os treinamentos são exclusivamente necessários para capacitar os Militares e promove-los por meio de seus esforços, eles ocorrem diariamente, e geralmente são realizado por Oficiais.",
        ["Batalhão de Ações de Comandos"] = "O Batalhão de Ações de Comandos é uma unidade divisional do Exército Brasileiro que atua em operações de combate, na maioria das vezes, pela retaguarda de seus adversários, gerando assim, o grande medo.",
        ["Batalhão de Forças Especiais"] = "O Batalhão de Forças Especiais é uma divisão extremamente capacitada, que atua exclusivamente em combate intensivo e com precisão.",
        ["Batalhão da Polícia do Exército"] = "O Batalhão da Polícia do Exército é responsável por garantir a ordem, a disciplina e a segurança no Exército, eles atuam á todo momento, monitorando as ações realizadas no quartel, e se preciso, ás corrige.",
        ["Centro de Inteligência do Exército"] = "O Centro de Inteligência do Exército é responsável pelo monitoramento intensivo no quartel, eles garantem a proteção de ataques e garantem a segurança no Exército Brasileiro.",
        ["Fauna Brasileira"] = "A fauna brasileira é rica e diversificada, abrigando milhares de espécies diferenes. Preservar a Fauna é fundamental para o equilíbrio do Brasil.",
        ["O que você achou do treino"] = "O treino de hoje foi totalmente perfeito, o instrutor foi rápido, aplicou o treino com precisão e exerceu sua função de forma correta.",
        ["Por que você deseja adentrar ao EB"] = "Eu desejo adentrar ao Exército Brasileiro para agir de forma honesta e subir de patente até o máximo que minha mente permitir, espero que isso seja possível.",
        ["Por que você deseja subir de patente"] = "Desejo ser promovido para poder desbloquear novos salários, ser mais respeitado, além de honrar mais ainda a pátria."      
    }
    return texts[option] or "Texto não disponível para este tema."
end

-- Botão Gerar com UICorner
local generateButton = Instance.new("TextButton")
generateButton.Name = "GenerateButton"
generateButton.Size = UDim2.new(0, 100, 0, 40)
generateButton.Position = UDim2.new(0.5, -50, 0, 390)
generateButton.Text = "Gerar"
generateButton.TextSize = 18
generateButton.Font = Enum.Font.SourceSansBold
generateButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)  -- Verde escuro
generateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
generateButton.Parent = mainFrame

local genCorner = Instance.new("UICorner")
genCorner.CornerRadius = UDim.new(0, 8)
genCorner.Parent = generateButton

-- TextBox para o resultado (editável para copiar)
local resultTextBox = Instance.new("TextBox")
resultTextBox.Name = "ResultTextBox"
resultTextBox.Size = UDim2.new(0, 300, 0, 150)
resultTextBox.Position = UDim2.new(0, 50, 0, 100)  -- Do lado direito do mainFrame
resultTextBox.Text = ""
resultTextBox.TextSize = 14
resultTextBox.Font = Enum.Font.SourceSans
resultTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
resultTextBox.BorderSizePixel = 0
resultTextBox.TextWrapped = true
resultTextBox.MultiLine = true
resultTextBox.ClearTextOnFocus = false
resultTextBox.Visible = false
resultTextBox.Parent = screenGui  -- Fora do mainFrame para posicionar ao lado

local resultCorner = Instance.new("UICorner")
resultCorner.CornerRadius = UDim.new(0, 10)
resultCorner.Parent = resultTextBox

generateButton.MouseButton1Click:Connect(function()
    if selectedOption then
        local generatedText = generateText(selectedOption)
        resultTextBox.Text = generatedText
        resultTextBox.Visible = true
        -- Animação simples para aparecer
        resultTextBox:TweenSize(UDim2.new(0, 300, 0, 150), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    else
        -- Alerta se nada selecionado
        local alert = Instance.new("TextLabel")
        alert.Size = UDim2.new(0, 200, 0, 50)
        alert.Position = UDim2.new(0.5, -100, 0.5, -25)
        alert.Text = "Selecione um tema primeiro!"
        alert.TextSize = 16
        alert.Font = Enum.Font.SourceSansBold
        alert.BackgroundColor3 = Color3.fromRGB(220, 20, 60)  -- Vermelho
        alert.TextColor3 = Color3.fromRGB(255, 255, 255)
        alert.BorderSizePixel = 0
        alert.Parent = screenGui
        local alertCorner = Instance.new("UICorner")
        alertCorner.CornerRadius = UDim.new(0, 8)
        alertCorner.Parent = alert
        wait(2)
        alert:Destroy()
    end
end)

-- Botão Minimizar com UICorner
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 10)
minimizeButton.Text = "-"
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)  -- Ouro
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 5)
minCorner.Parent = minimizeButton

-- Botão pequeno "EG" para quando minimizado
local smallEgButton = Instance.new("TextButton")
smallEgButton.Name = "SmallEgButton"
smallEgButton.Size = UDim2.new(0, 50, 0, 30)
smallEgButton.Position = UDim2.new(0.5, -25, 0.5, -15)
smallEgButton.Text = "EG"
smallEgButton.TextSize = 14
smallEgButton.Font = Enum.Font.SourceSansBold
smallEgButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)  -- Ouro
smallEgButton.TextColor3 = Color3.fromRGB(0, 0, 0)
smallEgButton.Visible = false
smallEgButton.Parent = screenGui

local smallCorner = Instance.new("UICorner")
smallCorner.CornerRadius = UDim.new(0, 5)
smallCorner.Parent = smallEgButton

-- Tornar o smallEgButton arrastável
local draggingSmall = false
local dragInputSmall
local dragStartSmall
local startPosSmall

local function updateInputSmall(input)
    local delta = input.Position - dragStartSmall
    smallEgButton.Position = UDim2.new(startPosSmall.X.Scale, startPosSmall.X.Offset + delta.X, startPosSmall.Y.Scale, startPosSmall.Y.Offset + delta.Y)
end

smallEgButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSmall = true
        dragStartSmall = input.Position
        startPosSmall = smallEgButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingSmall = false
            end
        end)
    end
end)

smallEgButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputSmall = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingSmall and input == dragInputSmall then
        updateInputSmall(input)
    end
end)

smallEgButton.MouseButton1Click:Connect(function()
    -- Restaurar o mainFrame
    mainFrame.Visible = true
    smallEgButton.Visible = false
    mainFrame:TweenSize(UDim2.new(0, 400, 0, 500), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
end)

minimizeButton.MouseButton1Click:Connect(function()
    -- Animação para minimizar
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true, function()
        mainFrame.Visible = false
        smallEgButton.Visible = true
    end)
end)

-- Botão Fechar com UICorner
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 10)
closeButton.Text = "X"
closeButton.TextSize = 20
closeButton.Font = Enum.Font.SourceSansBold
closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)  -- Vermelho
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    -- Animação para fechar
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true, function()
        screenGui:Destroy()
    end)
end)
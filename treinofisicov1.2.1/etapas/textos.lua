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
    "A importância dos CDP",
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
    "O que você achou do treino"
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
        ["A importância dos CDP"] = "Os Centros de Distribuição de Produtos (CDP) desempenham um papel crucial na logística militar, garantindo que suprimentos essenciais cheguem às tropas de forma eficiente e oportuna. Sua organização e rapidez são fundamentais para o sucesso das operações.",
        ["A importância dos Generais"] = "Os Generais são líderes estratégicos que comandam forças militares, tomando decisões críticas que influenciam o rumo das batalhas. Sua experiência e visão tática são essenciais para manter a disciplina e a eficácia das unidades subordinadas.",
        ["A importância dos Graduados"] = "Os Graduados representam a base educada das forças armadas, trazendo conhecimento técnico e habilidades especializadas. Eles contribuem para a inovação e a adaptação às novas tecnologias no campo de batalha.",
        ["A importância dos Praças"] = "As Praças formam a espinha dorsal das forças armadas, executando tarefas operacionais diárias com dedicação. Sua lealdade e resiliência são vitais para a manutenção da ordem e da segurança nacional.",
        ["A importância dos Oficiais"] = "Os Oficiais atuam como intermediários entre o comando superior e as tropas, transmitindo ordens e motivando os subordinados. Sua liderança inspiradora é chave para o moral e a coesão das unidades.",
        ["A importância dos recrutamentos"] = "Os recrutamentos são o processo fundamental para expandir e renovar as forças armadas, selecionando indivíduos aptos e motivados. Um recrutamento eficaz assegura a qualidade e a diversidade do pessoal militar.",
        ["A importância dos treinamentos"] = "Os treinamentos militares preparam os soldados para enfrentar desafios reais, desenvolvendo habilidades físicas e mentais. Eles são essenciais para garantir a prontidão e a competência em situações de combate.",
        ["Batalhão de Ações de Comandos"] = "O Batalhão de Ações de Comandos é uma unidade especializada em operações de alto risco, como resgates e incursões rápidas. Sua elite de guerreiros treinados é fundamental para missões estratégicas e de precisão.",
        ["Batalhão de Forças Especiais"] = "O Batalhão de Forças Especiais opera em ambientes hostis, executando tarefas que exigem extrema habilidade e sigilo. Sua capacidade de adaptação e força letal fazem dele um ativo inestimável na defesa nacional.",
        ["Batalhão da Polícia do Exército"] = "O Batalhão da Polícia do Exército mantém a ordem interna e a segurança nas bases militares, prevenindo crimes e assegurando a disciplina. Sua presença é crucial para a integridade das operações militares.",
        ["Centro de Inteligência do Exército"] = "O Centro de Inteligência do Exército coleta e analisa informações vitais para decisões estratégicas. Sua expertise em espionagem e contrainteligência protege as forças contra ameaças invisíveis.",
        ["Fauna Brasileira"] = "A fauna brasileira é rica e diversificada, abrigando milhares de espécies endêmicas. Preservar essa biodiversidade é essencial para o equilíbrio ecológico e o patrimônio natural do país.",
        ["O que você achou do treino"] = "O treino foi intenso e desafiador, testando meus limites físicos e mentais. Aprendi valiosas lições sobre trabalho em equipe e perseverança, que aplicarei em futuras missões."
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
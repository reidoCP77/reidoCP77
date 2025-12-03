-- isso é um loadscript!!
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local chatEvent = ReplicatedStorage:WaitForChild("Chat")
local playerGui = player:WaitForChild("PlayerGui")
local consGui = playerGui:FindFirstChild("CONSPL")
if not consGui then
    consGui = Instance.new("ScreenGui")
    consGui.Name = "CONSPL"
    consGui.ResetOnSpawn = false
    consGui.Parent = playerGui
end
local textLabel = consGui:FindFirstChild("TextLabel")
if not textLabel then
    textLabel = Instance.new("TextLabel")
    textLabel.Name = "TextLabel"
    textLabel.Size = UDim2.new(0, 250, 0, 50)
    textLabel.Position = UDim2.new(0.5, -125, 0.1, 0)
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.BackgroundTransparency = 0.3
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = "Polichinelos: 0"
    textLabel.Parent = consGui
end
local mensagens = {"ZERO !", "UM !", "DOIS !", "TRÊS !"}
local indice = 1
local canSend = true
local cooldown = 0.5
local function isConsoleEquipped()
    local backpack = player:WaitForChild("Backpack")
    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Console" then
                return true
            end
        end
    end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Console" then
            return true
        end
    end
    return false
end
local function resetSequence()
    indice = 1
    textLabel.Text = "Polichinelos: 0"
end
local function updateLabel()
    textLabel.Text = "Polichinelos: " .. tostring(indice - 1)
end
player.CharacterAdded:Connect(function(char)
    char.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") and child.Name == "Console" then
            resetSequence()
        end
    end)
end)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.DPadRight then
        resetSequence()
        return
    end

    if not canSend then return end

    if isConsoleEquipped() then
        if input.KeyCode == Enum.KeyCode.ButtonB or input.KeyCode == Enum.KeyCode.ButtonCircle then           chatEvent:FireServer(mensagens[indice])
            updateLabel()
            indice = indice + 1
            if indice > #mensagens then
                indice = 1
            end
            canSend = false
            task.delay(cooldown, function()
                canSend = true
            end)
        end
    end
end)
resetSequence()
-- leader-developer GabrielBStar2
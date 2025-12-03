local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local chatEvent = ReplicatedStorage:WaitForChild("Chat")
local playerGui = player:WaitForChild("PlayerGui")
local consGui = playerGui:WaitForChild("CONSPL")
local textLabel = consGui:WaitForChild("TextLabel")
local mensagens = {"ZERO !", "UM !", "DOIS !", "TRÊS !"} -- aq coloca o resto
local indice = 1 
local canSend = true -- se tiver false desativa o cooldown
local cooldown = 0.5 -- tempo pra enviar cada mensagem
local function isConsoleEquipped()
	local backpack = player:WaitForChild("Backpack")
	local character = player.Character
	if character then
		for _, tool in pairs(character:GetChildren()) do
			if tool:IsA("Tool") and tool.Name == "Console" then
				return true
			end
		end
	end
	for _, tool in pairs(backpack:GetChildren()) do
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
	textLabel.Text = "Polichinelos: " .. tostring(indice)
end
player.CharacterAdded:Connect(function(char)
	char.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") and child.Name == "Console" then
			resetSequence()
		end
	end)
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.DPadRight then
		resetSequence()
		return
	end
	if not canSend then return end
	if isConsoleEquipped() then
		if input.KeyCode == Enum.KeyCode.ButtonB or input.KeyCode == Enum.KeyCode.ButtonCircle then
			chatEvent:FireServer(mensagens[indice])
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
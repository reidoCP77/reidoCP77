local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")
local chatEvent = ReplicatedStorage:WaitForChild("Chat")
chatEvent.OnServerEvent:Connect(function(player, message)
	local character = player.Character
	if character then
		local head = character:FindFirstChild("Head")
		if head then
			ChatService:Chat(head, message, Enum.ChatColor.Blue)
		end
	end
end)
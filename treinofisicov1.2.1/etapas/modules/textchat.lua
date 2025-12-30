local RemoteChat = {}
--local Channels = {}
local Connections = {}

local WC = game.WaitForChild
local FFC = game.FindFirstChild

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 95)

local CurrentChannel: TextChannel;
local InputBar = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

local Methods = {
        [Enum.ChatVersion.LegacyChatService] = function(Message: string)
                local ChatUI = PlayerGui:FindFirstChild("Chat")

                if CurrentChannel then
                        CurrentChannel:SendAsync(Message)
                elseif ChatUI then
                        local ChatFrame = WC(ChatUI, "Frame", 95)
                        local CBPF = WC(ChatFrame, "ChatBarParentFrame", 95)

                        local Frame = WC(CBPF, "Frame", 95)
                        local BF = WC(Frame, "BoxFrame", 95)

                        local ChatFM = WC(BF, "Frame", 95)
                        local ChatBar = FFC(ChatFM, "ChatBar", 95)

                        ChatBar:CaptureFocus()
                        ChatBar.Text = Message
                        ChatBar:ReleaseFocus(true)
                end
        end,

        [Enum.ChatVersion.TextChatService] = function(Message: string)
                if CurrentChannel then
                        CurrentChannel:SendAsync(Message)
                end
        end,
}

function RemoteChat:Send(Message: string)
        pcall(Methods[TextChatService.ChatVersion], Message)
end

if InputBar then
        table.insert(Connections, InputBar.Changed:Connect(function(Prop: string)
                if Prop == "TargetTextChannel" and (typeof(InputBar.TargetTextChannel) == "Instance" and InputBar.TargetTextChannel:IsA("TextChannel")) then
                        CurrentChannel = InputBar.TargetTextChannel
                end
        end))

        if typeof(InputBar.TargetTextChannel) == "Instance" and InputBar.TargetTextChannel:IsA("TextChannel") then
                CurrentChannel = InputBar.TargetTextChannel
        end
end

return RemoteChat
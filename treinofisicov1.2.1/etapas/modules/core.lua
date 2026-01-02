local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui", plrGui")

local Frame = Instance.new("Frame", Gui)
Frame.Position = UDim2.new(0.45,0,0.5,0)
Frame.Size = UDim2.new(0.45, 0, 0.46,0)
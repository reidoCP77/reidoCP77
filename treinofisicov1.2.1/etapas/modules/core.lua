local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui", plrGui")

local Frame = Instance.new("Frame", Gui)
Frame.Position = UDim2.new(0.45,0,0.5,0)
Frame.Size = UDim2.new(0.45, 0, 0.46,0)
Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)

local uiCorner = Instance.new("UICorner", Frame)
uiCorner.CornerRadius = UDim.new(0,12)

local frameName = Instance.new("TextLabel", Frame)
frameName.Position = UDim2.new(0.4,0,0.9,0)
frameName.Text = "CoreGui"
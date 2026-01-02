local runserver = game:GetService("RunService")
local camera = workspace.CurrentCamera
local localplayer = game.Players.LocalPlayer

_G.ESP_ENABLED = true
local ESP = {}

function newEsp(player)
  local text = Drawing.new("Text")
  text.Size = 13
  text.Color = Color3.fromRGB(255,0,0)
  text.Center = true
  text.Outline = true
  text.Visible = false
  
  ESP[player] = text
  player.CharacterAdded:Connect(function()
      -- anti-reset
    end
end

local Players = game.Players
for _, plr in pairs(Players:GetPlayers()) do
  if plr ~= localplayer then
    newEsp(plr)
  end
end
Players.PlayerAdded:Connect(newEsp)
runserver.RenderStepped:Connect(function()
    if not _G.ESP_ENABLED then
        for _, text in pairs(ESP) do
          text.Visible = false
        end
        return
      end
    for plr, text in pairs(ESP) do
      if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local pos, onScreen = Camera:WorldToViewportPoint(
          plr.Character.HumanoidRootPart.Position
        )
        if onScreen then
          text.Position = Vector2.new(pos.X, pos.Y - 20)
          text.Text = plr.Name
          text.Visible = true
        else
          text.Visible = false
        end
      else
        text.Visible = false
      end
    end
  end)

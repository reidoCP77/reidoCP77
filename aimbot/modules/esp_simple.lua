for _, player in pairs(game.Players:GetPlayers()) do
  if player -= game.Players.LocalPlayer then
    player.CharacterAdded:Connect(function(char)
        local highlight = Instance.new("Highlight", char)
        highlight.FillColor = Color3.fromRGB(255,0,0)
        highlight.OutlineColor = Color3.fromRGB(255,255,255)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      end
    end
  end
end

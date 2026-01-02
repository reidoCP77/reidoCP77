-- esp_pro.lua
return function(options)

    options = options or {}

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer

    local ESPObjects = {}

    local function CreateESP(player)
        if player == LocalPlayer then return end

        local text = Drawing.new("Text")
        text.Size = 13
        text.Center = true
        text.Outline = true
        text.Visible = false

        ESPObjects[player] = text
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        CreateESP(plr)
    end

    Players.PlayerAdded:Connect(CreateESP)

    RunService.RenderStepped:Connect(function()
        for plr, text in pairs(ESPObjects) do
            if not options.Enabled then
                text.Visible = false
                continue
            end

            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(
                    plr.Character.HumanoidRootPart.Position
                )

                if onScreen then
                    text.Position = Vector2.new(pos.X, pos.Y - 20)
                    text.Text = plr.Name
                    text.Color = options.Color or Color3.fromRGB(255,0,0)
                    text.Visible = options.NameESP ~= false
                else
                    text.Visible = false
                end
            else
                text.Visible = false
            end
        end
    end)
end
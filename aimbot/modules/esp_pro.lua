_G.CONFIG = _G.CONFIG or {
    Enabled = true,
    NameESP = true,
    BoxESP = true,
    Color = Color3.fromRGB(255, 0, 0)
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP = {}

local function createESP(player)
    if ESP[player] then return end

    ESP[player] = {
        Name = Drawing.new("Text"),
        Box = Drawing.new("Square"),
        Character = nil
    }

    local name = ESP[player].Name
    name.Size = 13
    name.Center = true
    name.Outline = true

    local box = ESP[player].Box
    box.Thickness = 1
    box.Filled = false

    player.CharacterAdded:Connect(function(char)
        ESP[player].Character = char
    end)

    if player.Character then
        ESP[player].Character = player.Character
    end
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        createESP(p)
    end
end

Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(function(p)
    if ESP[p] then
        ESP[p].Name:Remove()
        ESP[p].Box:Remove()
        ESP[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if not _G.CONFIG.Enabled then
        for _, v in pairs(ESP) do
            v.Name.Visible = false
            v.Box.Visible = false
        end
        return
    end

    for plr, data in pairs(ESP) do
        local char = data.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)

            if onscreen then
                -- NAME
                data.Name.Visible = _G.CONFIG.NameESP
                data.Name.Text = plr.Name
                data.Name.Color = _G.CONFIG.Color
                data.Name.Position = Vector2.new(pos.X, pos.Y - 25)

                -- BOX
                data.Box.Visible = _G.CONFIG.BoxESP
                data.Box.Color = _G.CONFIG.Color

                local size = (Camera:WorldToViewportPoint(hrp.Position + Vector3.new(2,3,0)) -
                             Camera:WorldToViewportPoint(hrp.Position - Vector3.new(2,3,0)))

                data.Box.Size = Vector2.new(math.abs(size.X), math.abs(size.Y))
                data.Box.Position = Vector2.new(pos.X - data.Box.Size.X/2, pos.Y - data.Box.Size.Y/2)
            else
                data.Name.Visible = false
                data.Box.Visible = false
            end
        else
            data.Name.Visible = false
            data.Box.Visible = false
        end
    end
end)
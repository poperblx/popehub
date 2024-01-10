local PlayerTeleport = {};

for i, spirit in pairs(workspace.Worlds.OnePiece.SpiritPositions:GetChildren()) do
    game:GetService("ReplicatedStorage").Remote.Drops.CaughtSpirit:FireServer()

    for talentToken = 1,3,1
    do
        local args = {
            [1] = "TalentToken",
            [2] = 3
        }
    
        game:GetService("ReplicatedStorage").Remote.Drops.Items:FireServer(unpack(args))
    end

    wait(2)
end
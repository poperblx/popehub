local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;

-- *********************** TELEPORT PLAYER ***********************
function getCurrentPlayerPos()
    if player.Character then
        return player.Character.HumanoidRootPart.Position;
    end
    return false;
end

print(getCurrentPlayerPos())

local player = game.Players.LocalPlayer;

function teleportTo(placeCFrame)
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

teleportTo(CFrame.new(-2154,143,-3074))
-- *********************** TELEPORT PLAYER ***********************
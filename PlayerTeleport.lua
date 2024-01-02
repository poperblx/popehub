local player = game.Players.LocalPlayer;
local PlayerTeleport = {};

function PlayerTeleport.getCurrentPlayerPos()
    if player.Character then
        return player.Character.HumanoidRootPart.Position;
    end
    return false;
end

function PlayerTeleport.teleportTo(placeCFrame)
    if player.Character then
        player.Character:WaitForChild("HumanoidRootPart");
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

return PlayerTeleport
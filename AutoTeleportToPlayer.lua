local player = game.Players.LocalPlayer;

-- *********************** TELEPORT PLAYER ***********************
function getCurrentPlayerPos(target)
    if target.Character then
        return target.Character.HumanoidRootPart.Position;
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

teleportTo(CFrame.new(7250,45,6200))
-- *********************** TELEPORT PLAYER ***********************

function autoTeleportToPlayer()
    local currentPlayerPos = getCurrentPlayerPos(player);
    local targetPlayerPos = getCurrentPlayerPos(game.Players["ImTheGod_027"]);

    if currentPlayerPos.X != targetPlayerPos.X and currentPlayerPos.Y != targetPlayerPos.Y and currentPlayerPos.Z != targetPlayerPos.Z then
        teleportTo(CFrame.new(targetPlayerPos))
    end
end

spawn(function() 
    while true do
        function autoTeleportToPlayer()
            local currentPlayerPos = getCurrentPlayerPos(player);
            local targetPlayerPos = getCurrentPlayerPos(game.Players["ImTheGod_027"]);
        
            if currentPlayerPos.X != targetPlayerPos.X and currentPlayerPos.Y != targetPlayerPos.Y and currentPlayerPos.Z != targetPlayerPos.Z then
                teleportTo(CFrame.new(targetPlayerPos))
            end
        end
        wait(0.1);
    end
end)
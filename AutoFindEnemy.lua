local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local intervalBetweenEnemies = 2;
local worldTarget = workspace.Worlds[player.World.Value];

-- *********************** FIND ENEMIES ***********************
function findEnemies()
    for index,enemy in pairs(worldTarget.Enemies:GetChildren()) do
        if enemy.HumanoidRootPart && enemy.HumanoidRootPart.CFrame then
            teleportTo(enemy.HumanoidRootPart.CFrame);
            wait(intervalBetweenEnemies);
        end
    end
end
-- *********************** FIND ENEMIES ***********************
local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local intervalBetweenEnemies = 2;
local AutoFindEnemy = {};

function AutoFindEnemy.findEnemies()
    if not getgenv().ongoingRaid then
        return nil;
    end
    local enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
    print("finding enemies...")
    if not next(enemies) then
        AutoOpenChest.openChests();
        raidEnd()
    else
        for index,enemy in pairs(enemies) do
            if enemy then
                enemy:WaitForChild("HumanoidRootPart");
                PlayerTeleport.teleportTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0));
                -- respawnPets();
            end
            enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
        end
    end
    wait(intervalBetweenEnemies);
end

return AutoFindEnemy
local PlayerTeleport = loadstring(game:HttpGet('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua'))();
local AutoFindEnemy = {}

function AutoFindEnemy.findEnemies(spawners, enemies)
    for i, spawner in pairs(spawners) do
        if spawnerHasEnemy(spawner.Position) then
            PlayerTeleport.teleportTo(spawner.CFrame)

            repeat
                wait()
            until not spawnerHasEnemy(spawner.Position)
        end
    end
end

function spawnerHasEnemy(spawnerPos, enemies)
    for i,enemy in pairs(workspace.Worlds[player.World.Value].Enemies:GetChildren()) do
        local enemyPos = enemy.HumanoidRootPart.Position;
        if enemyPos.X == spawnerPos.X and enemyPos.Z == spawnerPos.Z then
            return true;
        end
    end

    return false;
end

return AutoFindEnemy;
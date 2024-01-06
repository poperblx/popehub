local PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua')))();
local AutoFindEnemy = {}

function AutoFindEnemy.findEnemies(spawners, enemies)
    for i, spawner in pairs(spawners) do
        if spawnerHasEnemy(spawner.Position, enemies) then
            PlayerTeleport.teleportTo(spawner.CFrame)

            repeat
                wait()
            until not spawnerHasEnemy(spawner.Position, enemies)
        end
    end
end

function spawnerHasEnemy(spawnerPos, enemies)
    for i,enemy in pairs(enemies) do
        if enemy:FindFirstChild("HumanoidRootPart") then
            local enemyPos = enemy.HumanoidRootPart.Position;
            if enemyPos.X == spawnerPos.X and enemyPos.Z == spawnerPos.Z then
                return true;
            end
        end
    end

    return false;
end

return AutoFindEnemy;
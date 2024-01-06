local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local dungeonLayout = {
    {
        ["floorName"] = "1",
        ["rooms"] = {"CrosswalkCorridor","18","35","60","61","37"}
    },
    {
        ["floorName"] = "2",
        ["rooms"] = {"4","3","12","26","25","10","9","2","1","6","17","34","58"}
    },
    {
        ["floorName"] = "3",
        ["rooms"] = {"6","18","35","17","16","32","55","56"}
    }
}

function teleportTo(placeCFrame)
    if player.Character then
        player.Character:WaitForChild("HumanoidRootPart");
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

function waitForZoneCompleted(zone)
    local completed = false;
    while completed do
        if workspace.Worlds[player.World.Value]:FindFirstChild(player.WorldInstanceId.Value).ZonesCompleted:FindFirstChild(zone) then
            completed = true;
            break;
        end

        wait(1);
    end
end

function spawnerHasEnemy(spawnerPos)
    for i,enemy in pairs(workspace.Worlds[player.World.Value].Enemies:GetChildren()) do
        local enemyPos = enemy.HumanoidRootPart.Position;
        if enemyPos.X == spawnerPos.X and enemyPos.Z == spawnerPos.Z then
            return true;
        end
    end

    return false;
end

function startAutoDungeon()
    local dungeon = workspace.Worlds.Dungeons;
    local currentDungeonLayout = {};
    local isFound = false;

    for i,v in ipairs(dungeonLayout) do
        if isFound then
            table.insert(currentDungeonLayout, v)
        elseif v.floorName == player.WorldInstanceId.Value then
            isFound = true;
            table.insert(currentDungeonLayout, v)
        end
    end

    for floorNumber, floor in ipairs(currentDungeonLayout) do
        print("teleporting to floor ", floor.floorName)
        local floorInstance = dungeon:FindFirstChild(floor.floorName);
        teleportTo(floorInstance.Spawns.Default:FindFirstChild("Spawn").CFrame)
        for index, room in ipairs(floor.rooms) do
            if workspace.Worlds[player.World.Value]:FindFirstChild(floor.floorName).ZonesCompleted:FindFirstChild(room) then continue end
            print("teleporting to room ", room)
            local roomInstance = floorInstance:FindFirstChild(room);
            

            if roomInstance:FindFirstChild("EnemySpawners") then
                if roomInstance.EnemySpawners:FindFirstChild("EnemySpawner") then
                    for i, enemySpawner in pairs(roomInstance.EnemySpawners:GetChildren()) do
                        if enemySpawner.Name == "EnemySpawner" then
                            if spawnerHasEnemy(enemySpawner.Position) then
                                teleportTo(enemySpawner.CFrame)
    
                                repeat
                                    wait()
                                until not spawnerHasEnemy(enemySpawner.Position)
                            end
                        end
                    end
                end
                
                if roomInstance.EnemySpawners:FindFirstChild("BossSpawner") then
                    local bossSpawner = roomInstance.EnemySpawners:FindFirstChild("BossSpawner");
                    teleportTo(CFrame.new(bossSpawner.Position) * CFrame.new(0, 50, 0))
    
                    repeat
                        wait()
                    until not spawnerHasEnemy(bossSpawner.Position)
                end

                waitForZoneCompleted(room)
                if roomInstance:FindFirstChild("ZoneCompleteModels") then
                    wait(2)
                    roomInstance.ZoneCompleteModels:FindFirstChild("1").NextFloorTeleporter:WaitForChild("TeleportPart");
                    teleportTo(roomInstance.ZoneCompleteModels:FindFirstChild("1").NextFloorTeleporter.TeleportPart.CFrame)
                    wait(2);
                end
            elseif roomInstance:FindFirstChild("Details") then
                for i, detail in ipairs(roomInstance.Details:GetDescendants()) do
                    print(detail.Name)
                    if detail:IsA("BasePart") then
                        teleportTo(detail.CFrame)
                        wait()
                        break
                    end
                end
            end
            wait(3)
        end
        wait(5)
    end
end

startAutoDungeon();

-- local args = {
--     [1] = "Dungeons",
--     [3] = 1
-- }

-- game:GetService("ReplicatedStorage").Remote.Player.Teleport:FireServer(unpack(args))

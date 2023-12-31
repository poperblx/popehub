local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local raidName = "ChristmasRaid";
local raidDifficulty = "Easy";
local raidCoordinates = CFrame.new(-2071, 136, -3073);
local intervalBetweenEnemies = 2;
local funcName = "attempt_open_chest";
local attemptOpenChest;
getgenv().isRunning = true;
getgenv().ongoingRaid = false;
getgenv().currentPlayerPos = CFrame.new(0,0,0);
getgenv().isLoading = false;
getgenv().currentEnemyCount = 0;
getgenv().newEnemyCount = 0;

-- *********************** TELEPORT PLAYER ***********************
function getCurrentPlayerPos()
    if player.Character then
        return player.Character.HumanoidRootPart.Position;
    end
    return false;
end

function teleportTo(placeCFrame)
    if player.Character then
        player.Character:WaitForChild("HumanoidRootPart");
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end
-- *********************** TELEPORT PLAYER ***********************
-- *********************** FIND ENEMIES ***********************
function findEnemies()
    if not getgenv().ongoingRaid then
        return nil;
    end
    local enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
    print("finding enemies...")
    if not next(enemies) then
        openChests()
        raidEnd()
    else
        for index,enemy in pairs(enemies) do
            if enemy then
                enemy:WaitForChild("HumanoidRootPart");
                teleportTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0));
                -- respawnPets();
            end
            enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
        end
    end
    wait(intervalBetweenEnemies);
end
-- *********************** FIND ENEMIES ***********************
-- *********************** RESPAWN PETS ***********************
function respawnPets()
    for index,pet in pairs(player.Pets:GetChildren()) do
        key = tostring(index)
        remote.Data.SetEquipSlot:FireServer(key);
        wait();
        remote.Data.SetEquipSlot:FireServer(key,pet.Value);
        wait();
    end
end
-- *********************** RESPAWN PETS ***********************
-- *********************** OPEN CHESTS ***********************
function openChests()
    if not getgenv().ongoingRaid then
        return nil
    end

    local chestName = getChestName();
    print(chestName, type(chestName))
    print(player.WorldInstanceId.Value, type(player.WorldInstanceId.Value));
    for i,v in pairs(workspace.Worlds.Raids[player.WorldInstanceId.Value]:GetDescendants()) do
        if v.Name == chestName and v.Parent then
            attemptOpenChest(v);
            wait(0.5);
            teleportTo(v.Parent.ChestSpawn.CFrame);
            wait(3);
        end
    end
end
-- *********************** OPEN CHESTS ***********************
-- *********************** GET CHEST NAME ***********************
function getChestName()
    if raidName == "ChristmasRaid" then
        return "ChristmasChest";
    end

    return "RaidChest";
end
-- *********************** GET CHEST NAME ***********************
-- *********************** START RAID ***********************
function startRaid(name, difficulty)
    -- if getgenv().ongoingRaid or getgenv().isLoading then
    --     return nil
    -- end

    print("starting new raid...")
    getgenv().isLoading = true;
    getgenv().ongoingRaid = true;
  
    local availableRaidRoom = getAvailableRaidRoom();
    teleportTo(availableRaidRoom.CFrame);
    local args = {
        [1] = availableRaidRoom,
        [2] = true
    }

    remote.Raid.SetInRaid:FireServer(unpack(args))

    args = {
        [1] = availableRaidRoom,
        [2] = "HoverWorld",
        [3] = name
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = availableRaidRoom,
        [2] = "TargetWorld",
        [3] = name
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = availableRaidRoom,
        [2] = "HoverWorld",
        [3] = "None"
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = availableRaidRoom,
        [2] = "Difficulty",
        [3] = difficulty
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = availableRaidRoom
    }

    remote.Raid.StartRaidFromRoom:FireServer(unpack(args))

    -- local args = {
    --     [1] = availableRaidRoom,
    --     [2] = false
    -- }

    -- remote.Raid.SetInRaid:FireServer(unpack(args))
    workspace.Worlds:WaitForChild("Raids");
    while not next(workspace.Worlds.Raids.Enemies:GetChildren()) do
        wait(1);
        continue;
    end
    getgenv().isLoading = false;
    
    while getgenv().ongoingRaid do
        findEnemies();
        wait(intervalBetweenEnemies);
    end
end
-- *********************** START RAID ***********************
-- *********************** GET AVAILABLE RAID ROOM ***********************
function getAvailableRaidRoom()
    local availableRaidRoom = nil;
    while availableRaidRoom == nil do
        for index,room in pairs(workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms:GetChildren()) do
            if room.Owner.Value == nil then
                availableRaidRoom = room;
                break;
            end
        end
    end

    return availableRaidRoom;
end
-- *********************** END RAID ***********************
function raidEnd()
    getgenv().isLoading = true;
    remote.Player.Teleport:FireServer("Hub")
    wait(120);
    player.PlayerGui.RaidCompleteGui.Enabled = false;
    getgenv().currentPlayerPos = CFrame.new(0,0,0);
    getgenv().ongoingRaid = false;
    getgenv().isLoading = false;
    if getgenv().isRunning then
        -- startRaid(raidName,raidDifficulty);
    end
end
-- *********************** END RAID ***********************

for i,v in pairs(getgc()) do
    if type(v) == 'function' and getinfo(v).name and getinfo(v).name == funcName then
        attemptOpenChest = v;
        break;
    end
end

startRaid(raidName,raidDifficulty);
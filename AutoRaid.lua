local remote = game:GetService("ReplicatedStorage").Remote
local player = game.Players.LocalPlayer;
local intervalBetweenEnemies = 2;
local AutoFindEnemy = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoFindEnemy.lua')))();
local PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua')))();
local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoOpenChest.lua')))();
local AutoRaid = {};

function AutoRaid.raidEnd()
    if not getgenv().ongoingRaid then
        return false;
    end
    print("ending raid...")
    remote.Player.Teleport:FireServer("Hub")
    waitForWorldToLoad("Hub");
    player.PlayerGui.RaidCompleteGui.Enabled = false;
    getgenv().ongoingRaid = false;
    waitForRaidTimer();

    AutoRaid.startRaid(getgenv().raidName,getgenv().raidDifficulty);
end

function AutoRaid.startRaid(name, difficulty)
    if not getgenv().startRaidToggledOn then
        return false;
    end
    print("starting new raid...")
    getgenv().ongoingRaid = true;
  
    local availableRaidRoom = getAvailableRaidRoom();
    PlayerTeleport.teleportTo(availableRaidRoom.CFrame);
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
    end
    
    while getgenv().ongoingRaid do
        findEnemies();
    end
end

function findEnemies()
    if not getgenv().ongoingRaid then
        return nil;
    end

    local enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
    local currentEnemyId = nil;
    -- if workspace.Worlds[player.World.Value].Hidden:FindFirstChild("ExitRaidTeleporter") then
    --     AutoOpenChest.openChests();
    --     AutoRaid.raidEnd();
    --     return nil;
    -- end

    for index,enemy in pairs(enemies) do
        enemy:WaitForChild("HumanoidRootPart");
        local newEnemyId = enemy:GetDebugId();
        if currentEnemyId != newEnemyId then
            PlayerTeleport.teleportTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0));
            currentEnemyId = newEnemyId;
        end
    end
end

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

function waitForRaidTimer()
    local isRaidAvailable = false;
    while not isRaidAvailable do
        if player.PlayerGui.MainGui.Windows.RaidLobby.Main.Players.QuestTitleHeader.Timer.Text == "0:00" then
            isRaidAvailable = true;
            wait(2);
            break;
        end
        wait(1);
    end
end

function waitForWorldToLoad(world)
    local isWorldLoaded = false;
    while not isWorldLoaded do
        if player.World.Value == world then
            isWorldLoaded = true;
            break;
        end
        wait(1);
    end
    wait(2);
end

return AutoRaid
local PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/AnimeChampionSimulator/main/PlayerTeleport.lua')))();
local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/AnimeChampionSimulator/main/AutoOpenChest.lua')))();
local AutoFindEnemy = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/AnimeChampionSimulator/main/AutoFindEnemy.lua')))();
local remote = game:GetService("ReplicatedStorage").Remote
local player = game.Players.LocalPlayer;
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
    AutoRaid.raidStart();
end

function AutoRaid.raidStart()
    local name = getgenv().raidName;
    local difficulty = getgenv().raidDifficulty;
    if not getgenv().startRaidToggledOn then
        return false;
    end


    print("starting new raid...", name, difficulty)
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
    print("loading world...Raids")
    waitForWorldToLoad("Raids")
    print(player.World.Value, " world loaded")
    while not next(workspace.Worlds.Raids.Enemies:GetChildren()) do
        wait(1);
    end
    
    local worldInstance = workspace.Worlds[player.World.Value]:FindFirstChild(player.WorldInstanceId.Value);
    while getgenv().ongoingRaid do
        if worldInstance.Hidden:FindFirstChild("ExitRaidTeleporter") then
            AutoOpenChest.openChests(worldInstance);
            AutoRaid.raidEnd();
            break;
        end

        autoTeleportToZones(worldInstance);
    end
end

function autoTeleportToZones(worldInstance)
    for index, zone in pairs(worldInstance:GetChildren()) do
        if worldInstance.ZonesCompleted:FindFirstChild(zone) then continue end
        print("teleporting to zone: ", zone)

        if zone:FindFirstChild("EnemySpawners") then
            repeat
                AutoFindEnemy.findEnemies(zone.EnemySpawners:GetChildren(), workspace.Worlds[player.World.Value].Enemies:GetChildren())
            until workspace.Worlds[player.World.Value]:FindFirstChild(player.WorldInstanceId.Value).ZonesCompleted:FindFirstChild(zone)
        end

        if zone:FindFirstChild("ZoneCompleteModels") then
            for i,part in pairs(zone.ZoneCompleteModels:GetDescendants()) do
                if part:IsA("BasePart") and part.Name == "TeleportPart" then
                    PlayerTeleport.teleportTo(part.CFrame)
                    wait(2)
                end
            end
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
        local timer = player.PlayerGui.MainGui.Windows.RaidLobby.Main.Players.QuestTitleHeader.Timer.Text;
        if timer == "0:00" or timer == "3:59" then
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
local remote = game:GetService("ReplicatedStorage").Remote
local player = game.Players.LocalPlayer;
local AutoRaid = {};

function AutoRaid.startRaid(name, difficulty)
    print("starting new raid...")
    getgenv().isLoading = true;
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
    getgenv().isLoading = false;
    
    while getgenv().ongoingRaid do
        AutoFindEnemy.findEnemies();
    end
end

function AutoRaid.raidEnd()
    getgenv().isLoading = true;
    remote.Player.Teleport:FireServer("Hub")
    waitForWorldToLoad("Hub");
    player.PlayerGui.RaidCompleteGui.Enabled = false;
    getgenv().currentPlayerPos = CFrame.new(0,0,0);
    getgenv().ongoingRaid = false;
    getgenv().isLoading = false;

    waitForRaidTimer();

    if getgenv().isRunning then
        startRaid(raidName,raidDifficulty);
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
            break;
        end
    end
end

function waitForWorldToLoad(world)
    local isWorldLoaded = false;
    while not isWorldLoaded do
        if player.World.Value == world then
            isWorldLoaded = true;
            break;
        end
    end
end

return AutoRaid
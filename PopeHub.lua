local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local funcName = "attempt_open_chest";
local currentEnemy = nil;
getgenv().attemptOpenChest = nil;

getgenv().raidName = "ChristmasRaid";
getgenv().raidDifficulty = "Easy";

getgenv().isRunning = true;
getgenv().startRaidToggledOn = false;
getgenv().ongoingRaid = false;
getgenv().currentEnemyCount = 0;
getgenv().newEnemyCount = 0;

local raidNameMapping = {
    ["Holiday Raid"] = "ChristmasRaid",
    ["Green Planet"] = "DBZRaid",
    ["Pirate Town"] = "OnePieceRaid",
    ["Hero Academy"] = "MHARaid",
    ["Ninja Village"] = "NarutoRaid",
    ["Bizarre Bazaar"] = "JojoRaid",
    ["Demon Forest"] = "DemonSlayerRaid",
    ["Cursed City"] = "JJKRaid",
    ["Spirit Town"] = "BleachRaid",
    ["Land of Ants"] = "HxHRaid",
    ["Sawblade City"] = "ChainsawRaid",
    ["Land of Giants"] = "AotRaid",
    ["Marine's Fortress"] = "OnePiece2Raid"
}

local Window = Rayfield:CreateWindow({
    Name = "Pope Hub (Beta)",
    LoadingTitle = "Loading Pope Hub",
    LoadingSubtitle = "by Pope",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = popehub,
       FileName = "Pope Hub"
    },
    Discord = {
       Enabled = true,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
       Title = "Pope Hub",
       Subtitle = "Link in Discord Server",
       Note = "Join server for more updates. Pope Hub is still in the early stages of development, raise it on the discord server for any bugs.",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"2Z9lgT6sBY"}
    }
 })

if game.PlaceId == 14433762945 then
   print("Anime Champions Simulator detected...")
end

-- *********** PlayerTeleport.lua *****************
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
-- *********** PlayerTeleport.lua *****************
-- *********** AutoOpenChest.lua *****************
function openChests()
    if not getgenv().ongoingRaid then
        return nil
    end

    local chestName = getChestName();
    for i,v in pairs(workspace.Worlds.Raids[player.WorldInstanceId.Value]:GetDescendants()) do
        if v.Name == chestName and v.Parent then
            getgenv().attemptOpenChest(v);
            wait(0.5);
            teleportTo(v.Parent.ChestSpawn.CFrame);
            wait(3);
        end
    end
end

function getChestName()
    if getgenv().raidName == "ChristmasRaid" then
        return "ChristmasChest";
    end

    return "RaidChest";
end

function init()
    print("initializing open chest function...")
    for i,v in pairs(getgc()) do
        if type(v) == 'function' and getinfo(v).name and getinfo(v).name == funcName then
            getgenv().attemptOpenChest = v;
            break;
        end
    end

    getChestName();
end
-- *********** AutoOpenChest.lua *****************
-- *********** AutoRaid.lua *****************
function raidEnd()
    if not getgenv().ongoingRaid then
        return false;
    end
    print("ending raid...")
    remote.Player.Teleport:FireServer("Hub")
    waitForWorldToLoad("Hub");
    player.PlayerGui.RaidCompleteGui.Enabled = false;
    getgenv().ongoingRaid = false;

    startRaid(getgenv().raidName,getgenv().raidDifficulty);
end

function startRaid(name, difficulty)
    if not getgenv().startRaidToggledOn then
        return false;
    end

    waitForRaidTimer();

    print("starting new raid...", name, difficulty)
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
    end
    
    while getgenv().ongoingRaid do
        if workspace.Worlds[player.World.Value]:FindFirstChild(player.WorldInstanceId.Value).Hidden:FindFirstChild("ExitRaidTeleporter") then
            openChests();
            raidEnd();
            break;
        end

        findEnemies();
    end
end

function findEnemies()
    -- local enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
    -- if not next(enemies) then
    --     return nil;
    -- end

    -- if currentEnemy == nil then
    --     currentEnemy = enemies[1];
    --     return nil;
    -- end

    -- local newEnemy = enemies[1];

    -- if not newEnemy:FindFirstChild("HumanoidRootPart") then
    --     return nil;
    -- end

    -- if currentEnemy:GetDebugId() ~= newEnemy:GetDebugId() then
    --     PlayerTeleport.teleportTo(newEnemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0));
    --     currentEnemy = newEnemy;
    -- end
    -- wait();
    local currentEnemyId = nil;
    print("finding enemies...")
    local enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren()
    for index,enemy in pairs(enemies) do
        if enemy:FindFirstChild("HumanoidRootPart") then
            local newEnemyId = enemy:GetDebugId();
            print("Target: ", enemy.Name, newEnemyId)
            if currentEnemyId ~= newEnemyId then
                teleportTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0));
                currentEnemyId = newEnemyId;
            end
        end
        wait(2);
        enemies = workspace.Worlds[player.World.Value].Enemies:GetChildren();
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
-- *********** AutoRaid.lua *****************
local RaidTab = Window:CreateTab("Raids", nil)
local RaidSection = RaidTab:CreateSection("Raid Settings")

local RaidStartToggle = RaidTab:CreateToggle({
   Name = "Start Raid",
   CurrentValue = false,
   Flag = "startRaidToggle",
   Callback = function(Value)
    getgenv().startRaidToggledOn = Value;
    if not Value then
        return false;
    end
    startRaid(getgenv().raidName,getgenv().raidDifficulty);
   end,
})

local RaidEndButton = RaidTab:CreateButton({
    Name = "End Raid",
    Interact = 'Click',
    Callback = function()
        RaidStartToggle:Set(false);
        getgenv().startRaidToggledOn = false;
        raidEnd();
    end,
 })

local RaidNameDropdown = RaidTab:CreateDropdown({
   Name = "Worlds",
   Options = {"Holiday Raid","Green Planet","Pirate Town","Hero Academy","Ninja Village","Bizarre Bazaar","Demon Forest",
   "Cursed City","Spirit Town","Land of Ants","Sawblade City","Land of Giants","Marine's Fortress"},
   CurrentOption = {"Holiday Raid"},
   MultipleOptions = false,
   Flag = "raidNameDropdown",
   Callback = function(Option)
    getgenv().raidName = raidNameMapping[Option[1]];
   end,
})

local RaidDifficultyDropdown = RaidTab:CreateDropdown({
   Name = "Difficulty",
   Options = {"Easy","Medium","Hard","Impossible","Nightmare"},
   CurrentOption = {"Easy"},
   MultipleOptions = false,
   Flag = "raidDifficultyDropdown",
   Callback = function(Option)
    getgenv().raidDifficulty = Option[1];
   end,
})

print("initializing pope hub...")
init();
print("starting pope hub...")
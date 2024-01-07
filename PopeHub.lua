local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoOpenChest.lua')))();
local AutoRaid = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoRaid.lua')))();
local DiscordClient = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/DiscordClient.lua')))();
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
    ["Marine's Fortress"] = "OnePiece2Raid",
    ["Virtual Palace"] = "SAORaid"
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

local RaidTab = Window:CreateTab("Raids", nil)
local RaidSection = RaidTab:CreateSection("Raid Settings")

local RaidStartToggle = RaidTab:CreateToggle({
   Name = "Start Raid",
   CurrentValue = false,
   Flag = "startRaidToggle",
   Callback = function(Value)
    getgenv().startRaidToggledOn = Value;
    print("Start raid toggled ", getgenv().startRaidToggledOn)
    if not Value then
        return false;
    end

    AutoRaid.raidStart();
   end,
})

local RaidEndButton = RaidTab:CreateButton({
    Name = "End Raid",
    Interact = 'Click',
    Callback = function()
        RaidStartToggle:Set(false);
        getgenv().startRaidToggledOn = false;
        AutoRaid.raidEnd();
    end,
 })

local RaidNameDropdown = RaidTab:CreateDropdown({
   Name = "Worlds",
   Options = {"Holiday Raid","Green Planet","Pirate Town","Hero Academy","Ninja Village","Bizarre Bazaar","Demon Forest",
   "Cursed City","Spirit Town","Land of Ants","Sawblade City","Land of Giants","Marine's Fortress","Virtual Palace"},
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

function init()
    print("initializing pope hub...")
    AutoOpenChest.init();

    DiscordClient.notifyLogin(player.Name)
end


print("starting pope hub...")
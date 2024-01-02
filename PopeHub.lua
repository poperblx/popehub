local player = game.Players.LocalPlayer;

getgenv().branchName = "main";
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

local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/' ..getgenv().branchName.. '/AutoOpenChest.lua')))();
local AutoRaid = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/' ..getgenv().branchName.. '/AutoRaid.lua')))();
print("initializing pope hub...")
AutoOpenChest.init();
print("starting pope hub...")


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

if game.PlaceId == 14433762945 then
   print("Anime Champions Simulator detected...")
end

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
    print("starting raid...", getgenv().raidName, getgenv().raidDifficulty)
    AutoRaid.startRaid(getgenv().raidName,getgenv().raidDifficulty);
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
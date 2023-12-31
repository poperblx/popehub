local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;

getgenv().raidName = "ChristmasRaid";
getgenv().raidDifficulty = "Medium";

getgenv().isRunning = true;
getgenv().ongoingRaid = false;
getgenv().currentPlayerPos = CFrame.new(0,0,0);
getgenv().isLoading = false;
getgenv().currentEnemyCount = 0;
getgenv().newEnemyCount = 0;
getgenv().timeBeforeRaidAvailable = 120;

local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoOpenChest.lua')))();
local AutoRaid = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoRaid.lua')))();

print("initializing pope hub...")
AutoOpenChest.init();
print("starting pope hub...")
AutoRaid.startRaid(getgenv().raidName,getenv().raidDifficulty);
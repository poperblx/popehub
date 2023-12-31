local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;

getgenv().raidName = "ChristmasRaid";
getgenv().raidDifficulty = "Easy";

getgenv().isRunning = true;
getgenv().ongoingRaid = false;
getgenv().currentPlayerPos = CFrame.new(0,0,0);
getgenv().isLoading = false;
getgenv().currentEnemyCount = 0;
getgenv().newEnemyCount = 0;
getgenv().timeBeforeRaidAvailable = 120;

local AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoOpenChest.lua')))();
local PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua')))();
local AutoFindEnemy = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoFindEnemy.lua')))();
local AutoRaid = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoRaid.lua')))();

AutoOpenChest.init();

AutoRaid.startRaid(getgenv().raidName,getenv().raidDifficulty);
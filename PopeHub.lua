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

getgenv().AutoOpenChest = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoOpenChest.lua')))();
getgenv().AutoRaid = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoRaid.lua')))();
getgenv().PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua')))();
getenv().AutoFindEnemy = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/AutoFindEnemy.lua')))();
print("initializing pope hub...")
getgenv().AutoOpenChest.init();
print("starting pope hub...")
getgenv().AutoRaid.startRaid("ChristmasRaid","Medium");
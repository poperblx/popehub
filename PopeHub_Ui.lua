local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

if game.PlaceId == 14433762945 then
   print("Anime Champions Simulator detected...")
end

local Window = Rayfield:CreateWindow({
    Name = "Pope Hub (Beta)",
    LoadingTitle = "Loading Pope Hub",
    LoadingSubtitle = "by Pope",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = popehub,
       FileName = "Pope Hub"
    },
    Discord = {
       Enabled = true,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = false, -- Set this to true to use our key system
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

local RaidTab = Window:CreateTab("Raids", nil) -- Title, Image
local RaidSection = RaidTab:CreateSection("Raid Settings")

local StartRaidToggle = RaidTab:CreateToggle({
   Name = "Start Raid",
   CurrentValue = false,
   Flag = "startRaidToggle",
   Callback = function(Value)
      print("starting raid...")
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
      print("Selected option is ", Option[1])
   end,
})

local RaidDifficultyDropdown = RaidTab:CreateDropdown({
   Name = "Difficulty",
   Options = {"Easy","Medium","Hard","Impossible","Nightmare"},
   CurrentOption = {"Easy"},
   MultipleOptions = false,
   Flag = "raidDifficultyDropdown",
   Callback = function(Option)
      print("Selected option is ", Option[1])
   end,
})
--  Section:Set("Raid Content")
--  Rayfield:Destroy()
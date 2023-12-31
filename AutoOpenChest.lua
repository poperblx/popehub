local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;
local funcName = "attempt_open_chest";
getgenv().attemptOpenChest = nil;
local PlayerTeleport = loadstring(game:HttpGet(('https://raw.githubusercontent.com/poperblx/popehub/main/PlayerTeleport.lua')))();
local AutoOpenChest = {};

function AutoOpenChest.openChests()
    if not getgenv().ongoingRaid then
        return nil
    end

    local chestName = getChestName();
    for i,v in pairs(workspace.Worlds.Raids[player.WorldInstanceId.Value]:GetDescendants()) do
        if v.Name == chestName and v.Parent then
            getgenv().attemptOpenChest(v);
            wait(0.5);
            PlayerTeleport.teleportTo(v.Parent.ChestSpawn.CFrame);
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

function AutoOpenChest.init()
    print("initializing open chest function...")
    for i,v in pairs(getgc()) do
        if type(v) == 'function' and getinfo(v).name and getinfo(v).name == funcName then
            getgenv().attemptOpenChest = v;
            break;
        end
    end

    getChestName();
end

return AutoOpenChest
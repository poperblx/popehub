local remote = game:GetService("ReplicatedStorage").Remote
local player = game.Players.LocalPlayer;
local raidName = "ChristmasRaid";
local raidDifficulty = "Medium";
local raidCoordinates = CFrame.new(-2071, 136, -3073);

-- *********************** START RAID ***********************
function teleportTo(placeCFrame)
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

function startRaid(name, difficulty)
    teleportTo(raidCoordinates);
    local args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = true
    }

    remote.Raid.SetInRaid:FireServer(unpack(args))

    args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = "HoverWorld",
        [3] = name
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = "TargetWorld",
        [3] = name
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = "HoverWorld",
        [3] = "None"
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = "Difficulty",
        [3] = difficulty
    }

    remote.Raid.SetRaidSetting:FireServer(unpack(args))

    args = {
        [1] = workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4
    }

    remote.Raid.StartRaidFromRoom:FireServer(unpack(args))

    local args = {
        [1] = game:GetService("ReplicatedStorage").UnloadedWorlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms.Room4,
        [2] = false
    }

    remote.Raid.SetInRaid:FireServer(unpack(args))

end
-- *********************** START RAID ***********************
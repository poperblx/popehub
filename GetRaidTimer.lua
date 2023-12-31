local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;

for index,room in pairs(workspace.Worlds.Hub.DungeonTemple:FindFirstChild("1").RaidRooms:GetChildren()) do
    print(room.Settings);
    for i,setting in pairs(room.Settings:GetChildren()) do
        print(i, setting);
    end
end

local x = os.clock()
local s = 0
wait(5)
print(string.format("elapsed time: %.2f\n", os.clock() - x))